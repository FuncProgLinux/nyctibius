;;; emacs-xyz.scm --- Emacs Packages not yet in Guix -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;; Copyright © 2025 Urutau-Ltd <softwarelibre@urutau-ltd.org>
;;;
;;;   , _ ,      _    _            _                     _ _      _
;;;  ( o o )    | |  | |          | |                   | | |    | |
;;; /'` ' `'\   | |  | |_ __ _   _| |_ __ _ _   _ ______| | |_ __| |
;;; |'''''''|   | |  | | '__| | | | __/ _` | | | |______| | __/ _` |
;;; |\\'''//|   | |__| | |  | |_| | || (_| | |_| |      | | || (_| |
;;;    """       \____/|_|   \__,_|\__\__,_|\__,_|      |_|\__\__,_|
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;;; General Public License for more details.
;;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program. If not, see <https://www.gnu.org/licenses/>.
(define-module (nyctibius packages emacs-xyz)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz))


;;; emacs-xyz.scm ends here.
