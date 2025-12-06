;; desktop.scm --- Nyctibius Desktop Services
;; -*- mode: scheme; -*-
;;
;; SPDX-License-Identifier: GPL-3.0-or-later
;; Copyright © 2025 Urutau-Ltd <softwarelibre@urutau-ltd.org>
;;
;;   , _ ,      _    _            _                     _ _      _
;;  ( o o )    | |  | |          | |                   | | |    | |
;; /'` ' `'\   | |  | |_ __ _   _| |_ __ _ _   _ ______| | |_ __| |
;; |'''''''|   | |  | | '__| | | | __/ _` | | | |______| | __/ _` |
;; |\\'''//|   | |__| | |  | |_| | || (_| | |_| |      | | || (_| |
;;    """       \____/|_|   \__,_|\__\__,_|\__,_|      |_|\__\__,_|
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.
;;
;; Commentary:
;;
;; This moduile acts as a service provider that attempts to fix the missing
;; mate-screensaver features in GNU Guix.

(define-module (nyctibius services desktop)
  #:use-module (nyctibius packages mate) ;; Use our mate-extra instead of GUIX's mate
  #:use-module (gnu services)
  #:use-module (gnu services dbus)
  #:use-module (gnu system pam)
  #:use-module (guix packages)
  #:use-module (guix records))

(define (package-direct-input-selector tree)
  "Return a procedure that selects TREE from the inputs of PACKAGE.  If TREE
is a list, it recursively searches it until it locates the last item of TREE."
  (lambda (package)
    (let loop ((tree (if (pair? tree)
                         tree
                         (list tree)))
               (package package))
      (if (null? tree)
          package
          (loop (cdr tree)
                (car (assoc-ref (package-direct-inputs package)
                                (car tree))))))))

;; Nyctibius MATE Desktop service.
(define-record-type* <mate-desktop-configuration> mate-desktop-configuration
  make-mate-desktop-configuration
  mate-desktop-configuration?
  (mate-package mate-package (default mate-extra)))

(define (mate-polkit-extension config)
  "Return the list of packages for CONFIG's MATE package that extend polkit."
  (let ((mate (mate-package config)))
    (map (lambda (input)
           ((package-direct-input-selector input) mate))
         '("mate-system-monitor"                  ;kill, renice processes
           "mate-settings-daemon"                 ;date/time settings
           "mate-power-manager"                   ;modify brightness
           "mate-control-center"                  ;RandR, display properties FIXME
           "mate-applets"))))                     ;CPU frequency scaling

(define (mate-pam-services config)
  (list (unix-pam-service "mate-screensaver")))

(define mate-desktop-service-type
  (service-type
   (name 'mate-desktop)
   (extensions
    (list (service-extension polkit-service-type
                             mate-polkit-extension)
          (service-extension pam-root-service-type
                             mate-pam-services)
          (service-extension profile-service-type
                             (compose list
                                      mate-package))))
   (default-value (mate-desktop-configuration))
   (description "Run the MATE desktop environment.")))
