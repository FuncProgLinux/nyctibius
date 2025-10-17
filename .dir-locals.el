;;; SPDX-License-Identifier: GPL-3.0-or-later
;;; Copyright © 2012-2023 Ludovic Courtès <ludo@gnu.org>
;;; Copyright © 2013,2014 Mark H Weaver <mhw@netris.org>
;;; Copyright © 2014 Taylan Ulrich Bayırlı/Kammer <taylanbayirli@gmail.com>
;;; Copyright © 2015 David Thompson <davet@gnu.org>
;;; Copyright © 2016 Hartmut Goebel <h.goebel@crazy-compilers.com>
;;; Copyright © 2017 Alex Kost <alezost@gmail.com>
;;; Copyright © 2018-2020 Caleb Ristvedt <caleb.ristvedt@cune.org>
;;; Copyright © 2020-2023,2025 Maxim Cournoyer <maxim.cournoyer@gmail.com>
;;; Copyright © 2020 Miguel Ángel Arruga Vivas <rosen644835@gmail.com>
;;; Copyright © 2020 Christine Lemmer-Webber <cwebber@dustycloud.org>
;;; Copyright © 2022 Liliana Marie Prikler <liliana.prikler@gmail.com>
;;; Copyright © 2022 Andrew Tropin <andrew@trop.in>
;;; Copyright © 2022 Brian Cully <bjc@kublai.com>
;;; Copyright © 2023 (unmatched-parenthesis <paren@disroot.org>
;;; Copyright © 2024 Christopher Baines <mail@cbaines.net>
;;; Copyright © 2024 Tomas Volf <~@wolfsden.cz>
;;; Copyright © 2024 Nicolas Graves <ngraves@ngraves.fr>
;;; Copyright © 2025 David Elsing <david.elsing@posteo.net>
;;; Copyright © 2025 Hilton Chain <hako@ultrarare.space>

;; Expanded with Guix and other channels. Used Guix copyright, for the parts
;; I did, assume GPL-3.0+ and no credit to me is needed ;)
;;
;; Skipped the guix/ and other sections not needed for this channel

