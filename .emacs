;; MELPA

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(defun display-startup-echo-area-message ()
  (message "Billentyűkiosztás: C-h b"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#d2ceda" "#f2241f" "#67b11d" "#b1951d" "#3a81c3" "#a31db1" "#21b8c7" "#655370"])
 '(cmake-ide-flags-c++ "-j4")
 '(company-minimum-prefix-length 2)
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(dashboard-banner-logo-title "István's .emacs - codekuklin.com")
 '(dashboard-startup-banner "~/.emacs.d/ki_green.png")
 '(flyspell-issue-message-flag nil)
 '(helm-mode-fuzzy-match t)
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#3a81c3")
     ("OKAY" . "#3a81c3")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#42ae2c")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f"))))
 '(inhibit-startup-screen t)
 '(lsp-eldoc-render-all nil)
 '(lsp-enable-file-watchers t)
 '(lsp-file-watch-threshold 10000000000)
 '(lsp-prefer-flymake nil)
 '(package-selected-packages
   (quote
    (json-mode flymake-json cpputils-cmake flyspell-lazy restart-emacs ranger diff-hl doom-modeline spacemacs-theme treemacs-magit lsp-treemacs treemacs-projectile treemacs helm-projectile realgud-lldb realgud dashboard company-box ## spaceline-all-the-icons all-the-icons bm lsp-ui ccls company-lsp lsp-mode function-args flycheck-clangcheck company-c-headers cmake-mode sr-speedbar projectile fzf dumb-jump helm-rtags flycheck-rtags company-rtags use-package srefactor undo-tree cmake-ide magit neotree helm-ag company-quickhelp company)))
 '(treemacs-position (quote right)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; MELPA VÉGE


;; ERGONOMIKUS BILLENTYŰ KIOSZTÁS
;; Frissítsd a README-t, ha itt valamin változtatsz


(bind-key* (kbd "C-s") 'save-buffer)
(bind-key* (kbd "C-v") 'yank)
(bind-key* (kbd "C-x") 'kill-region)
(bind-key* (kbd "C-c") 'kill-ring-save)
(bind-key* (kbd "C-a") 'mark-whole-buffer)

(bind-key* (kbd "C-n") 'make-frame-command)
(bind-key* (kbd "C-o") 'find-file)

(bind-key* (kbd "C-z") 'undo-tree-undo)
(bind-key* (kbd "C-y") 'undo-tree-redo)

(bind-key* (kbd "C-f") 'isearch-forward)
(bind-key* (kbd "C-g") 'isearch-backward)

(bind-key* (kbd "<M-left>") 'previous-buffer)
(bind-key* (kbd "<M-right>") 'next-buffer)

(bind-key* (kbd "C-w") 'kill-this-buffer)

(bind-key* (kbd "C-b") 'list-buffers)


(bind-key* (kbd "<f4>") 'ff-find-other-file)
(bind-key* (kbd "<f5>") 'helm-projectile-ag)
(bind-key* (kbd "<f6>") 'fzf-projectile)
(bind-key* (kbd "<f8>") 'treemacs)

(bind-key* (kbd "<f10>") 'split-window-below)
(bind-key* (kbd "<f11>") 'split-window-right)
(bind-key* (kbd "<f12>") 'delete-window)


(bind-key* (kbd "<C-SPC>") 'company-complete)

(bind-key* (kbd "<M-up>") 'lsp-signature-next)
(bind-key* (kbd "<M-down>") 'lsp-signature-previous)

;; ERGONOMIKUS BILLENTYŰ KIOSZTÁS VÉGE





(add-hook 'after-init-hook 'global-company-mode)

(company-quickhelp-mode)

;; (cmake-ide-setup)


(add-to-list 'company-backends 'company-c-headers)
;; (add-to-list 'company-backends 'company-clang)

(setq-default cursor-type 'bar)

(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++17")))

;; https://emacs.stackexchange.com/questions/13127/disable-specific-warning-in-flycheck-specifically-pragma-once-in-main-file?noredirect=1&lq=1
(with-eval-after-load "flycheck"
    (setq flycheck-clang-warnings `(,@flycheck-clang-warnings
                                    "no-pragma-once-outside-header")))



(setq-default tab-width 4)
(setq-default c-basic-offset 4)

(global-undo-tree-mode)


(require 'srefactor)
(require 'srefactor-lisp)

;; OPTIONAL: ADD IT ONLY IF YOU USE C/C++.
(semantic-mode 1) ;; -> this is optional for Lisp

(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)

(global-visual-line-mode t)
(setq-default indent-tabs-mode nil)


;; <cpputils-cmake>

(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))
;; OPTIONAL, somebody reported that they can use this package with Fortran
(add-hook 'c90-mode-hook (lambda () (cppcm-reload-all)))
;; OPTIONAL, avoid typing full path when starting gdb
(global-set-key (kbd "C-c C-g")
 '(lambda ()(interactive) (gud-gdb (concat "gdb --fullname " (cppcm-get-exe-path-current-buffer)))))
;; OPTIONAL, some users need specify extra flags forwarded to compiler
(setq cppcm-extra-preprocss-flags-from-user '("-I/usr/src/linux/include" "-DNDEBUG"))

;; </cpputils-cmake>

(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-offset 'arglist-intro '+)
            (c-set-offset 'arglist-close 0)))


(add-hook 'c++-mode-hook #'lsp)
(push 'company-lsp company-backends)

(require 'ccls)
(setq ccls-executable "/usr/bin/ccls")

(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; initial window
(setq initial-frame-alist
      '(
        (width . 138) ; character
        (height . 40) ; lines
        ))

;; default/sebsequent window
(setq default-frame-alist
      '(
        (width . 138) ; character
        (height . 40) ; lines
        ))

(require 'all-the-icons)
;; or
(use-package all-the-icons)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(setq company-box-icons-alist 'company-box-icons-all-the-icons)

(require 'dashboard)
(dashboard-setup-startup-hook)
;; Or if you use use-package
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))

(projectile-mode +1)
(doom-modeline-mode 1)
(global-diff-hl-mode)

(show-paren-mode)
