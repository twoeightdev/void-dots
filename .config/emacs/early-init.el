;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

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
(setq use-dialog-box t)
(setq use-file-dialog nil)

(setq-default frame-title-format '("%b  -  GNU Emacs"))
(setq inhibit-startup-screen t)
(setq inhibit-startup-buffer-menu t)

;; Line numbering
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;;(add-hook 'prog-mode-hook 'hl-line-mode)

;; Disable backups
(setq backup-inhibited t)
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Indention
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)

;; Misc
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default org-display-custom-times t)
(setq-default org-time-stamp-custom-formats '("<%a %b %d %Y>" . "<%a %b %d %Y %I:%M %p>"))

;; Increase font size
;;(set-face-attribute 'default nil :height 140)
(set-face-attribute 'default nil :font "Inconsolata" :height 140)

(require 'package)

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/"))

;;(unless package-archive-contents
;;  (package-refresh-contents))

;; if not yet installed, install package use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'org)
(org-babel-load-file "/home/hoaxdream/.config/emacs/init.org")

;;; early-init.el ends here