((nil
  . ((fill-column . 80)
     (tab-width   .  8)

     ;; For use with 'bug-reference-prog-mode', taken from GNU GUIX
     ;; Licensed GPL-3.0+
     (bug-reference-url-format . "https://codeberg.org/guix-mate/guix-mate/issues/%s")
     (bug-reference-bug-regexp
      . "\\(#\\([0-9]+\\)\\)")

     (geiser-insert-actual-lambda . nil)
     (eval . (add-to-list 'completion-ignored-extensions ".go"))))
 (scheme-mode
  .
  ((indent-tabs-mode . nil)
   (geiser-guile-binary . ("guix" "repl"))
   ;; Took this from Guix original .dir-locals.el
   ;; This notably allows '(' in Paredit to not insert a space when the
   ;; preceding symbol is one of these.
   (eval . (modify-syntax-entry ?~ "'"))
   (eval . (modify-syntax-entry ?$ "'"))
   (eval . (modify-syntax-entry ?+ "'"))
   (eval . (put 'eval-when 'scheme-indent-function 1))
   (eval . (put 'call-with-prompt 'scheme-indent-function 1))
   (eval . (put 'test-assert 'scheme-indent-function 1))
   (eval . (put 'test-assertm 'scheme-indent-function 1))
   (eval . (put 'test-equalm 'scheme-indent-function 1))
   (eval . (put 'test-equal 'scheme-indent-function 1))
   (eval . (put 'test-eq 'scheme-indent-function 1))
   (eval . (put 'call-with-input-string 'scheme-indent-function 1))
   (eval . (put 'call-with-port 'scheme-indent-function 1))
   (eval . (put 'guard 'scheme-indent-function 1))
   (eval . (put 'lambda* 'scheme-indent-function 1))
   (eval . (put 'substitute* 'scheme-indent-function 1))
   (eval . (put 'match-record 'scheme-indent-function 3))
   (eval . (put 'match-record-lambda 'scheme-indent-function 2))
   (eval . (put 'let-keywords 'scheme-indent-function 3))
   (eval . (put 'modify-inputs 'scheme-indent-function 1))
   (eval . (put 'replace 'scheme-indent-function 1))
   (eval . (put 'modify-phases 'scheme-indent-function 1))
   (eval . (put 'replace 'scheme-indent-function 1))
   (eval . (put 'add-before 'scheme-indent-function 2))
   (eval . (put 'add-after 'scheme-indent-function 2))
   (eval . (put 'modify-services 'scheme-indent-function 1))
   (eval . (put 'with-directory-excursion 'scheme-indent-function 1))
   (eval . (put 'with-file-lock 'scheme-indent-function 1))
   (eval . (put 'with-file-lock/no-wait 'scheme-indent-function 1))
   (eval . (put 'with-profile-lock 'scheme-indent-function 1))
   (eval . (put 'with-writable-file 'scheme-indent-function 2))
   (eval . (put 'package/inherit 'scheme-indent-function 1))
   (eval . (put 'substitute-keyword-arguments 'scheme-indent-function 1))
   (eval . (put 'with-store 'scheme-indent-function 1))
   (eval . (put 'with-store/non-blocking 'scheme-indent-function 1))
   (eval . (put 'with-external-store 'scheme-indent-function 1))
   (eval . (put 'with-error-handling 'scheme-indent-function 0))
   (eval . (put 'with-mutex 'scheme-indent-function 1))
   (eval . (put 'with-atomic-file-output 'scheme-indent-function 1))
   (eval . (put 'call-with-compressed-output-port 'scheme-indent-function 2))
   (eval . (put 'call-with-decompressed-port 'scheme-indent-function 2))
   (eval . (put 'call-with-gzip-input-port 'scheme-indent-function 1))
   (eval . (put 'call-with-gzip-output-port 'scheme-indent-function 1))
   (eval . (put 'call-with-lzip-input-port 'scheme-indent-function 1))
   (eval . (put 'call-with-lzip-output-port 'scheme-indent-function 1))
   (eval . (put 'signature-case 'scheme-indent-function 1))
   (eval . (put 'emacs-batch-eval 'scheme-indent-function 0))
   (eval . (put 'emacs-batch-edit-file 'scheme-indent-function 1))
   (eval . (put 'emacs-substitute-sexps 'scheme-indent-function 1))
   (eval . (put 'emacs-substitute-variables 'scheme-indent-function 1))
   (eval . (put 'with-derivation-narinfo 'scheme-indent-function 1))
   (eval . (put 'with-derivation-substitute 'scheme-indent-function 2))
   (eval . (put 'with-status-report 'scheme-indent-function 1))
   (eval . (put 'with-status-verbosity 'scheme-indent-function 1))
   (eval . (put 'with-build-handler 'scheme-indent-function 1))
   (eval . (put 'mlambda 'scheme-indent-function 1))
   (eval . (put 'mlambdaq 'scheme-indent-function 1))
   (eval . (put 'syntax-parameterize 'scheme-indent-function 1))
   (eval . (put 'with-monad 'scheme-indent-function 1))
   (eval . (put 'mbegin 'scheme-indent-function 1))
   (eval . (put 'mwhen 'scheme-indent-function 1))
   (eval . (put 'munless 'scheme-indent-function 1))
   (eval . (put 'mlet* 'scheme-indent-function 2))
   (eval . (put 'mlet 'scheme-indent-function 2))
   (eval . (put 'state-parameterize 'scheme-indent-function 2))
   (eval . (put 'store-parameterize 'scheme-indent-function 2))
   (eval . (put 'run-with-store 'scheme-indent-function 1))
   (eval . (put 'run-with-state 'scheme-indent-function 1))
   (eval . (put 'wrap-program 'scheme-indent-function 1))
   (eval . (put 'wrap-script 'scheme-indent-function 1))
   (eval . (put 'with-imported-modules 'scheme-indent-function 1))
   (eval . (put 'with-extensions 'scheme-indent-function 1))
   (eval . (put 'with-parameters 'scheme-indent-function 1))
   (eval . (put 'let-system 'scheme-indent-function 1))
   (eval . (put 'with-build-variables 'scheme-indent-function 2))
   (eval . (put 'with-database 'scheme-indent-function 2))
   (eval . (put 'call-with-database 'scheme-indent-function 1))
   (eval . (put 'call-with-transaction 'scheme-indent-function 1))
   (eval . (put 'call-with-retrying-transaction 'scheme-indent-function 1))
   (eval . (put 'call-with-container 'scheme-indent-function 1))
   (eval . (put 'container-excursion 'scheme-indent-function 1))
   (eval . (put 'eventually 'scheme-indent-function 1))
   (eval . (put 'call-with-progress-reporter 'scheme-indent-function 1))
   (eval . (put 'with-repository 'scheme-indent-function 2))
   (eval . (put 'with-temporary-git-repository 'scheme-indent-function 2))
   (eval . (put 'with-environment-variables 'scheme-indent-function 1))
   (eval . (put 'with-fresh-gnupg-setup 'scheme-indent-function 1))
   (eval . (put 'with-paginated-output-port 'scheme-indent-function 1))
   (eval . (put 'with-shepherd-action 'scheme-indent-function 3))
   (eval . (put 'with-http-server 'scheme-indent-function 1))
   (eval . (put 'android-repo-reference 'scheme-indent-function 0))
   (eval . (put 'bzr-reference 'scheme-indent-function 0))
   (eval . (put 'cvs-reference 'scheme-indent-function 0))
   (eval . (put 'git-checkout 'scheme-indent-function 0))
   (eval . (put 'git-reference 'scheme-indent-function 0))
   (eval . (put 'hg-reference 'scheme-indent-function 0))
   (eval . (put 'svn-multi-reference 'scheme-indent-function 0))
   (eval . (put 'svn-reference 'scheme-indent-function 0))))
 (makefile-gmake-mode
  .
  ((indent-tabs-mode . t)
   (tab-width        . 4)))
 (cperl-mode
  .
  ((indent-tabs-mode . nil)
   (tab-width . 4)
   (fill-column . 80)
   (cperl-electric-parens . nil))))
