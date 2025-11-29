(define-module (nyctibius packages mint)
  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix build utils)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system meson)
  #:use-module (guix git-download)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages cinnamon)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages image)
  #:use-module (gnu packages inkscape)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages polkit)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages rpc)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg))

(define-public libxapp-3.2.0
  (package
    (name "libxapp")
    (version "3.2.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/linuxmint/xapp/")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0xa1kw6znmaf0kgwa3hwryg5lpmvyh2fl4hh2cczk0y0jz44bvcc"))))
    (build-system meson-build-system)
    (arguments
     (list
      #:modules `((guix build meson-build-system)
                  (guix build utils)
                  ((guix build python-build-system)
                   #:prefix python:))
      #:imported-modules `(,@%meson-build-system-modules (guix build
                                                          python-build-system))
      #:configure-flags
      #~(list (string-append "-Dpy-overrides-dir="
                             (python:site-packages %build-inputs %outputs)
                             "/gi/overrides"))
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'configure 'set-gtk-module-path
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (setenv "PKG_CONFIG_GTK__3_0_LIBDIR"
                      (string-append #$output "/lib"))
              (substitute* "libxapp/meson.build"
                (("gtk3_dep\\.get_pkgconfig_variable[(]'libdir'[)]")
                 (string-append "'"
                                (assoc-ref outputs "out") "/lib'")))

              (substitute* "scripts/pastebin"
                (("'nc'")
                 (string-append "'"
                                (search-input-file inputs "/bin/nc") "'")))

              (substitute* "scripts/upload-system-info"
                (("'inxi'")
                 (string-append "'"
                                (search-input-file inputs "/bin/inxi") "'"))
                (("'/usr/bin/pastebin'")
                 (string-append "'"
                                (assoc-ref outputs "out") "/bin/pastebin'"))
                (("'xdg-open'")
                 (string-append "'"
                                (search-input-file inputs "/bin/xdg-open") "'"))))))))
    (inputs (list dbus
                  glib ;for gio
                  gtk+
                  inxi-minimal ;used by upload-system-info
                  libdbusmenu
                  libgnomekbd
                  netcat ;used by pastebin
                  xdg-utils)) ;used by upload-system-info
    (native-inputs (list gettext-minimal
                         `(,glib "bin") ;for glib-mkenums
                         gobject-introspection
                         pkg-config
                         python
                         python-pygobject
                         vala))
    (home-page "https://github.com/linuxmint/xapp")
    (synopsis "Library for traditional GTK applications")
    (description
     "The libxapp package contains the components which are common to multiple
GTK desktop environments (Cinnamon, MATE and Xfce) and required to implement
cross-DE solutions.")
    (license license:lgpl3+)))

(define-public mint-x-icon-theme
  (package
    (name "mint-x-icon-theme")
    (version "1.7.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/linuxmint/mint-x-icons")
             (commit "1.7.5")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "09m2mbaibhk7byijlwrqjm2gdpyhb8f94pl2jmh3dizrr3p5mnsh"))))
    (build-system copy-build-system)
    (arguments
     (list
      #:install-plan
      #~'(("usr/share/icons" "share/icons"))))
    (home-page "https://github.com/linuxmint/mint-x-icons")
    (synopsis "Icon theme for Linux Mint")
    (description
     "A mint/metal theme based on mintified versions of Clearlooks Revamp, Elementary and Faenza.")
    (license license:gpl3+)))

(define-public mint-y-icon-theme
  (package
    (name "mint-y-icon-theme")
    (version "1.8.9")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/linuxmint/mint-y-icons")
             (commit "1.8.9")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1mcg6zn5bpkvdlx4mpcmckg2l0bgkqnymk1kh2k4x7daxngh2hvr"))))
    (build-system copy-build-system)
    (arguments
     (list
      #:install-plan
      #~'(("usr/share/icons" "share/icons"))))
    (home-page "https://github.com/linuxmint/mint-y-icons")
    (synopsis "The Mint-Y icon theme")
    (description "A flat, colorful, and modern theme based on Paper and Moka.")
    (license (list license:gpl3+ license:cc-by-sa4.0))))

(define-public mint-l-icon-theme
  (package
    (name "mint-l-icon-theme")
    (version "1.7.9")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/linuxmint/mint-l-icons")
             (commit "fa88b00e10b0978e0309acccfa95d80005422b1a")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "130qip6xzisjjgi6j3lhzq7kvkgx3ajrvqpzkk0rdzqsxmwbaz2x"))))
    (build-system copy-build-system)
    (arguments
     (list
      #:install-plan
      #~'(("usr/share/icons" "share/icons"))))
    (home-page "https://github.com/linuxmint/mint-l-icons")
    (synopsis "Mint-L icon theme")
    (description "A flat, colorful, and modern theme based on Paper and Moka.")
    (license (list license:gpl3+ license:cc-by-sa4.0))))

(define-public mint-themes
  (package
    (name "mint-themes")
    (version "2.3.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/linuxmint/mint-themes")
             (commit "master.mint22")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1lc78f3zxz2fm6znbf9zfziazx0fxm2v7fcdbd4pmnnajr8rqh4y"))))
    (build-system copy-build-system)
    (inputs (list inkscape optipng))
    (native-inputs (list python python-wrapper python-libsass))
    (arguments
     (list
      #:install-plan
      #~'(("usr/share/themes" "share/themes"))
      #:modules '((guix build copy-build-system)
                  (guix build utils))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'generate-themes
            (lambda _
              (substitute* "generate-themes.py"
                (("./build-themes.py")
                 "python3 build-themes.py"))
              (substitute* "update-variations.py"
                (("./render-assets.sh")
                 "bash render-assets.sh"))
              (substitute* "src/Mint-Y/build-themes.py"
                (("./render-assets.sh")
                 "bash render-assets.sh"))
              (substitute* "src/Mint-Y/build-themes.py"
                (("./render-dark-assets.sh")
                 "bash render-dark-assets.sh"))
              ;; Invoking "make" would be the same as this
              (invoke "python3" "generate-themes.py"))))))
    (home-page "https://github.com/linuxmint/mint-themes")
    (synopsis "Linux Mint themes for GTK Desktops")
    (description
     "This package contains the collection of GTK desktop themes made
by the Linux Mint distribution. It provides the following themes:

@enumerate
@item Mint-X
@item Mint-X-Colours (Yellow, Purple, Aqua, Etc)
@item Mint-Y
@item Mint-Y-Colours (Orange, Pink,  Purple, Etc)
@end enumerate

The themes also come with Mint-X-compact for the XFCE Desktop xfwm4.")
    (license license:gpl3+)))

(define-public mint-l-theme
  (package
    (name "mint-l-theme")
    (version "2.0.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/linuxmint/mint-l-theme")
             (commit "2.0.2")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "02z4salqpabmg6lbg4wj7mc0clv7ng8s2014p9gdkjlf03zx9x20"))))
    (build-system copy-build-system)
    (inputs (list inkscape optipng))
    (native-inputs (list python python-wrapper sassc python-libsass))
    (arguments
     (list
      #:install-plan
      #~'(("usr/share/themes" "share/themes"))
      #:modules '((guix build copy-build-system)
                  (guix build utils))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'generate-themes
            (lambda _
              (substitute* "generate-themes.py"
                (("./build-themes.py")
                 "python3 build-themes.py"))
              (substitute* "update-variations.py"
                (("./render-assets.sh")
                 "bash render-assets.sh"))
              (substitute* "src/Mint-L/build-themes.py"
                (("./render-assets.sh")
                 "bash render-assets.sh"))
              (substitute* "src/Mint-L/build-themes.py"
                (("./render-dark-assets.sh")
                 "bash render-dark-assets.sh"))
              (invoke "python3" "generate-themes.py"))))))
    (home-page "https://github.com/linuxmint/mint-l-theme")
    (synopsis "Linux Mint L Theme for GTK Desktops")
    (description "Modern theme for GTK Desktops based on Mint-Y theme.")
    (license license:gpl3+)))

(define-public sticky
  (package
    (name "sticky")
    (version "1.28")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/linuxmint/sticky")
             (commit "1.28")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1lz87i7c2vpnljaxq05v89m0hm8qw1xcd61cpqvlpfdikmw68978"))))
    (build-system meson-build-system)
    (arguments
     (list
      #:imported-modules `((guix build python-build-system)
                           ,@%meson-build-system-modules)
      #:modules '((guix build utils)
                  (guix build meson-build-system)
                  ((guix build python-build-system)
                   #:prefix python:))
      #:glib-or-gtk? #t
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'glib-or-gtk-wrap 'python-and-gi-wrap
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (wrap-program (search-input-file outputs "bin/sticky")
                `("GUIX_PYTHONPATH" =
                  (,(getenv "GUIX_PYTHONPATH") ,(python:site-packages inputs
                                                                      outputs)))
                `("GI_TYPELIB_PATH" =
                  (,(getenv "GI_TYPELIB_PATH"))))))
          (add-after 'install 'fix-paths
            (lambda* (#:key outputs #:allow-other-keys)
              (substitute* (find-files (string-append #$output "/bin/sticky"))
                (("/usr/lib")
                 (string-append #$output "/lib")))
              (substitute* (find-files (string-append #$output
                                                      "/lib/sticky/sticky.py"))
                (("/usr/share")
                 (string-append #$output "/share")))

              (substitute* (find-files (string-append #$output
                                                      "/lib/sticky/sticky.py"))
                (("__DEB_VERSION__")
                 (string-append "1.28" "-guix-mate")))

              (substitute* (find-files (string-append #$output
                                        "/lib/sticky/manager.py"))
                (("/usr/share")
                 (string-append #$output "/share"))))))))
    (inputs (list gettext-minimal
                  gobject-introspection
                  libxapp-3.2.0
                  `(,glib "bin")
                  `(,gtk+ "bin")
                  gspell))
    (native-inputs (list python python-pygobject python-xapp))
    (home-page "https://github.com/linuxmint/sticky")
    (synopsis "A sticky notes app for GTK desktops")
    (description
     "Sticky is a note-taking app for GTK desktops that simulates
the traditional sticky note style. It includes basic formatting features, tray
icons and autoatic backups.")
    (license license:gpl2)))

(define-public warpinator
  (package
    (name "warpinator")
    (version "1.8.10")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/linuxmint/warpinator")
             (recursive? #t)
             (commit "1.8.10")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "17rziwchjck3s7gxiq6bj6vv6rrf9kymhp051fb7j8655665h9ir"))))
    (build-system meson-build-system)
    (arguments
     (list
      #:imported-modules `((guix build python-build-system)
                           ,@%meson-build-system-modules)
      #:modules '((guix build utils)
                  (guix build meson-build-system)
                  ((guix build python-build-system)
                   #:prefix python:))
      #:glib-or-gtk? #t
      #:configure-flags
      #~(list "-Dbundle-grpc=false" "-Dbundle-zeroconf=false")
      #:phases
      #~(modify-phases %standard-phases
          ;; FIXME: Wrongly wrapped! won't run for now
          (add-after 'glib-or-gtk-wrap 'python-and-gi-wrap
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (wrap-program (search-input-file outputs "bin/warpinator")
                `("GUIX_PYTHONPATH" =
                  (,(getenv "GUIX_PYTHONPATH") ,(python:site-packages inputs
                                                                      outputs)))
                `("GI_TYPELIB_PATH" =
                  (,(getenv "GI_TYPELIB_PATH")))))))))
    (native-inputs (list gettext-minimal
                         gobject-introspection
                         polkit
                         python
                         python-wrapper
                         python-xapp
                         libxapp-3.2.0))
    (inputs (list `(,glib "bin")
                  `(,gtk+ "bin")
                  gdk-pixbuf
                  python-pygobject
                  python-setproctitle
                  python-zeroconf
                  python-grpcio
                  python-grpcio-tools
                  python-protobuf
                  python-cryptography
                  python-libnacl
                  python-netaddr
                  python-ifaddr
                  python-netifaces))
    (home-page "https://github.com/linuxmint/warpinator")
    (synopsis "Share files across the LAN")
    (description "Warpinator is a file sharing service for desktop users.")
    (license license:gpl3)))

(define-public xed
  (package
    (name "xed")
    (version "3.8.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/linuxmint/xed")
             (recursive? #t)
             (commit "3.8.5")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0v58w8sqs28mg89b4q0faq9hbmxbij6gihlvkpq4c0q7mi4zvw48"))))
    (native-inputs (list gettext-minimal
                         gobject-introspection
                         itstool
                         intltool
                         python
                         python-pygobject
                         pkg-config))
    (inputs (list glib
                  gtk+
                  gtksourceview-4
                  gspell
                  (list glib "bin")
                  libgnomekbd
                  libxkbfile
                  libpeas
                  libsm
                  libxml2
                  libxapp-3.2.0
                  libice
                  packagekit
                  pango
                  startup-notification))
    (build-system meson-build-system)
    (arguments
     (list
      #:imported-modules `((guix build python-build-system)
                           ,@%meson-build-system-modules)
      #:modules '((guix build utils)
                  (guix build meson-build-system)
                  ((guix build python-build-system)
                   #:prefix python:))
      #:glib-or-gtk? #t
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'glib-or-gtk-wrap 'python-and-gi-wrap
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (wrap-program (search-input-file outputs "bin/xed")
                `("GUIX_PYTHONPATH" =
                  (,(getenv "GUIX_PYTHONPATH") ,(python:site-packages inputs
                                                                      outputs)))
                `("GI_TYPELIB_PATH" =
                  (,(getenv "GI_TYPELIB_PATH")))))))

      ;; For some reason tests make the package installation fail.
      ;; these will remain disabled for now.
      #:tests? #f))
    (home-page "https://github.com/linuxmint/xed")
    (synopsis "xed is a small and lightweight text editor.")
    (description
     "xed supports most standard editing features, plus several not found in your average text editor (plugins being the most notable of these).")
    (license license:gpl2+)))
