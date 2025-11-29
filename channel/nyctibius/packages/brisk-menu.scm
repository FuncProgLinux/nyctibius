(define-module (nyctibius packages brisk-menu)
  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix build utils)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system meson)
  #:use-module (guix git-download)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages mate)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg))

(define-public brisk-menu
  (package
    (name "brisk-menu")
    (version "0.6.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://codeberg.org/guix-mate/brisk-menu-guix")
             (recursive? #t)
             (commit "v0.6.4")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1dk1pyay6zz9xdnilchswmvy2nrdgrqfcw7xbz8af48wqivrhm60"))))
    (build-system meson-build-system)
    (arguments
     (list
      #:glib-or-gtk? #t
      #:configure-flags
      #~(list (string-append "--libdir="
                             #$output "/lib")
              (string-append "--libexecdir="
                             #$output "/lib"))))
    (native-inputs (list pkg-config
                         intltool
                         itstool
                         gobject-introspection
                         libxml2
                         desktop-file-utils
                         `(,glib "bin")
                         `(,gtk+ "bin")
                         yelp-tools))
    (inputs (list dconf
                  dbus
                  gtk+
                  libsm
                  libx11
                  mate-desktop
                  mate-panel
                  mate-menus
                  libnotify
                  pango))
    (home-page "https://codeberg.org/guix-mate/brisk-menu-guix")
    (synopsis "Solus Project's Brisk Menu MATE Panel Applet")
    (description
     "Brisk Menu is a modern desktop menu for the MATE Desktop
Environment providing the  MATE Desktop with a first-class application and
system menu applet.")
    (license (list license:gpl2+ license:cc-by-sa4.0))))
