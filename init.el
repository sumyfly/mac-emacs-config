;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy ;; add the elpy package for python
    flycheck
    py-autopep8 ;; add the autopep8 for python format
    magit ;; for git
    ein ;; add the ein package (Emacs ipython notebook) jupyter notebook
    smart-mode-line
    smart-mode-line-powerline-theme
    color-theme-sanityinc-tomorrow))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(tool-bar-mode -1) ;; close toolbar
(setq inhibit-startup-message t) ;; hide the startup message

;; Save all tempfiles in $TMPDIR/emacs$UID/                                                        
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-directory-alist
        `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
        `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
	  emacs-tmp-dir)

;; These two lines are just examples
(setq powerline-arrow-shape 'curve)
(setq powerline-default-separator-dir '(right . left))
(setq sml/no-confirm-load-theme t)
;; These two lines you really need.
(setq sml/theme 'powerline)
(sml/setup)

;; theme
(load-theme 'sanityinc-tomorrow-eighties t)

(global-linum-mode t) ;; enable line numbers globally
(setq linum-format "%d ");; set line numbers format
(auto-image-file-mode t) ;; support image in emacs

;; elpy config begin
(elpy-enable)

(setq-default ein:use-auto-complete t)
(setq-default ein:use-auto-complte-superpack t)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;;(setq python-shell-interpreter "jupyter"
;;      python-shell-interpreter-args "console --simple-prompt")

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; elpy config end

;; init.el ends here
