;; tuta.scm --- Tuta Appimage Script launcher service
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
;; This module acts as a service provider for the tuta mail service on Guix
;; installations. Since the original source for Tuta is built with Rust,
;; Typescript and whatnot, it's not impossible but tedious asf to build
;; from scratch at guix. To avoid relying on the nonfree channel, this
;; module ships a small GNU Bash script that aids in the download of the
;; official AppImage client and wraps it nicely on a Guix Shell container
;; for your convinience. It comes with secrets integration and a custom
;; desktop file.
(define-module (nyctibius services tuta)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services dotfiles)
  #:use-module (guix gexp)
  #:export (tuta-container-services tuta-desktop-services))

(define tuta-container-services
  (simple-service 'tuta-container-service home-files-service-type
                  `((".local/bin/tuta" ,(local-file "./aux-files/tuta/tuta"
                                                    #:recursive? #t)))))

(define tuta-desktop-services
  (simple-service 'tuta-desktop-service home-files-service-type
                  (append `((".local/share/applications/tutanota-desktop.desktop" ,
                             (local-file
                              "./aux-files/tuta/tutanota-desktop.desktop"))))))

;; tuta.scm ends here.
