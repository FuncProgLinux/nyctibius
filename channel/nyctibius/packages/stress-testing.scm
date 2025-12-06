;; stress-testing.scm --- Security tools for stress testing -*- mode: scheme; -*-
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
(define-module (nyctibius packages stress-testing)
    #:use-module ((guix licenses)
                #:prefix license:)
    #:use-module (guix git-download)
    #:use-module (guix gexp)
    #:use-module (guix utils)
    #:use-module (guix packages)
    #:use-module (guix build-system go)
    #:use-module (gnu packages)
    #:use-module (gnu packages golang)
    #:use-module (gnu packages golang-build)
    #:use-module (gnu packages golang-xyz)
    #:use-module (nyctibius packages golang-xyz))

(define-public vegeta
  (package
   (name "vegeta")
   (version "12.13.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
            (url "https://github.com/tsenart/vegeta")
            (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1qzw2qgsv11rbasx33jz82kkgi8q8blq0p4s911sm2cx8hcrp3qa"))))
   (build-system go-build-system)
   (native-inputs (list go-github-com-alecthomas-jsonschema
                        go-github-com-bmizerany-perks-quantile
                        go-github-com-google-go-cmp
                        go-github-com-mailru-easyjson
                        go-github-com-miekg-dns
                        go-github-com-prometheus-client-golang))
   (home-page "https://github.com/tsenart/vegeta/")
   (synopsis "HTTP load testing tool and library")
   (description "Vegeta is a versatile HTTP load testing tool built out of a need to drill HTTP services with a constant request rate!")
   (license license:expat)))
