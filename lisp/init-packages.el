(require 'cl)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("gnu" . "http://elpa.emacs-china.org/gnu/") t)
  (add-to-list 'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa/") t)
  )

;;add whatever packages you want here
(defvar sandwich/packages '(
			    company
			    monokai-theme
			    hungry-delete
			    swiper
			    counsel
			    smartparens
			    js2-mode
			    nodejs-repl
			    exec-path-from-shell
			    popwin
			    )  "Default packages")

(setq package-selected-packages  sandwich/packages)

(defun sandwich/packages-installed-p ()
  (loop for pkg in sandwich/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (sandwich/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg sandwich/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;;let emacs could find the excuable
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))



(global-hungry-delete-mode)

;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;; config js2-mode for js file
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

(global-company-mode t)

(load-theme 'monokai t)

(require 'popwin)
(popwin-mode t)


(provide 'init-packages)


