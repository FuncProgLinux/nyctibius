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
    #:use-module (gnu packages golang-build)
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

;; MemGuard Libraries
(define-public go-github-com-awnumar-memcall
  (package
    (name "go-github-com-awnumar-memcall")
    (version "0.5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/awnumar/memcall")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "13iri047l53xlcgxgzp165hf2n2wfx1lm73803ipn3z3yhwmndw2"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/awnumar/memcall"))
    (propagated-inputs (list go-golang-org-x-sys))
    (home-page "https://github.com/awnumar/memcall")
    (synopsis "memcall")
    (description
     "This package provides a cross-platform wrapper over some common memory-related
system calls.")
    (license license:asl2.0)))

(define-public go-lukechampine-com-frand
  (package
    (name "go-lukechampine-com-frand")
    (version "1.5.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/lukechampine/frand")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "10dspd6xh7gic8ih7frqvfqqzbnsk9grvqd5djyic173i1jphcpl"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "lukechampine.com/frand"))
    (home-page "https://lukechampine.com/frand")
    (synopsis "frand")
    (description
     "@@code{frand} is a fast CSPRNG in userspace, implemented as a lightweight
wrapper around the @@url{https://go.dev/src/math/rand/v2/chacha8.go,(code
(math/rand/v2).@code{ChaCha8})} generator.  The initial cipher key is derived
from the kernel CSPRNG, after which .")
    (license license:expat)))

(define-public go-github-com-awnumar-memguard
  (package
    (name "go-github-com-awnumar-memguard")
    (version "0.23.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/awnumar/memguard")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1s20frd5k2d5lz9jyiw8x0xwkz7sg4b30q4ckds5lqwafcylcbw2"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/awnumar/memguard"))
    (propagated-inputs (list go-lukechampine-com-frand go-golang-org-x-sys
                             go-golang-org-x-crypto
                             go-github-com-awnumar-memcall))
    (home-page "https://github.com/awnumar/memguard")
    (synopsis "MemGuard")
    (description
     "Package memguard implements a secure software enclave for the storage of
sensitive information in memory.")
    (license license:asl2.0)))
