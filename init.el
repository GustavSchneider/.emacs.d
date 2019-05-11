;;;;;;;;;;;;;;;;;;;
;;; Melpa Setup ;;;
;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(setq url-http.attempt-keepalives nil)
(add-to-list 'load-path "~/.emacs.d/elpa/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; use-package setup.                               ;;;
;;; Will intall the package if not already installed ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(unless (package-installed-p 'use-package)
  (progn (message "installing use-package")
	 (package-refresh-contents)
	 (package-install 'use-package)))

;; I have no idea
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Turn of menu bar and stuff ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode -1) ;; no menu bar
(tool-bar-mode -1) ;; no tool bar
(scroll-bar-mode -1) ;; no scrollbar
(defalias 'yes-or-no-p 'y-or-n-p)
;;(global-visual-line-mode 1) ;;wrap lines
(display-time-mode 1)
;;hide start screen
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Font and theme setup ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 130 :family "Hack")))))
(use-package dracula-theme
  :ensure t
  :init
  (load-theme 'dracula t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rainbow-delimiter mode setup ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'c-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'c++-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Misc package setup ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(winner-mode 1)

(use-package cmake-mode
  :ensure t
  )
(use-package glsl-mode
  :ensure t
  )
;; KTH has a way to old emacs version
(if (>= emacs-major-version 25)
    (use-package magit
      :ensure t
      )
)
(use-package sr-speedbar
  :ensure t
  :bind ([f5] . sr-speedbar-toggle)
  )

(use-package centered-window
  :ensure t
  :init
  (setq cwm-centered-window-width 100)
  (centered-window-mode t)
  )

(use-package smooth-scrolling
  :ensure t
  :init
  (smooth-scrolling-mode 1)
  )

(use-package guru-mode
  :ensure t)

(use-package web-mode
  :ensure t)

(use-package gist
  :ensure t)

;;;;;;;;;;;;;;;;;;;
;;; Email setup ;;;
;;;;;;;;;;;;;;;;;;;
(setq send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "smtp.kth.se"
      smtpmail-stream-type 'starttls
      smtpmail-smtp-service 587)
(setq user-full-name "Gustav Nelson Schneider")
(setq user-mail-address "gussch@kth.se")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Bind Shift+arrow keys so i can move between windows using them ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(windmove-default-keybindings)
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(setq scroll-preserve-screen-position 1)
(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )
;;;;;;;;;;;;;;;;;;;;;;;
;;; Setup Yasnippet ;;;
;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet-snippets
         :ensure t)
(use-package yasnippet
  :ensure t
  :init
  (setq yas-snippet-dirs (append yas-snippet-dirs '("~/.emacs.d/snippets")))
  (yas-global-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;
;;; irony-mode setup ;;;
;;;;;;;;;;;;;;;;;;;;;;;;
(use-package irony
  :ensure t
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )
(use-package irony-eldoc
  :ensure t)
(use-package company-irony
  :ensure t)
(use-package flycheck-irony
  :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; company-mode setup ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package company-c-headers
  :ensure t)
(use-package company-glsl
  :ensure t)

(defun my-company-visible-and-explicit-action-p ()
    (and (company-tooltip-visible-p)
         (company-explicit-action-p)))
(defun my-company-mode-hook ()
  "Setting up company-mode."
  (company-mode)
  (set (make-local-variable 'company-require-match) nil)
  (set (make-local-variable 'company-backends) '(;;company-files
                                                 ;;company-c-headers
                                                 company-irony
                                                 ;;company-clang
                                                 company-glsl))
  (set (make-local-variable 'company-auto-complete)
       #'my-company-visible-and-explicit-action-p)
  (set (make-local-variable 'company-frontends)
       '(company-pseudo-tooltip-unless-just-one-frontend
         company-preview-frontend
         company-echo-metadata-frontend))
  (set (make-local-variable 'company-idle-delay) 0.3)
  (set (make-local-variable 'company-async-timeout) 5)
  (local-set-key (kbd "<tab>") #'company-indent-or-complete-common))

(use-package company
  :ensure t
  :after (company-glsl company-c-headers irony)
  :init
  (add-hook 'c++-mode-hook 'my-company-mode-hook)
  (add-hook 'c-mode-hook 'my-company-mode-hook)
  (add-hook 'glsl-mode-hook 'my-company-mode-hook))

;;This will notify when a line is longer than 80 characters in org mode
(add-hook 'go-mode (lambda () (interactive) (column-marker-1 81)))
(add-hook 'c++-mode (lambda () (interactive) (column-marker-1 81)))

;;;;;;;;;;;;;;;;;;;;;;
;;; flycheck setup ;;;
;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :ensure t
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++17")))
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++17")))
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  )
(use-package flycheck-color-mode-line
  :ensure t)

(use-package flycheck-clang-analyzer
  :after (flycheck)
  :ensure t
  :init
  (flycheck-clang-analyzer-setup)
  )

;;;;;;;;;;;;;;;;;;;;;;
;;; C++-mode setup ;;;
;;;;;;;;;;;;;;;;;;;;;;
(defconst my-c++-style
  '((c-basic-offset   . 4)
    (c-offsets-alist  . ((inline-open         . 0)
                         (brace-list-open     . 0)
                         (inextern-lang       . 0)
                         (innamespace         . 0)
                         (inlambda            . 0)
                         (statement-case-open . +))))
  (c-echo-syntactic-information-p . t))

(c-add-style "my-c++-style" my-c++-style)
(defun my-c++-style-hook ()
  (c-set-style "my-c++-style"))
(add-hook 'c++-mode-hook 'my-c++-style-hook)

;;;;;;;;;;;;;;;;;;;;;;;;
;;; eval-and-replace ;;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
	     (current-buffer))
    (error (message "Invalid expression")
	   (insert (current-kill 0)))))
(global-set-key (kbd "C-c e") 'eval-and-replace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; multiple-cursors-setup ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package multiple-cursors
  :ensure t
  :bind
  ("C-c n" . mc/mark-next-like-this)
  ("C-c p" . mc/mark-previous-like-this)
  ("C-c a" . mc/mark-all-like-this)
  ;;("C-S-c C-S-c" . mc/edit-lines)
  )

;;;;;;;;;;;;;;;;;;;;;;;
;;; ws-butler setup ;;;
;;;;;;;;;;;;;;;;;;;;;;;
(use-package ws-butler
  :ensure t
  :defer
  :init
    (add-hook 'prog-mode-hook #'ws-butler-mode))


(put 'upcase-region 'disabled nil)
(setq org-latex-pdf-process '("pdflatex -interaction nonstopmode %f" "biber %b" "pdflatex -interaction nonstopmode %f" "pdflatex -interaction nonstopmode --synctex=-1 %f"))

(setq-default indent-tabs-mode nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package company-rtags cmake-mode lua-mode smart-mode-line google-this writegood-mode git-timemachine ## rainbow-delimiters emojify apropospriate-theme dracula-theme zenburn-theme wrap-region web-mode w3m sr-speedbar speed-type solarized-theme slime relative-line-numbers powerline-evil php-mode pddl-mode nyan-mode multiple-cursors matlab-mode magit js2-mode java-snippets golint go-mode glsl-mode git-rebase-mode git-commit-mode flymake-go flycheck-haskell flycheck-color-mode-line fancy-battery erlang company column-marker color-theme-solarized clojure-mode ac-ispell ac-clang ac-c-headers))))
