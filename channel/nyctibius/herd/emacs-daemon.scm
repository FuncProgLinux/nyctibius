(define-module (nyctibius herd emacs-daemon)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:export (emacs-daemon-service))

(define emacs-daemon-service
  (shepherd-service (provision '(emacs-daemon))
                    (documentation "Run GNU Emacs in daemon mode")
                    (start #~(make-forkexec-constructor (list #$(file-append
                                                                 emacs
                                                                 "/bin/emacs")
                                                              "--fg-daemon")))
                    (stop #~(make-system-destructor
                             "emacsclient -e '(save-buffers-kill-emacs)'"))))
