;; Initialise installed packages
(setq package-enable-at-startup t)

(defvar package-quickstart)

;; Allow loading from the package cache
(setq package-quickstart t)

;; Do not resize the frame at this early stage.
(setq frame-inhibit-implied-resize t)

;; Disable GUI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(setq use-file-dialog nil)

;; Prevent unwanted runtime builds in gccemacs
(setq comp-deferred-compilation nil)

;; Disable backups
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Indention
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq-default org-edit-src-content-indentation 0)

;; Misc
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default org-display-custom-times t)
(setq-default org-time-stamp-custom-formats '("<%a %b %d %Y>" . "<%a %b %d %Y %I:%M %p>"))

;; Font
(set-face-attribute 'default nil :font "Inconsolata" :height 150)

;; Comment color
(set-face-foreground 'font-lock-comment-face "#7daea3")

;; Line numbering
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; themes
;;(add-to-list 'custom-theme-load-path
;;             (file-name-as-directory
;;               (expand-file-name "~/.config/emacs/themes")))
;;
;;(load-theme 'gruvbox t)

(require 'org)
(org-babel-load-file "/home/hoaxdream/.config/emacs/init.org")
