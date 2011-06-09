;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Macros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun insert-java-print ()
  "Macro for inserting Java print command."
  (interactive)
  (insert "System.out.println(\"\");")
  (backward-char) ; Move cursor just after the initial quote
  (backward-char)
  (backward-char)
  (indent-for-tab-command)
)

(defun copy-line ()
  "Macro for copying the current line into the buffer."
  (interactive)
  (beginning-of-line)
  (set-mark-command)
  (end-of-line)
  ;(kill-ring-save)
)

(defun html-href ()
  "Macro for generating the HTML for an HREF tag."
  (interactive)
  ;(set-mark-command)
  ;(forward-char)
  ;(forward-char)
  ;(forward-char)
  ;(kill-region)
  (insert "<A HREF=\"\"></A>")
  (backward-char) ; Move cursor just after the initial quote
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  ;(kill-ring-save)
)

(fset 'insert-warn
   [?w ?a ?r ?n ?( ?" ?\\ ?n ?" ?) ?; left left left left left])

(fset 'my-copy-line
   [?\C-a ?\C-  ?\C-e escape ?w return ?\C-y ?\C-a])

(global-set-key (quote [f1]) 'insert-warn)
(global-set-key (quote [f2]) 'query-replace)
(global-set-key (quote [f3]) 'font-lock-mode)
(global-set-key (quote [f4]) 'insert-java-print)
(global-set-key (quote [f5]) 'my-copy-line)
(global-set-key "\C-x\C-g" 'goto-line)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-set-style "k&r")
	    (setq c-basic-offset 4)))

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(put 'downcase-region 'disabled nil)

;; Turn on Column Number mode
(setq column-number-mode 1)

(global-set-key "\C-h" 'delete-backward-char)
;(global-set-key "\C-?" 'delete-char)

(setq load-path
      (append (list nil "~/emacs/elisp"
                    "/usr/local/share/emacs/site-lisp")
              load-path))

(setq load-path
      (append load-path
	      '("~/emacs/elisp/ecb/lisp/ecb")))

(autoload 'maniac-fill-mode "maniac" nil t)

;; Enable mouse scroller on vertical scroll bar
(global-set-key [vertical-scroll-bar mouse-4] 'scroll-down)
(global-set-key [vertical-scroll-bar mouse-5] 'scroll-up)

;; Enable mouse scroller in active window
(global-set-key [mouse-4] 'scroll-down)
(global-set-key [mouse-5] 'scroll-up)

;; Visual feedback on selections
(setq-default transient-mark-mode t)

;; Enable wheelmouse support by default
(cond (window-system
       (mwheel-install)
))

(require 'mmm-mode)
(setq mmm-global-mode 't)
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
(mmm-add-mode-ext-class 'html-mode "\\.html\\'" 'mason)

;; Load the Emacs Code Browser
;;(require 'ecb)

(add-hook 'nethack-map-mode-hook
	  (lambda ()
	    (define-key nh-map-mode-map (kbd "<left>") 'nethack-command-west)
	    (define-key nh-map-mode-map (kbd "<up>") 'nethack-command-north)
	    (define-key nh-map-mode-map (kbd "<down>") 'nethack-command-south)
	    (define-key nh-map-mode-map (kbd "<right>") 'nethack-command-east)
	    (define-key nh-map-mode-map (kbd "<kp-add>") 'nethack-command-northwest)
	    (define-key nh-map-mode-map (kbd "<prior>") 'nethack-command-northeast)
	    (define-key nh-map-mode-map (kbd "<end>") 'nethack-command-southwest)
	    (define-key nh-map-mode-map (kbd "<next>") 'nethack-command-southeast)
))

(add-to-list 'load-path "~/emacs/elisp/nethack/")
(autoload 'nethack "nethack" "Play Nethack." t)
(setq nethack-program "/usr/games/nethack-lisp")

;; Set the default font
;;(setq initial-frame-alist
;;      '((top . 40) (left . -15)
;;	(width . 80) (height . 40)
;;	(background-color . "Gray94")
;;	(foreground-color . "Black")
;;	(cursor-color . "red3")
;;	(user-position t)
;;	(font . "-bitstream-courier-*-r-*-*-18-*-*-*-*-*-*-*")
;;))

;;(require 'mailcrypt-init)

;; (load-library "mailcrypt")
;; (mc-setversion "gpg")

(defvar org-sys-directory "/home/jerrell/org-6.31a/lisp" "The directory containing the org distribution.")
(setq load-path (cons org-sys-directory load-path))
(setq org-startup-indented t)

(setq imenu-max-items 50)

(setq org-mobile-inbox-for-pull "/home/www/htdocs/bordercore/dav/mobileorg.org/")
(setq org-mobile-directory "/home/www/htdocs/bordercore/dav/")

;; disable the splash screen
(setq inhibit-splash-screen t)

;; for re-builder mode, set the syntax to 'string' to avoid extra escaping
(setq reb-re-syntax 'string)
