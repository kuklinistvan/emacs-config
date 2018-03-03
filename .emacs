(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cmake-ide-build-dir "./emacs-cmake-build")
 '(cmake-ide-cmake-opts "-DCMAKE_BUILD_TYPE=Debug")
 '(cmake-ide-compile-command "cd emacs-cmake-build; make")
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (company-irony-c-headers company-c-headers drag-stuff company-quickhelp sr-speedbar neotree irony-eldoc flycheck-irony company-rtags company-irony cmake-ide flycheck-rtags flycheck company)))
 '(sr-speedbar-right-side nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
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

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'irony-mode-hook #'irony-eldoc)

(global-set-key (kbd "C-SPC") 'company-complete)
(global-set-key (kbd "<f8>") 'sr-speedbar-toggle)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(company-quickhelp-mode)

(require 'rtags) ;; optional, must have rtags installed
(cmake-ide-setup)
(eval-after-load 'company
  '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

;; Automatikusan behozza a bal oldali outline sávot
(setq sr-speedbar-width 12)
(sr-speedbar-toggle)

(require 'drag-stuff)
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)

