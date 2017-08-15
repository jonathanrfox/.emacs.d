;;emacs config
;;author: jonathan fox

;;--------
;;packages
;;--------

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;;-------------
;;init shortcut
;;-------------

(defun init-default-buffers ()
  (interactive)
  (ibuffer)
  (multi-term))

(bind-key "C-c i" 'init-default-buffers)

;;--------
;;info dir
;;--------

(add-to-list 'Info-default-directory-list "~/info")

;;------------------
;;default major mode
;;------------------

(setq-default major-mode 'org-mode)

;;---------
;;cosmetics
;;---------

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(global-linum-mode 1)
(column-number-mode 1)
(which-function-mode 1)
;;(setq window-min-width 80)
(load-theme 'spacegray t)
(add-to-list 'default-frame-alist
             '(font . "Liberation Mono"))

;;-------
;;enabled
;;-------

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;------
;;sounds
;;------

(setq ring-bell-function 'ignore)

;;----
;;tabs
;;----
(setq-default indent-tabs-mode nil)

;;---------
;;yes or no
;;---------

(defalias 'yes-or-no-p 'y-or-n-p)

;;---------
;;highlight
;;---------

;; (require 'highlight-chars)
;; (defun my-highlight-settings ()
;;   (if (not hc-highlight-trailing-whitespace-p)
;;       (hc-toggle-highlight-trailing-whitespace)))
;; (add-hook 'python-mode-hook 'my-highlight-settings)

;;-----------
;;lorem ipsum
;;-----------

(lorem-ipsum-use-default-bindings)

;;---------
;;movements
;;---------

(windmove-default-keybindings)
(winner-mode 1)

;;---------
;;text-mode
;;---------

;; (add-hook 'text-mode-hook
;;               (lambda ()
;;                 (when (y-or-n-p "Auto Fill mode? ")
;;                   (turn-on-auto-fill)
;;                   (setq fill-column 80))))

;;------
;;c prog
;;------

(setq c-default-style "k&r" c-basic-offset 4 tab-width 4)

;;--------
;;cpp prog
;;--------

;;-----------
;;python prog
;;-----------

(setq python-command "python3.6")
;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    (setq python-indent-offset 4)))
;; (require 'ein)
;; (require 'ein)
;; (require 'ein-loaddefs)
;; (require 'ein-notebook)
;; (require 'ein-subpackages)
;; (setq ein:console-executable "/home/j/.virtualenvs/scienv/bin/ipython")

;;---------
;;java prog
;;---------

;;-------
;;js prog
;;-------

(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
(setq js2-pretty-multiline-declarations nil)

;;---------
;;html prog
;;---------

(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'sgml-mode-hook 'sgml-electric-tag-pair-mode)

;;--------
;;pretty lambda
;;--------

(pretty-lambda-for-modes)

;;---------
;;nyan-mode
;;---------

(nyan-mode 1)

;;------------
;;rainbow-mode
;;------------

(bind-key "C-c r" 'rainbow-mode)

;;---------------
;;mutli-term mode
;;---------------

(setq multi-term-program "/bin/bash")
(bind-key "C-c m t" 'multi-term)
(bind-key "C-c m n" 'multi-term-next)
(bind-key "C-c m p" 'multi-term-prev)

;;--------
;;org-mode
;;--------

;; (add-hook 'org-mode-hook
;; 	  (lambda () (org-bullets-mode 1)))

(setq org-latex-table-caption-above nil)
;; command above will be: `(setq org-latex-caption-above nil)` in newer version.

(setq org-clock-persist 'history)

(setq org-agenda-files "~/notes/reference.org")

(org-clock-persistence-insinuate)

(require 'ob-mongo)
(require 'ob-sql-mode)

(org-babel-do-load-languages 'org-babel-load-languages
			     '((python . t)
			       (C . t)))
                               ;; (mongo . t)
                               ;; (sql-mode . t)))

;;---------
;;helm-mode
;;---------

(require 'helm-config)
(bind-key "M-x" 'helm-M-x)
(bind-key "C-x C-f" 'helm-find-files)
(bind-key "C-x M-s" 'helm-swoop)

;;---------------
;;projectile-mode
;;---------------

(require 'projectile)

(defun cond-switch-to-buffer()
  (interactive)
  (if (projectile-project-p)
      (projectile-switch-to-buffer)
    (helm-buffers-list)))

(bind-key "C-x b" 'cond-switch-to-buffer)

;;--------------------
;;helm-projectile-mode
;;--------------------

(require 'helm-projectile)
;;(helm-projectile-on)

;; helm-projectile-find-file doesn't support create file
;; (defun resolve-find-file ()
;;   (interactive)
;;   (if (projectile-project-p)
;;       (helm-projectile-find-file)
;;     (helm-find-files nil)))

;; (bind-key "C-x C-f" 'resolve-find-file)

;;---------
;;yasnippet
;;---------

(require 'yasnippet)
(yas-global-mode 1)

;;---
;;ace
;;---

;;(bind-key "C-c a w" 'ace-window)
(bind-key "C-x o" 'ace-window)

;;(bind-key "C-c a j" 'ace-jump-mode)
(bind-key "C-x j" 'ace-jump-mode)

;;(bind-key "C-c a s" 'ace-swap-window)
(bind-key "C-x w" 'ace-swap-window)

;;-----
;;dired
;;-----

(setq dired-listing-switches "--group-directories-first -al")

(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-hide-details-mode 1)))

;;------------
;;ibuffer-mode
;;------------

(setq my-filter-groups
      '(("org" (mode . org-mode))
	("shells"
	 (or
	  (mode . term-mode)
	  (mode . eshell-mode)))
	("dired" (mode . dired-mode))
	("man" (mode . man-mode))
	("info" (mode . info-mode))
	("stars" (name . "^\\*.*"))))

(defun init-filter-groups ()
  (setq ibuffer-saved-filter-groups
	(list (append
	       '("default")
	       (append
		(ibuffer-vc-generate-filter-groups-by-vc-root)
		my-filter-groups)))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (init-filter-groups)
	    (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-show-empty-filter-groups nil)

(setq ibuffer-expert t)

(defun refresh-ibuffer ()
  (interactive)
  (let ((ibuf (get-buffer "*Ibuffer*")))
    (message "refreshing: %s" ibuf)
    (when ibuf
      (kill-buffer ibuf))
    (ibuffer)))

(bind-key "C-x C-b" 'refresh-ibuffer)

;;------------
;;misc key bindings
;;------------

(bind-key "C-?" 'backward-delete-char)
(bind-key "M-?" 'backward-kill-word)
(bind-key "C-c d w" 'delete-trailing-whitespace)
(bind-key "C-c p k" 'describe-personal-keybindings)

(defun insert-four-spaces ()
  (interactive)
  (insert "    "))

(bind-key "C-c s" 'insert-four-spaces)

(defun find-config-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(bind-key "C-c o n f" 'find-config-file)

(defun find-snippets-dir ()
  (interactive)
  (find-file "~/.emacs.d/snippets/"))

(bind-key "C-c C-s n i p" 'find-snippets-dir)

(defun scroll-down-in-place (n)
  (interactive "p")
  (previous-line n)
  (unless (eq (window-start) (point-min))
    (scroll-down n)))

(bind-key "M-p" 'scroll-down-in-place)

(defun scroll-up-in-place (n)
  (interactive "p")
  (next-line n)
  (unless (eq (window-end) (point-max))
    (scroll-up n)))

(bind-key "M-n" 'scroll-up-in-place)

(defun delete-trailing-whitespace-and-save-buffer ()
  (interactive)
  (delete-trailing-whitespace)
  (save-buffer))

(bind-key "C-x C-s" 'delete-trailing-whitespace-and-save-buffer)

;;-------
;;customs
;;-------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-latex-default-packages-alist
   (quote
    (("AUTO" "inputenc" t)
     ("T1" "fontenc" t)
     ("" "fixltx2e" nil)
     ("" "graphicx" t)
     ("" "longtable" nil)
     ("" "float" nil)
     ("" "wrapfig" nil)
     ("" "rotating" nil)
     ("normalem" "ulem" t)
     ("" "amsmath" t)
     ("" "textcomp" t)
     ("" "marvosym" t)
     ("" "wasysym" t)
     ("" "amssymb" t)
     ("colorlinks=true" "hyperref" nil)
     "\\tolerance=1000"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hc-trailing-whitespace ((t (:background "#ebcb8b")))))
 ;;:background "#f2f1f0" :foreground "#4c4c4c"
