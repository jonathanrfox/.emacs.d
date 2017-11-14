(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; (if (daemonp)
;;     (add-hook 'after-make-frame-functions
;;               (lambda (frame)
;;                 (select-frame frame)
;;                 (load-theme 'spacegray t)))
;;   (load-theme 'spacegray t))

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
