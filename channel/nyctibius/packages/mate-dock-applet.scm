(define-module (nyctibius packages mate-dock-applet)
  #:use-module (guix git-download)
  #:use-module (gnu packages freedesktop)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system python)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages mate)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (nyctibius packages ubuntu))

(define-public mate-dock-applet
  (package
    (name "mate-dock-applet")
    (version "21.10.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ubuntu-mate/mate-dock-applet")
             (recursive? #f)
             (commit "21.10.0")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1zs73w1r8irg7sg1a0rzqr1nb9556vlj1jipc2zxl67i94yqw6p5"))))
    (build-system glib-or-gtk-build-system)
    (arguments
     (list
      #:imported-modules `((guix build glib-or-gtk-build-system)
                           ,@%python-build-system-modules)
      #:modules '((guix build python-build-system)
                  ((guix build glib-or-gtk-build-system)))
      #:configure-flags
      #~(list (string-append "--prefix="
                             (assoc-ref %outputs "out")) "--with-gtk3")))
    (native-inputs `(("pkg-config" ,pkg-config)
                     ("autoconf" ,autoconf)
                     ("automake" ,automake)
                     ("gettext" ,gettext-minimal)
                     ("python-distutils-extra" ,python-distutils-extra)
                     ("gobject-introspection" ,gobject-introspection)
                     ("python-wrapper" ,python-wrapper)))
    (inputs (list gtk+
                  bamf
                  mate-panel
                  libnotify
                  libwnck
                  python-distro
                  python-pycairo
                  python-dbus
                  python-pyxdg
                  python-xdg
                  python-xlib
                  python-pillow
                  python-pygobject))
    (home-page "https://github.com/ubuntu-mate/mate-dock-applet/tree/master")
    (synopsis "Application Dock for the MATE Panel")
    (description
     "This applet exposes a configurable application dock that
allows users to customize their MATE Desktop experience to mimic modern
desktop environments.")
    (license license:gpl3)))
