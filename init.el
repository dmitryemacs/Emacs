(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Set name
(setq frame-title-format "Emacs")
(fset 'yes-or-no-p 'y-or-n-p)
(setq org-directory "~/Notes")
(setq org-agenda-files (list org-directory))


;; Environment settings
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(tab-bar-mode 0)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Number mode
(column-number-mode 1)
(show-paren-mode 1)
(global-display-line-numbers-mode 1)

;; Pair mode
(electric-pair-mode 1)

;; Scroll settings
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

;; Cursor settings
(setq blink-cursor-blinks 0)
(blink-cursor-mode 1)

;; Font
(set-face-attribute 'default nil :font "Hack Nerd Font-12")

;; Org agenda directory
(setq org-agenda-files '("D:/Documents/Notes"))

;; Custom cursor face
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "white")))))

(use-package dashboard
  :ensure t
  :config
  ;; Set the title
  (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
  ;; Set the banner
  ;;(setq dashboard-startup-banner [VALUE])
  ;; Value can be:
  ;;  - 'official which displays the official emacs logo.
  ;;  - 'logo which displays an alternative emacs logo.
  ;;  - an integer which displays one of the text banners
  ;;    (see dashboard-banners-directory files).
  ;;  - a string that specifies a path for a custom banner
  ;;    currently supported types are gif/image/text/xbm.
  ;;  - a cons of 2 strings which specifies the path of an image to use
  ;;    and other path of a text file to use if image isn't supported.
  ;;    (cons "path/to/image/file/image.png" "path/to/text/file/text.txt").
  ;;  - a list that can display an random banner,
  ;;    supported values are: string (filepath), 'official, 'logo and integers.

  ;; Content is not centered by default. To center, set
  (setq dashboard-center-content t)
  ;; vertically center content
  (setq dashboard-vertically-center-content t)
  (setq dashboard-show-shortcuts nil)
  (dashboard-setup-startup-hook))

(use-package gptel
  :ensure t
  :config
  (setq gptel-model   'mistralai/devstral-2512:free
	gptel-backend
	(gptel-make-openai "Astral"
          :host "openrouter.ai"
          :endpoint "/api/v1/chat/completions"
          :stream t
          :key "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"
          :models '(mistralai/devstral-2512:free)))

  ;; Mapings
  (global-set-key (kbd "C-c C-r") 'gptel-rewrite)
  (global-set-key (kbd "C-<return>") 'gptel-send))

;; Packages with use-package
(use-package company
  :ensure t
  :init
  (global-company-mode 1))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1))

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)))

(use-package magit
  :ensure t)

(use-package ace-window
  :ensure t
  :init
  (setq aw-ignore-minibuffer t)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-background "darkred")
  (setq aw-scale 10.0)
  :bind (("C-o" . ace-window)))

(use-package gruber-darker-theme
  :ensure t
  :init
  (load-theme 'gruber-darker t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; USER FUNCTIONS AND MAPINGS

;; c-mode settings
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))
(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;; Go-mode settings
;; Основные настройки для go-mode
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            (setq go-indent-offset 4)
            (add-hook 'before-save-hook 'gofmt-before-save nil t)))

;; compilation
(defun my/compilation-setup ()
  (setq compilation-window-height 20)
  (setq display-buffer-alist
        '(("\\*compilation\\*"
           (display-buffer-below-selected)
           (window-height . fit-window-to-buffer)))))

(add-hook 'compilation-mode-hook 'my/compilation-setup)

;; map
(global-set-key (kbd "C-c c") 'compile)

;; Org-agenda mapings
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c t") 'org-todo-list)
(global-set-key (kbd "C-c c") 'org-capture)

;; Ensure packages are installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(doom-monokai-spectrum))
 '(custom-safe-themes
   '("be0d9f0e72a4ebc4a59c382168921b082b4dc15844bdaf1353c08157806b3321"
     "19d62171e83f2d4d6f7c31fc0a6f437e8cec4543234f0548bad5d49be8e344cd"
     "f6ea954a9544b0174a876d195387f444da441535ee88c7fb0fc346af08b0d228"
     "c9d837f562685309358d8dc7fccb371ed507c0ae19cf3c9ae67875db0c038632"
     "6963de2ec3f8313bb95505f96bf0cf2025e7b07cefdb93e3d2e348720d401425"
     "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
     "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7"
     "9c6aa7eb1bde73ba1142041e628827492bd05678df4d9097cda21b1ebcb8f8b9"
     default))
 '(package-selected-packages
   '(ace-window company dashboard docker-compose-mode dockerfile-mode
		doom-themes go-mode gptel gruber-darker-theme lsp-mode
		magit neotree projectile swiper yasnippet
		yasnippet-snippets)))
