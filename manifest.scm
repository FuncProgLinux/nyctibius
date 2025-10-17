;; Lo que sigue es un "manifest" equivalente a la línea de comando que
;; introdujo. Puede almacenarlo dentro de un archivo que pudiese pasar a
;; cualquier comando 'guix' que acepte una opción '--manifest' (o -m).

(concatenate-manifests (list (specifications->manifest (list "emacs"
                                                        "guix"
                                                        "guile"
                                                        "emacs-geiser"
                                                        "emacs-geiser-guile"
                                                        "emacs-paredit"
                                                        "emacs-arei"
                                                        "make"
                                                        "perl"
                                                        "perl-critic"
                                                        "perltidy"
                                                        "pls"))
                             (package->development-manifest (specification->package
                                                             "git"))))
