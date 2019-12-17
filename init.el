(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; (setq backup-directory-alist `(("." . "~/.saves")))
(setq custom-file "~/.emacs.d/custom.el")
(setq config-file "~/.emacs.d/config.org")

(if (daemonp)
    (progn
      (org-babel-load-file config-file)
      (add-hook 'after-make-frame-functions
                (lambda (frame)
                  (select-frame frame)
                  (load custom-file)))))
;;   (org-babel-load-file (expand-file-name config-file))
;;   (load custom-file))
