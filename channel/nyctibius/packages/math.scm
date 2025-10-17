;;; This module extends GNU Guix and is licensed under the same terms, those
;;; of the GNU GPL version 3 or (at your option) any later version.
;;;
;;; Copyright © 2022, 2023, 2024 Inria
(define-module (nyctibius packages math)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages autotools)
  ;; Conflicts with guix/build/utils, so use prefix
  #:use-module ((gnu packages base)
                #:prefix base:)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages geo)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages swig)
  #:use-module (guix build utils)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix))

(define-public freefem
  (package
    (name "freefem")
    (version "4.15")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/FreeFem/FreeFem-sources")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1a1n9yvyn4g16x562l17ciisaikhl8xsqsqwgjggxj03mh4c9a49"))))
    (build-system gnu-build-system)
    (arguments
     (list
      ;; Disable ISA extension optimizations (SSE, etc.) that are based on
      ;; the build machine's /proc/cpuinfo.
      #:configure-flags #~(list "--enable-generic"
                                "--enable-optim"
                                "--enable-summary")

      #:phases #~(modify-phases %standard-phases
                   (add-before 'check 'skip-faulty-tests
                     (lambda _
                       (substitute* "examples/3d/Makefile"
                         (("schwarz-nm-3d.edp")
                          ""))
                       (substitute* "examples/3dSurf/Makefile"
                         (("testvtk\\.edp")
                          "")))))))
    (native-inputs (list autoconf
                         automake
                         unzip
                         base:which
                         bison
                         flex
                         pkg-config
                         gfortran))
    (inputs (list ;petsc-openmpi
                  petsc
                  bash-minimal
                  gsl
                  ipopt
                  nlopt
                  mumps ;FIXME: ./configure fails to use mumps
                  (list mmg "lib")
                  suitesparse-umfpack
                  suitesparse-config
                  suitesparse-amd
                  suitesparse-cholmod
                  hdf5
                  fftw
                  freeglut
                  arpack-ng
                  scalapack
                  scotch
                  pt-scotch
                  perl
                  tetgen
                  metis
                  openmpi
                  lapack))
    (properties `((tunable? . #t)))
    (home-page "https://freefem.org/")
    (synopsis "High-level multiphysics finite element library")
    (description
     "FreeFEM is a partial differential equation solver for non-linear
multi-physics systems in 2D and 3D using the finite element method.

Problems involving partial differential equations from several branches of
physics such as fluid-structure interactions require interpolations of data
on several meshes and their manipulation within one program.

FreeFEM includes a fast interpolation algorithm and a language for the
manipulation of data on multiple meshes. It is written in C++ and the FreeFEM
language is a C++ idiom.")
    (license license:lgpl3+)))
