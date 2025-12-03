;; golang-xyz.scm --- Go dependency packages -*- mode: scheme; -*-
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
(define-module (nyctibius packages golang-xyz)
    #:use-module ((guix licenses)
                #:prefix license:)
    #:use-module (guix git-download)
    #:use-module (guix gexp)
    #:use-module (guix utils)
    #:use-module (guix packages)
    #:use-module (guix build-system go)
    #:use-module (gnu packages)
    #:use-module (gnu packages golang)
    #:use-module (gnu packages golang-check)
    #:use-module (gnu packages golang-xyz))

(define-public go-github-com-alecthomas-jsonschema
  (package
    (name "go-github-com-alecthomas-jsonschema")
    (version "0.0.0-20220216202328-9eeeec9d044b")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/alecthomas/jsonschema")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "011pks7djc9f62dikwbz7pgs6714nqmzqlq78imv3wq5gsgqyy2m"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/alecthomas/jsonschema"))
    (propagated-inputs (list go-github-com-stretchr-testify
                             go-github-com-iancoleman-orderedmap))
    (home-page "https://github.com/alecthomas/jsonschema")
    (synopsis "Generate JSON Schemas from Go types")
    (description
     "Package jsonschema uses reflection to generate JSON Schemas from Go types")
    (license license:expat)))
