;; https://github.com/noctuid/evil-guide#emacsevil-for-vim-users

(setq gc-cons-threshold 100000000)

;; Use X clipboard
(setq x-select-enable-clipboard t
      x-select-enable-primary t)

;; Disable blinking cursor
(blink-cursor-mode -1)

;; delete trailing whitespace in all modes
(add-hook 'before-save-hook #'delete-trailing-whitespace)

;; Set indent
(setq-default indent-tabs-mode nil)

;; set encoding
(prefer-coding-system 'utf-8)

;; and tell emacs to play nice with encoding
(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)

;;keep cursor at same position when scrolling
(setq scroll-preserve-screen-position t)

;; scroll one line at a time
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000)
(setq scroll-margin 3)

;; prefer vertical splits if there is enough space
(setq split-height-threshold nil)
(setq split-width-threshold 160)

;; no menu bar
(menu-bar-mode -1)

;; Disable tool bar
(tool-bar-mode -1)

;; disable scroll bars
(scroll-bar-mode -1)

;; No splash screen
(setq inhibit-splash-screen t)

;; no message on startup
(setq initial-scratch-message nil)

;; set font
;;(add-to-list 'default-frame-alist '(font . "Inconsolata-13"))
;;(set-face-attribute 'default nil :font "Inconsolata-13")

;; Install packages
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Theme
(use-package doom-themes
  :ensure t
  :init (setq org-fontify-whole-heading-line t
              org-fontify-done-headline t
              org-fontify-quote-and-verse-blocks t)
  :config (progn
            (load-theme 'doom-one t)
            (add-hook 'find-file-hook 'doom-buffer-mode)))

;; Highlight delimiters like parentheses or brackets in depth
(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; show line numbers
(use-package linum
  :init (setq linum-format "%3d ")
:config (add-hook 'prog-mode-hook 'linum-mode t))

;; Vim-like env for Emacs
(use-package evil
  :ensure t
  ;:init (setq evil-want-C-u-scroll t)
  :config (progn
	    (evil-mode 1)
            (defalias #'forward-evil-word #'forward-evil-symbol)))

;; git helper, why a special for evil?
(use-package evil-magit
:ensure t)

;; git helper
(use-package magit
  :ensure t
  :bind (("C-c m" . magit-status))
:init (add-hook 'after-save-hook 'magit-after-save-refresh-status))

;; Show available following commands
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Good for presentation of code
(use-package darkroom
:ensure t)

;; Completion tool
(use-package company
  :ensure t
  :init (global-company-mode)
  :config (setq company-idle-delay 0.2
                company-minimum-prefix-length 1))

;; Completion for python
(use-package company-jedi
  :ensure t
:config (add-to-list 'company-backends 'company-jedi))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-jedi company darkroom which-key evil-magit evil rainbow-delimiters doom-themes use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
