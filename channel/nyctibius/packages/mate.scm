;; mate.scm --- Latest MATE packages for Nyctibius -*- mode: scheme; -*-
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
(define-module (nyctibius packages mate)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages attr)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages backup)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages djvu)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages enchant)
  #:use-module (gnu packages file)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages iso-codes)
  #:use-module (gnu packages javascript)
  #:use-module (gnu packages libcanberra)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages mate)
  #:use-module (gnu packages messaging)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages photo)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages polkit)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)

  ;; Include this repository files
  #:use-module (nyctibius packages brisk-menu)
  #:use-module (nyctibius packages mate-tweak)
  #:use-module (nyctibius packages mate-window-applets))

;; TODO: Remove this after the package gets updated at upstream
;; Guix on: gnu/packages/gnome.scm
(define-public libwnck-next
  (package
    (inherit libwnck)
    (name "libwnck")
    (version "43.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://gnome/sources/"
                           "libwnck"
                           "/"
                           (version-major version)
                           "/"
                           "libwnck"
                           "-"
                           (version-major+minor version)
                           ".tar.xz"))
       (sha256
        (base32 "1zn1l8k5m4lz9acwvx6fgvkflqfwsq6b6mhyhvwbimj7b2wcsnwh"))))))

(define-public marco-1.28.2
  (package
    (name "marco")
    (version "1.28.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/mate-desktop/marco")
              (commit (string-append "v" version))
              (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1clzznp9q6kriy9hcm0pkikk0jckm9v18hivk0pjxiwgv7in93lk"))))
    (build-system glib-or-gtk-build-system)
    (native-inputs
     (list pkg-config
           autoconf
           autoconf-archive
           automake
           dconf
           intltool
           itstool
           libtool
           glib
           gobject-introspection
           libxft
           libxml2
           gtk-doc/stable
           mate-common
           which
           yelp-tools
           zenity))
    (inputs
     (list gtk+
           libcanberra
           libgtop
           libice
           libsm
           libx11
           libxcomposite
           libxcursor
           libxdamage
           libxext
           libxfixes
           libxinerama
           libxrandr
           libxrender
           libxres
           mate-desktop
           pango
           startup-notification))
    (home-page "https://mate-desktop.org/")
    (synopsis "Window manager for the MATE desktop")
    (description
     "Marco is a minimal X window manager that uses GTK+ for drawing
window frames.  It is aimed at non-technical users and is designed to integrate
well with the MATE desktop.  It lacks some features that may be expected by
some users; these users may want to investigate other available window managers
for use with MATE or as a standalone window manager.")
    (license license:gpl2+)))

(define-public mate-panel-1.28.7
  (package
    (name "mate-panel")
    (version "1.28.7")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mate-desktop/mate-panel")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1549rd3x08qm91n55rw6jy8n1ryf3n7h4bf2n456cjv4iqjvlr7h"))))
    (build-system glib-or-gtk-build-system)
    (arguments
     `(#:configure-flags (list (string-append "--with-zoneinfo-dir="
                                              (assoc-ref %build-inputs
                                                         "tzdata")
                                              "/share/zoneinfo")
                               "--with-in-process-applets=all")
       #:phases (modify-phases %standard-phases
                  (add-before 'configure 'fix-timezone-path
                    (lambda* (#:key inputs #:allow-other-keys)
                      (let* ((tzdata (assoc-ref inputs "tzdata")))
                        (substitute* "applets/clock/system-timezone.h"
                          (("/usr/share/lib/zoneinfo/tab")
                           (string-append tzdata "/share/zoneinfo/zone.tab"))
                          (("/usr/share/zoneinfo")
                           (string-append tzdata "/share/zoneinfo")))) #t))
                  (add-after 'unpack 'fix-introspection-install-dir
                    (lambda* (#:key outputs #:allow-other-keys)
                      ;; NOTE: v1.28.5 and later require autogen.sh
                      (setenv "ACLOCAL_FLAGS"
                              (string-join (map (lambda (s)
                                                  (string-append "-I " s))
                                                (string-split (getenv
                                                               "ACLOCAL_PATH")
                                                              #\:)) " "))
                      (setenv "NOCONFIGURE" "yes")
                      (invoke "bash" "autogen.sh")
                      (let ((out (assoc-ref outputs "out")))
                        (substitute* '("configure")
                          (("`\\$PKG_CONFIG --variable=girdir gobject-introspection-1.0`")
                           (string-append "\"" out "/share/gir-1.0/\""))
                          (("\\$\\(\\$PKG_CONFIG --variable=typelibdir gobject-introspection-1.0\\)")
                           (string-append out "/lib/girepository-1.0/"))) #t))))))
    (native-inputs (list autoconf
                         autoconf-archive
                         automake
                         pkg-config
                         intltool
                         itstool
                         gtk-doc/stable
                         libtool
                         mate-common
                         xtrans
                         gobject-introspection
                         which ;Wanted by autogen.sh
                         yelp-tools))
    (inputs (list dconf
                  dconf-editor
                  cairo
                  dbus-glib
                  gtk-layer-shell
                  gtk+
                  libcanberra
                  libice
                  libmateweather
                  (librsvg-for-system)
                  libsm
                  libx11
                  libxau
                  libxml2
                  libxrandr
                  libwnck-next
                  mate-desktop
                  mate-menus-1.28.1
                  pango
                  tzdata
                  wayland))
    (native-search-paths
     (list (search-path-specification
            (variable "MATE_PANEL_APPLETS_DIR")
            (files '("share/mate-panel/applets")))
           (search-path-specification
            (variable "MATE_PANEL_EXTRA_MODULES")
            (files '("lib/mate-panel/modules")))))
    (home-page "https://mate-desktop.org/")
    (synopsis "Panel for MATE")
    (description
     "Mate-panel contains the MATE panel, the libmate-panel-applet library and
several applets.  The applets supplied here include the Workspace Switcher,
the Window List, the Window Selector, the Notification Area, the Clock and the
infamous 'Wanda the Fish'.")
    (license (list license:gpl2+ license:lgpl2.0+))))

(define-public mate-applets-1.28.1
  (package
    (name "mate-applets")
    (version "1.28.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://mate/"
                           (version-major+minor version)
                           "/"
                           "mate-applets-"
                           version
                           ".tar.xz"))
       (sha256
        (base32 "0bkyzapds1ha8cvbnl7nc0qjbv5f4cy019i2sdrb3ibxa90p35m5"))))
    (build-system glib-or-gtk-build-system)
    (arguments
     (list
      #:configure-flags
      #~(list "--enable-suid=no" "--enable-polkit" "--enable-in-process"
              (string-append "--with-dbus-sys="
                             #$output "/share/dbus-1/system.d")
              "--enable-ipv6")))
    (native-inputs (list pkg-config
                         intltool ;Listed in Debian package (but not in upstream build.yml)
                         itstool ;Listed in upstream build.yml
                         libxslt
                         yelp-tools
                         gettext-minimal
                         docbook-xml
                         gobject-introspection))
    (inputs (list at-spi2-core
                  cpupower
                  dbus
                  dbus-glib
                  glib
                  gucharmap
                  gtk+
                  gtksourceview-4
                  libgtop
                  libmateweather
                  libnl
                  libnotify
                  libsoup-minimal-2 ;Listed in upstream configure.ac
                  libx11
                  libxml2
                  libwnck
                  mate-desktop
                  mate-menus-1.28.1
                  mate-panel
                  pango
                  polkit ;either polkit or setuid
                  upower
                  wireless-tools))
    (propagated-inputs (list python-pygobject))
    (home-page "https://mate-desktop.org/")
    (synopsis "Various applets for the MATE Panel")
    (description
     "Mate-applets includes various small applications for Mate-panel:

@enumerate
@item accessx-status: indicates keyboard accessibility settings,
including the current state of the keyboard, if those features are in use.
@item Battstat: monitors the power subsystem on a laptop.
@item Character palette: provides a convenient way to access
non-standard characters, such as accented characters,
mathematical symbols, special symbols, and punctuation marks.
@item MATE CPUFreq Applet: CPU frequency scaling monitor
@item Drivemount: lets you mount and unmount drives and file systems.
@item Geyes: pair of eyes which follow the mouse pointer around the screen.
@item Keyboard layout switcher: lets you assign different keyboard
layouts for different locales.
@item Modem Monitor: monitors the modem.
@item Invest: downloads current stock quotes from the Internet and
displays the quotes in a scrolling display in the applet. The
applet downloads the stock information from Yahoo! Finance.
@item System monitor: CPU, memory, network, swap file and resource.
@item Trash: lets you drag items to the trash folder.
@item Weather report: downloads weather information from the
U.S National Weather Service (NWS) servers, including the
Interactive Weather Information Network (IWIN).
@end enumerate
")
    (license (list license:gpl2+ license:lgpl2.0+ license:gpl3+))
    (native-search-paths
     (list (search-path-specification
            (variable "XDG_DATA_DIRS")
            (files '("share")))))))

(define-public caja-actions
	  (package
	    (name "caja-actions")
	    (version "1.28.0")
	    (source
	     (origin
	       (method git-fetch)
	       (uri (git-reference
	             (url "https://github.com/mate-desktop/caja-actions")
	             (commit (string-append "v" version))
	             (recursive? #t)))
	       (file-name (git-file-name name version))
	       (sha256
	        (base32 "1a21kz5796prdq88a3yjc8jnd6qv8jg5zji43m057ra46qjbjazf"))))
	    (build-system glib-or-gtk-build-system)
	    (arguments
	     (list
	      #:configure-flags
	      #~(list (string-append "--with-caja-extdir="
	                             #$output "/lib/caja/extensions-2.0/"
	                             "--disable-static"
	                             "--enable-html-manuals"))
	      #:phases
	      #~(modify-phases %standard-phases
	          (add-after 'unpack 'preconfigure
	            (lambda _
	              ;; Danish translations cause a segmentation
	              ;; fault at compile time. We are removing them
	              ;; for now.
	              (delete-file-recursively "docs/help/da"))))))
	    (native-inputs (list autoconf
	                         autoconf-archive
	                         automake
	                         gettext-minimal
	                         intltool
	                         libice
	                         libxml2
	                         libtool
	                         gobject-introspection
	                         gtk-doc/stable
	                         mate-common
	                         pkg-config
	                         yelp-tools
	                         which))
	    (inputs (list caja
	                  dbus
	                  dbus-glib
	                  gtk+
	                  (list glib "bin")
	                  libgtop
	                  libsm
	                  mate-desktop))
	    (home-page "https://mate-desktop.org/")
	    (synopsis "Execute commands from the caja popup menu")
	    (description
	     "This package is an extension for the MATE caja file manager
	it allows users to add arbitrary programs and launch them through the popup
	menu of selected files.")
	    (license license:gpl2+)))

(define-public atril-1.28.2
  (package
    (name "atril")
    (version "1.28.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mate-desktop/atril")
             (commit (string-append "v" version))
             (recursive? #t)))
       (sha256
        (base32 "09km7v2vak8a0xzg21pc7p195f4lkjl87wyi55cwd7riczf86x9n"))))
    (build-system glib-or-gtk-build-system)
    (arguments
     (list
      #:configure-flags
      #~(list "--enable-introspection" "--disable-schemas-compile"
              ;; FIXME: Enable build of Caja extensions.
              "--disable-caja"
              (string-append "--with-openjpeg="
                             #$(this-package-input "openjpeg")))
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'fix-mathjax-path
            (lambda _
              (let* ((mathjax (assoc-ref %build-inputs "js-mathjax"))
                     (mathjax-path (string-append mathjax
                                                  "/share/javascript/mathjax")))
                (substitute* "backend/epub/epub-document.c"
                  (("/usr/share/javascript/mathjax")
                   mathjax-path))) #t))
          (add-after 'unpack 'fix-introspection-install-dir
            (lambda _
              (setenv "ACLOCAL_FLAGS"
                      (string-join (map (lambda (s)
                                          (string-append "-I " s))
                                        (string-split (getenv "ACLOCAL_PATH")
                                                      #\:)) " "))
              (setenv "NOCONFIGURE" "yes")
              (invoke "bash" "autogen.sh")
              (substitute* '("configure")
                (("\\$\\(\\$PKG_CONFIG --variable=girdir gobject-introspection-1.0\\)")
                 (string-append "\""
                                #$output "/share/gir-1.0/\""))
                (("\\$\\(\\$PKG_CONFIG --variable=typelibdir gobject-introspection-1.0\\)")
                 (string-append #$output "/lib/girepository-1.0/")))))
          (add-before 'install 'skip-gtk-update-icon-cache
            ;; Don't create 'icon-theme.cache'.
            (lambda _
              (substitute* "data/Makefile"
                (("gtk-update-icon-cache")
                 "true")) #t)))))
    (native-inputs (list autoconf
                         autoconf-archive
                         automake
                         pkg-config
                         intltool
                         itstool
                         libtool
                         yelp-tools
                         (list glib "bin")
                         gobject-introspection
                         gtk-doc/stable
                         texlive-bin ;synctex
                         mate-common
                         libxml2
                         which ;Wanted by autogen.sh
                         zlib))
    (inputs (list at-spi2-core
                  cairo
                  caja
                  dconf
                  dbus
                  dbus-glib
                  djvulibre
                  fontconfig
                  freetype
                  ghostscript
                  glib
                  gtk+
                  js-mathjax
                  libcanberra
                  libsecret
                  libspectre
                  libtiff
                  libx11
                  libice
                  libsm
                  libgxps
                  libjpeg-turbo
                  libxml2
                  mate-desktop
                  python-dogtail
                  shared-mime-info
                  gdk-pixbuf
                  gsettings-desktop-schemas
                  libgnome-keyring
                  libarchive
                  marco
                  openjpeg
                  pango
                  ;; texlive
                  ;; TODO:
                  ;; Build libkpathsea as a shared library for DVI support.
                  ;; ("libkpathsea" ,texlive-bin)
                  poppler
                  startup-notification
                  webkitgtk-for-gtk3))
    (home-page "https://mate-desktop.org")
    (synopsis "Document viewer for Mate")
    (description
     "Atril is a simple multi-page document viewer.  It can display and print
@acronym{PostScript, PS}, @acronym{Encapsulated PostScript EPS}, DJVU, DVI, XPS
and @acronym{Portable Document Format PDF} files.  When supported by the
document, it also allows searching for text, copying text to the clipboard,
hypertext navigation, and table-of-contents bookmarks.")
    (license license:gpl2)))

(define-public mate-notification-daemon-1.28.5
  (package
    (name "mate-notification-daemon")
    (version "1.28.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mate-desktop/mate-notification-daemon")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "11nxk1f6mpfa4bgx82s1qs288832cd2gbrq2ni0dqby9ml7sbpp8"))))
    (build-system glib-or-gtk-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'preconfigure
            (lambda _
              (setenv "ACLOCAL_FLAGS"
                      (string-join (map (lambda (s)
                                          (string-append "-I " s))
                                        (string-split (getenv "ACLOCAL_PATH")
                                                      #\:)) " ")))))))
    (native-inputs (list autoconf
                         autoconf-archive
                         automake
                         pkg-config
                         gettext-minimal
                         mate-common
                         libtool
                         which ;Wanted by autogen.sh
                         libxml2))
    (inputs (list gtk+
                  dbus-glib
                  libwnck-next
                  libnotify
                  libcanberra
                  mate-desktop
                  mate-panel
                  hicolor-icon-theme))
    (home-page "https://mate-desktop.org/")
    (synopsis "Notification daemon for MATE")
    (description
     "This MATE Desktop component is meant to run on the background and
deliver notifications to the user.")
    (license license:gpl2+)))

(define-public mate-user-share
  (package
    (name "mate-user-share")
    (version "1.28.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://mate/"
                           (version-major+minor version)
                           "/"
                           "mate-user-share-"
                           version
                           ".tar.xz"))
       (sha256
        (base32 "0f5f75bsxvkp80qag95ijwdhi1hb6n7z0zj9iqs535hpk6cn11c9"))))
    (build-system glib-or-gtk-build-system)
    (arguments
     (list
      #:configure-flags
      #~(list (string-append "--with-cajadir="
                             #$output "/lib/caja/extensions-2.0/"))))
    (native-inputs (list pkg-config gettext-minimal itstool libxml2))
    (inputs (list gtk+
                  caja
                  dbus
                  dbus-glib
                  libnotify
                  libcanberra
                  hicolor-icon-theme))
    (home-page "https://mate-desktop.org/")
    (synopsis "Public files sharing tools for the MATE Desktop")
    (description
     "This package binds programs together to ease file-sharing
across networks on the MATE Desktop. If the file-sharing option is enabled
it will expose the user's $HOME/Public directory on a webdav server.")
    (license license:gpl2+)))

(define-public mate-menus-1.28.1
  (package
    (name "mate-menus")
    (version "1.28.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mate-desktop/mate-menus")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "17pyrp8v9vfwh9r20a4jccxmcw68kj76v9fjr0kcqxhpzc63s1qq"))))
    (build-system gnu-build-system)
    (arguments
     `(#:phases (modify-phases %standard-phases
                  (add-after 'unpack 'fix-introspection-install-dir
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let ((out (assoc-ref outputs "out")))
                        (setenv "ACLOCAL_FLAGS"
                                (string-join (map (lambda (s)
                                                    (string-append "-I " s))
                                                  (string-split (getenv
                                                                 "ACLOCAL_PATH")
                                                                #\:)) " "))
                        (setenv "NOCONFIGURE" "yes")
                        (invoke "bash" "autogen.sh")
                        (substitute* '("configure")
                          (("`\\$PKG_CONFIG --variable=girdir gobject-introspection-1.0`")
                           (string-append "\"" out "/share/gir-1.0/\""))
                          (("\\$\\(\\$PKG_CONFIG --variable=typelibdir gobject-introspection-1.0\\)")
                           (string-append out "/lib/girepository-1.0/"))) #t))))))
    (native-inputs (list autoconf
                         autoconf-archive
                         automake
                         pkg-config
                         intltool
                         itstool
                         libtool
                         gobject-introspection
                         mate-common
                         which))
    (inputs (list glib python))
    (home-page "https://mate-desktop.org/")
    (synopsis "Freedesktop menu specification implementation for MATE")
    (description
     "The package contains an implementation of the freedesktop menu
specification, the MATE menu layout configuration files, .directory files and
assorted menu related utility programs.")
    (license (list license:gpl2+ license:lgpl2.0+))))

(define-public mate-polkit-1.28.1-1
  (package
    (inherit mate-polkit)
    (arguments
     (substitute-keyword-arguments (package-arguments mate-polkit)
       ((#:configure-flags flags
         #~(list))
        #~(list (string-append "--libexecdir="
                               #$output "/libexec")))))))

(define-public mate-power-manager-1.28.1-1
  (package
    (inherit mate-power-manager)
    (arguments
     (substitute-keyword-arguments (package-arguments mate-power-manager)
       ((#:configure-flags flags
         #~(list))
        #~(list (string-append "--libexecdir="
                               #$output "/libexec")))))))

(define-public mate-settings-daemon-1.28.0-1
  (package
    (inherit mate-settings-daemon)
    (arguments
     (substitute-keyword-arguments (package-arguments mate-settings-daemon)
       ((#:configure-flags flags
         #~(list))
        #~(list (string-append "--libexecdir="
                               #$output "/libexec") "--enable-polkit"
                "--enable-pulse"))))))

(define-public mate-media-1.28.1-1
  (package
    (inherit mate-media)
    (arguments
     (substitute-keyword-arguments (package-arguments mate-media)
       ((#:configure-flags flags
         #~(list))
        #~(list (string-append "--libexecdir="
                               #$output "/libexec")))))))

(define-public mate-control-center-1.28.0-1
  (package
    (inherit mate-control-center)
    (arguments
     (substitute-keyword-arguments (package-arguments mate-control-center)
       ((#:configure-flags flags
         #~(list))
        #~(list (string-append "--sbindir="
                               #$output "/sbin")))))))

(define-public libmateweather-1.28.2
  (package
    (name "libmateweather")
    (version "1.28.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mate-desktop/libmateweather")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "15ajz83na76lcnw9cy1m36f9xfzl1nywk9xwwjax1cklfz63vl0g"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:configure-flags
      #~(list "--with-zoneinfo-dir=/var/empty")
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'check 'fix-tzdata-location
            (lambda* (#:key inputs #:allow-other-keys)
              (setenv "TZDIR"
                      (search-input-directory inputs "/share/zoneinfo"))
              (substitute* "data/check-timezones.sh"
                (("/usr/share/zoneinfo/zone.tab")
                 (search-input-file inputs "/share/zoneinfo/zone.tab"))
                ;; XXX: Ignore this test for now, which requires tzdata-2023c.
                (("exit 1")
                 "exit 0")))))))
    (native-inputs (list autoconf
                         autoconf-archive
                         automake
                         dconf
                         (list glib "bin")
                         intltool
                         gtk-doc/stable
                         libtool
                         mate-common
                         which
                         pkg-config))
    (inputs (list gtk+ tzdata-for-tests))
    (propagated-inputs
     ;; both of these are requires.private in mateweather.pc
     (list libsoup-minimal-2 libxml2))
    (home-page "https://mate-desktop.org/")
    (synopsis "MATE library for weather information from the Internet")
    (description
     "This library provides access to weather information from the internet
for the MATE desktop environment.")
    (license license:lgpl2.1+)))

(define-public pluma-1.28.1
  (package
    (name "pluma")
    (version "1.28.1")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	     (url "https://github.com/mate-desktop/pluma")
	     (commit (string-append "v" version))
	     (recursive? #t)))
      (file-name (git-file-name name version))
      (sha256
       (base32 "0d241ll8mznknn739f2gpmk2abdkcw08j3c3nppcwif91vfdhz7v"))))
    (build-system glib-or-gtk-build-system)
    (arguments
     (list
      #:configure-flags
      #~(list "--enable-python"
              "--disable-introspection")
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'install 'wrap-pluma
            (lambda* (#:key outputs #:allow-other-keys)
              (wrap-program (search-input-file outputs "bin/pluma")
                ;; For plugins (same as gedit).
                `("GI_TYPELIB_PATH" ":" prefix
                  (,(getenv "GI_TYPELIB_PATH")))
                `("GUIX_PYTHONPATH" ":" prefix
                  (,(getenv "GUIX_PYTHONPATH")))
                ;; For language-specs.
                `("XDG_DATA_DIRS" ":" prefix
                  (,(string-append #$(this-package-input "gtksourceview")
                                   "/share")))))))
      ;; Tests can not succeed.
      ;; https://github.com/mate-desktop/mate-text-editor/issues/33
      #:tests? #f))
    (native-inputs (list autoconf
                         autoconf-archive
                         automake
                         gettext-minimal
                         gtk-doc/stable
                         intltool
                         libtool
                         mate-common
                         perl
                         pkg-config
                         yelp-tools
                         which))
    (inputs (list at-spi2-core
                  cairo
                  enchant
                  (list glib "bin")
                  gtk+
                  gtksourceview-4
                  gdk-pixbuf
                  iso-codes/pinned
                  libcanberra
                  libx11
                  libsm
                  libpeas
                  libxml2
                  libice
                  mate-desktop
                  packagekit
                  pango
                  python
                  python-pygobject
                  python-wrapper
                  python-pycairo
                  python-six
                  startup-notification))
    (home-page "https://mate-desktop.org/")
    (synopsis "Text Editor for MATE")
    (description "Pluma is the text editor for the MATE Desktop.")
    (license license:gpl2)))

(define-public mate-extra
  (package
    (inherit mate)
    (version (string-append (package-version mate-desktop) "-3"))
    (propagated-inputs (modify-inputs (package-propagated-inputs mate)
                         (replace "mate-applets" mate-applets-1.28.1)
                         (replace "atril" atril-1.28.2)
                         (replace "mate-panel" mate-panel-1.28.7)
                         (replace "mate-polkit" mate-polkit-1.28.1-1)
                         (replace "mate-menus" mate-menus-1.28.1)
                         (replace "mate-power-manager"
                                  mate-power-manager-1.28.1-1)
                         (replace "libmateweather" libmateweather-1.28.2)
                         (replace "mate-settings-daemon"
                                  mate-settings-daemon-1.28.0-1)
                         (replace "mate-notification-daemon"
                                  mate-notification-daemon-1.28.5)
                         (replace "mate-media" mate-media-1.28.1-1)
                         (replace "mate-control-center"
                                  mate-control-center-1.28.0-1)
                         (replace "marco"
                                  marco-1.28.2)
                         ;; Ubuntu MATE Packages
                         (append brisk-menu)
                         (append mate-tweak)
                         (append mate-window-applets)

                         ;; Upstream MATE packages
                         (append mate-user-share)))))
