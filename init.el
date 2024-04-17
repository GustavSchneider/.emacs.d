(setq gc-cons-threshold 100000000)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))


(global-set-key (kbd "<f8>") 'bury-buffer)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "Hack"))))
 '(fringe ((t (:background "#262626")))))



(put 'upcase-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(clang-format treemacs-tab-bar treemacs-persp treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil dap-mode lsp-treemacs lsp-ui lsp-mode helm-rtags helm rtags csharp-mode ggtags markdown-mode markdown-mode+ cuda-mode all-the-icons-ivy all-the-icons-dired flycheck-clang-analyzer flycheck-irony company-irony irony-eldoc irony xclip doom-modeline esup use-package company-rtags cmake-mode lua-mode smart-mode-line google-this writegood-mode git-timemachine ## rainbow-delimiters emojify apropospriate-theme dracula-theme zenburn-theme wrap-region web-mode w3m sr-speedbar speed-type solarized-theme slime relative-line-numbers powerline-evil php-mode pddl-mode nyan-mode multiple-cursors matlab-mode magit js2-mode java-snippets golint go-mode glsl-mode git-rebase-mode git-commit-mode flymake-go flycheck-haskell flycheck-color-mode-line fancy-battery erlang company column-marker color-theme-solarized clojure-mode ac-ispell ac-clang ac-c-headers))
 '(smooth-scrolling-mode t))
