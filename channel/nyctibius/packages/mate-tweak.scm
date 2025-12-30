(define-module (nyctibius packages mate-tweak)
  #:use-module (gnu packages)
  #:use-module (gnu packages compton)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages mate)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages terminals)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix gexp)
  #:use-module (guix build utils)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils))

;;; TODO: Cleanup and fix all paths inside this package
;;;
;;; Guix is unable to suggest outputs for packages
;;; but this particular piece of software requires multiple
;;; packages to be installed to show options completely:
;;;
;;; - /usr/bin/mate-maximus & /usr/lib/mate-netbook/mate-window-picker-applet
;;; - /usr/libexec/brisk-menu (already packaged, unusable)
;;; - /usr/lib/mate-applets/mate-dock-applet/dock.py
;;; - picom

(define-public mate-tweak
  (package
    (name "mate-tweak")
    (version "22.10.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ubuntu-mate/mate-tweak")
             (recursive? #t)
             (commit "22.10.0")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "07kfc20mq1hrwd1xgh5f8lqd1v7hprvr357c5hg7716c5j08srvs"))))
    (build-system python-build-system)
    (arguments
     (list
      #:tests? #f
      #:imported-modules `((guix build glib-or-gtk-build-system)
                           ,@%python-build-system-modules)
      #:modules '((guix build python-build-system)
                  ((guix build glib-or-gtk-build-system)
                   #:prefix glib-or-gtk:
                   #:select (glib-or-gtk-build))
                  (guix build utils))
      #:phases
      #~(modify-phases %standard-phases
          ;; sanity checks fail with a
          ;; FileNotFoundError: [Errno 2] No such file or directory: 'mate-tweak'
          ;; error. More research should be done about this issue
          (delete 'sanity-check)
          ;; Substitute non /usr paths until #95 is merged
          ;; upstream.
          ;; NOTE: Consider forking & merging patch manually
          ;; for this repository
          (add-after 'unpack 'substitute-hardcoded-paths
            (lambda* (#:key outputs #:allow-other-keys)
              (let* ((output (assoc-ref outputs "out")))
                ;; Substitute paths in all .py files
                (substitute* (find-files "." "\\.py$")
                  (("/usr/lib/mate-tweak")
                   (string-append output "/lib/mate-tweak")))

                ;; Substitute paths in main mate-tweak binary
                (substitute* (find-files "." "\\mate-tweak$")
                  (("/usr/lib/mate-tweak")
                   (string-append output "/lib/mate-tweak")))

                ;; Remove the "{prefix}"
                (substitute* "setup.py"
                  (("\\{prefix\\}/")
                   ""))

                (substitute* (find-files "." "\\mate-tweak")
                  (("'/','usr','share'")
                   (string-append "'" output "','share'")))

                )))

          ;; Add GI_TYPELIB_PATH to the final library
          (add-after 'wrap 'gi-wrap
            (lambda _
              (let ((prog (string-append #$output "/bin/mate-tweak")))
                (wrap-program prog
                  `("GI_TYPELIB_PATH" =
                    (,(getenv "GI_TYPELIB_PATH")))))))

          ;; Post-installation path fixes. Guix doesn't have "sw" unlike
          ;; nix, but we don't need it anyways
          (add-after 'install 'substitute-postinstall-paths
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (marco (assoc-ref inputs "marco"))
                     (maximus (assoc-ref inputs "mate-maximus")))
                (substitute* (find-files (string-append out "/bin")
                                         "\\mate-tweak$")
                  (("/usr/bin/marco")
                   (string-append marco "/bin/marco")))

                (substitute* (find-files (string-append out "/bin")
                                         "\\mate-tweak$")
                  (("/usr/share/applications")
                   "/run/current-system/profile/share/applications")
                  (("/usr/share/mate-panel/layouts")
                   "/run/current-system/profile/share/mate-panel/layouts")
                  (("/usr/lib")
                   "/run/current-system/profile/lib")
                  (("/usr/share/mate-panel/")
                   "/run/current-system/profile/share/mate-panel/")
                  (("/usr/bin")
                   "/run/current-system/profile/bin/"))

                ))))))
    (native-inputs `(("python-wrapper" ,python-wrapper)
                     ("intltool" ,intltool)
                     ("python-distutils-extra" ,python-distutils-extra)
                     ("gobject-introspection" ,gobject-introspection)))
    (inputs (list gtk+
                  libnotify
                  glib
                  gdk-pixbuf
                  tilda
                  mate-desktop
                  mate-applets
                  mate-panel
                  marco
                  dconf
                  gsettings-desktop-schemas
                  libmatekbd
                  mate-session-manager
                  picom
                  python-pygobject
                  python-configobj
                  python-psutil
                  python-distro
                  python-setproctitle))
    (home-page "https://github.com/ubuntu-mate/mate-tweak")
    (synopsis "Tweak tool for the MATE Desktop.")
    (description
     "Configuration tool for MATE Desktop settings not exposed
by the Mate Control Center, such as panel layouts, desktop icons show & hide
options and window manager tuning.")
    (license license:gpl2+)))
