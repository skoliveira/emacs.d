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

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "/path/to/org-files/")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(provide 'init-preload-local)
