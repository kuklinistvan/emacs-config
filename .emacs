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
    ("51ba4e2db6df909499cd1d85b6be2e543a315b004c67d6f72e0b35b4eb1ef3de" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bce3ae31774e626dce97ed6d7781b4c147c990e48a35baedf67e185ebc544a56" "8ec2e01474ad56ee33bc0534bdbe7842eea74dccfb576e09f99ef89a705f5501" "28ccfceab51a8d7e53bf5b35a788966a06b3ac6ca06fd96ec62a22ee3caa05cf" "d5b121d69e48e0f2a84c8e4580f0ba230423391a78fcb4001ccb35d02494d79e" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" default)))
 '(dumb-jump-mode t)
 '(ecb-options-version "2.50")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(inhibit-startup-screen t)
 '(latex-preview-pane-use-frame t)
 '(magit-diff-refine-hunk (quote all))
 '(neo-autorefresh t)
 '(neo-theme (quote icons))
 '(neo-vc-integration (quote (face char)))
 '(neo-window-fixed-size nil)
 '(org-support-shift-select (quote always))
 '(package-selected-packages
   (quote
    (elpy meghanada json-mode spacemacs-theme go-projectile wgrep godoctor hydra dumb-jump go-rename indium js2-mode company-tern restart-emacs company-web web-mode company-shell go-guru flycheck-gometalinter company-go go-mode latex-preview-pane auctex-latexmk company-auctex auctex all-the-icons-ivy all-the-icons-gnus all-the-icons-dired zerodark-theme clues-theme jedi-direx helm-ag unicode-fonts markdown-mode blackboard-theme dracula-theme el-get hideshow-org git-gutter diff-hl srefactor ecb company-jedi cmake-mode function-args imenu-list helm-rtags magit company-irony-c-headers company-c-headers drag-stuff company-quickhelp sr-speedbar neotree irony-eldoc flycheck-irony company-rtags company-irony cmake-ide flycheck-rtags flycheck company)))
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(sr-speedbar-default-width 80))
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

(projectile-global-mode 1)
(require 'go-projectile)
(go-projectile-tools-add-path)
(setq gofmt-command (concat go-projectile-tools-path "/bin/goimports"))


(require 'company)                                   ; load company mode
(require 'company-web-html)                          ; load company mode html backend
;; and/or
(require 'company-web-jade)                          ; load company mode jade backend
(require 'company-web-slim)                          ; load company mode slim backend
(require 'company-tern)

(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony company-cmake company-jedi company-go company-shell company-shell-env company-fish-shell company-css-html-tags company-web company-web-html company-tern company-web-complete-css company-yasnippet)))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; Módok, amiket be kell kapcsolni, ha C++-t szerkesztünk
(setq irony-additional-clang-options '("-std=c++11"))

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

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
(add-hook 'html-mode-hook 'web-mode)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))

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
(global-set-key (kbd "<f8>") 'neotree-toggle)
(global-set-key (kbd "<f9>") 'sr-speedbar-toggle)
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

(tool-bar-mode -1)

(require 'company-auctex)
(company-auctex-init)

(require 'auctex-latexmk)
(auctex-latexmk-setup)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)

(latex-preview-pane-enable)
(flycheck-gometalinter-setup)

  ;; Set the neo-window-width to the current width of the
  ;; neotree window, to trick neotree into resetting the
  ;; width back to the actual window width.
  ;; Fixes: https://github.com/jaypei/emacs-neotree/issues/262
  (eval-after-load "neotree"
    '(add-to-list 'window-size-change-functions
                  (lambda (frame)
                    (let ((neo-window (neo-global--get-window)))
                      (unless (null neo-window)
                        (setq neo-window-width (window-width neo-window)))))))

;;(setq auto-mode-alist (append '(("\\.html$" . web-mode))
;;                              auto-mode-alist))
;;(setq auto-mode-alist (append '(("\\.gohtml$" . web-mode))
;;                              auto-mode-alist))
(setq auto-mode-alist (append '(("\\.djhtml$" . web-mode))
                              auto-mode-alist))



;; Enable JavaScript completion between <script>...</script> etc.
(advice-add 'company-tern :before
            #'(lambda (&rest _)
                (if (equal major-mode 'web-mode)
                    (let ((web-mode-cur-language
                          (web-mode-language-at-pos)))
                      (if (or (string= web-mode-cur-language "javascript")
                              (string= web-mode-cur-language "jsx"))
                          (unless tern-mode (tern-mode))
                        (if tern-mode (tern-mode -1)))))))


(add-hook 'neo-after-create-hook
   #'(lambda (_)
       (with-current-buffer (get-buffer neo-buffer-name)
         (setq truncate-lines t)
         (setq word-wrap nil)
         (make-local-variable 'auto-hscroll-mode)
         (setq auto-hscroll-mode nil))))

(require 'org)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

(defhydra dumb-jump-hydra (global-map "<f5>")
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))

(setenv "GOPATH"
        (concat (getenv "HOME") "/go"))

(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(setq neo-force-change-root t)

(require 'meghanada)
(add-hook 'java-mode-hook
          (lambda ()
            ;; meghanada-mode on
            (meghanada-mode t)
            (flycheck-mode +1)
            (setq c-basic-offset 2)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
(cond
   ((eq system-type 'windows-nt)
    (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
    (setq meghanada-maven-path "mvn.cmd"))
   (t
    (setq meghanada-java-path "java")
    (setq meghanada-maven-path "mvn")))

;; https://www.linuxquestions.org/questions/linux-general-1/how-to-make-mouse-wheel-scroll-one-line-at-a-time-in-emacs-814430/
;; scroll one line at a time (less "jumpy" than defaults)
    
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; one line at a time
    
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
    
(setq mouse-wheel-follow-mouse 't) ;; scroll widow under mouse


(setq sr-speedbar-width 20)

(setq-default cursor-type 'bar) 

(elpy-enable)

(global-set-key (kbd "C-c m") 'mc/mark-next-like-this)
