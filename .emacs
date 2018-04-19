(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(cmake-ide-build-dir "./")
 '(cmake-ide-cmake-opts "-DCMAKE_BUILD_TYPE=Debug")
 '(cmake-ide-compile-command "make")
 '(custom-enabled-themes (quote (zerodark)))
 '(custom-safe-themes
   (quote
    ("bce3ae31774e626dce97ed6d7781b4c147c990e48a35baedf67e185ebc544a56" "8ec2e01474ad56ee33bc0534bdbe7842eea74dccfb576e09f99ef89a705f5501" "28ccfceab51a8d7e53bf5b35a788966a06b3ac6ca06fd96ec62a22ee3caa05cf" "d5b121d69e48e0f2a84c8e4580f0ba230423391a78fcb4001ccb35d02494d79e" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" default)))
 '(ecb-options-version "2.50")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(inhibit-startup-screen t)
 '(latex-preview-pane-use-frame t)
 '(magit-diff-refine-hunk (quote all))
 '(org-support-shift-select (quote always))
 '(package-selected-packages
   (quote
    (go-guru flycheck-gometalinter company-go go-mode latex-preview-pane auctex-latexmk company-auctex auctex all-the-icons-ivy all-the-icons-gnus all-the-icons-dired zerodark-theme clues-theme jedi-direx helm-ag unicode-fonts markdown-mode blackboard-theme dracula-theme el-get hideshow-org git-gutter diff-hl srefactor ecb company-jedi cmake-mode function-args imenu-list helm-rtags magit company-irony-c-headers company-c-headers drag-stuff company-quickhelp sr-speedbar neotree irony-eldoc flycheck-irony company-rtags company-irony cmake-ide flycheck-rtags flycheck company)))
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(sr-speedbar-right-side nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(el-get-bundle hide-comnt)
(el-get-bundle fixme-mode)

;; MELPA csomagforrás
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony company-cmake company-jedi company-go)))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; Módok, amiket be kell kapcsolni, ha C++-t szerkesztünk
(setq irony-additional-clang-options '("-std=c++11"))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++17")))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++17")))
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'imenu-add-menubar-index)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'imenu-add-menubar-index)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'irony-mode-hook #'irony-eldoc)
(add-hook 'go-mode-hook 'flycheck-mode)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Állandóan bekapcsolt módok
(require 'rtags) ;; optional, must have rtags installed
(cmake-ide-setup)
(eval-after-load 'company
  '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

(company-quickhelp-mode)

(require 'drag-stuff)
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)

(require 'helm-config)
(setq rtags-use-helm t)

(fa-config-default)

;; Automatikusan behozza a bal oldali outline sávot
(setq sr-speedbar-width 12)
;;(sr-speedbar-toggle)
;;(neotree)

(cmake-mode)

(global-semantic-stickyfunc-mode)

;; Néhány Emacs finomhangolás

;; (setq vc-follow-symlinks nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq indent-line-function 'insert-tab)
(setq-default c-basic-offset 4)

(ido-mode)

(global-set-key (kbd "C-SPC") 'company-complete)
(global-set-key (kbd "<f8>") 'sr-speedbar-toggle)
;;(global-set-key (kbd "<f8>") 'neotree-toggle)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(define-key c++-mode-map (kbd "C-j") 'rtags-find-symbol-at-point)
(define-key c++-mode-map (kbd "C-x j") 'moo-jump-local)

(add-hook 'python-mode-hook
          (lambda()
            (local-set-key (kbd "C-j") 'jedi:goto-definition)))
(add-hook 'python-mode-hook
          (lambda()
            (local-set-key (kbd "C-x j") 'helm-ag-this-file)))

;;(define-key python-mode-map (kbd "C-x j") 'helm-ag-this-file)

;; M-x ido-mode
(global-set-key
 "\M-x"
 (lambda ()
   (interactive)
   (call-interactively
    (intern
     (ido-completing-read
      "M-x "
      (all-completions "" obarray 'commandp))))))

(global-diff-hl-mode)
(global-visual-line-mode)
(require 'all-the-icons)
(zerodark-setup-modeline-format)

(menu-bar-mode -1)
(tool-bar-mode -1)

(require 'company-auctex)
(company-auctex-init)

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

(require 'auctex-latexmk)
(auctex-latexmk-setup)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)

(latex-preview-pane-enable)
(flycheck-gometalinter-setup)
