(setq-default c-basic-offset 4
              c-default-style (quote ((c-mode . "k&r")
                                      (c++-mode . "k&r")
                                      (java-mode . "java")
                                      (awk-mode . "awk")
                                      (other . "gnu")))
              c-ignore-auto-fill (quote (cpp))
              c-mode-common-hook (quote (linum-mode
                                         c-toggle-hungry-state))
              indent-tabs-mode nil
              tab-always-indent (quote complete)
              tab-width 4
              text-mode-hook (quote
                              (turn-on-auto-fill
                               turn-on-flyspell
                               text-mode-hook-identify))
              ispell-local-dictionary "brasileiro"
              linum-format "%3d │ ")

;; Install use-package
(unless package-archive-contents           ;; Refresh the packages descriptions
  (package-refresh-contents))
(setq package-load-list '(all))            ;; List of packages to load
(unless (package-installed-p 'use-package) ;; Make sure the use package is
  (package-install 'use-package))          ;; installed, install it if not

;; org-elpa
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; Initialise packages
(package-initialize)

;; use-package initialisation
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package smart-comment
  :ensure t
  :bind ("M-;" . smart-comment))

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/org/slip-box/")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(use-package org
  :ensure t
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   (quote
    ((emacs-lisp . t)
     (awk . t)
     (C . t)
     (fortran . t)
     (gnuplot . t)
     (java . t)
     (latex . t)
     (python . t))))
  (setq org-log-done (quote time)
        org-export-date-timestamp-format "%e de %B de %Y"
        org-latex-listings t
        org-latex-listings-options
        (quote (("frame" "single")
                ("breaklines" "true")
                ("tabsize" "4")
                ("showstringspaces" "false")
                ("basicstyle" "\\footnotesize"))))
  ;(delete '("\\.pdf\\'" . default) org-file-apps)
  ;(add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s"))
  (with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-packages-alist
                 (quote ("" "listings" t)))
    (add-to-list 'org-latex-classes
                 (quote ("abntex2" "\\documentclass[11pt]{abntex2}
                         [NO-DEFAULT-PACKAGES]"
                         ("\\section{%s}" . "\\section*{%s}")
                         ("\\subsection{%s}" . "\\subsection*{%s}")
                         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                         ("\\paragraph{%s}" . "\\paragraph*{%s}")
                         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
    (add-to-list 'org-latex-classes
                 (quote ("abntex2book" "\\documentclass[11pt]{abntex2}
                         [NO-DEFAULT-PACKAGES]"
                         ("\\part{%s}" . "\\part*{%s}")
                         ("\\chapter{%s}" . "\\chapter*{%s}")
                         ("\\section{%s}" . "\\section*{%s}")
                         ("\\subsection{%s}" . "\\subsection*{%s}")
                         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
    (setq org-latex-title-command "")
    (if (< (string-to-number org-version) 8.3)
        ((add-to-list 'org-latex-packages-alist
                      (quote ("\\hypersetup{\n  colorlinks=true,\n  linkcolor=blue,\n  citecolor=blue,\n  filecolor=magenta,\n  urlcolor=blue,\n  bookmarksdepth=4}")))
         (setq org-latex-with-hyperref nil))
      ;; ELSE:
      (setq org-latex-hyperref-template "\\hypersetup{\n pdfauthor={%a},\n pdftitle={%t},\n pdfkeywords={%k},\n pdfsubject={%d},\n pdfcreator={%c},\n pdflang={%L},\n colorlinks=true,\n linkcolor=blue,\n citecolor=blue,\n filecolor=magenta,\n urlcolor=blue,\n bookmarksdepth=4}\n"))))

(provide 'init-preload-local)
