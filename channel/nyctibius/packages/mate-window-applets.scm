(define-module (nyctibius packages mate-window-applets)
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

(define-public mate-window-applets
  (package
    (name "mate-window-applets")
    (version "21.04.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ubuntu-mate/mate-window-applets")
             (recursive? #t)
             (commit "21.04.0")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "07h7vzy4qa5cspgas4ya7f0g9vn9nn09aa2m75clfg8a07n23znw"))))
    (build-system meson-build-system)
    (arguments
     '(#:glib-or-gtk? #t))
    (native-inputs (list pkg-config
                         intltool
                         itstool
                         gobject-introspection
                         vala
                         libxml2
                         libwnck
                         desktop-file-utils
                         `(,glib "bin")
                         `(,gtk+ "bin")
                         yelp-tools))
    (inputs (list dconf
                  gtk+
                  libsm
                  libx11
                  mate-desktop
                  mate-panel
                  mate-menus
                  libnotify
                  pango))
    (home-page "https://github.com/ubuntu-mate/mate-window-applets")
    (synopsis "Window applets for MATE Desktop")
    (description "Collection of applets.")
    (license (list license:gpl3 license:gpl3+))))
