;; MY EMACS CONFIG
;; press C-M-x OR M-x load-file to recompile

;; this is a test message to see if tangle is working
;; wtf it somehow is hallelujah

;; NAVIGATION
;; enables evil mode! (Vim keybindings = better :) )
(add-to-list 'load-path "~/.config/emacs/evil")
(require 'evil)
(evil-mode 1)
;; Make tab expand + collapse bullet points in org mode!
(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
	    (lambda ()
	      (interactive)
	      (evil-delete (point-at-bol) (point))))

;; other cursor stuff
(setq blink-cursor-mode nil)
(set-default 'truncate-lines t)


      ;;; dired-fixups.el --- fixups for dired mode

;; Author: Dino Chiesa
;; Created: Sat, 31 Mar 2012  10:31
;; Version: 0.1

;;

(require 'ls-lisp)

;; (defun ls-lisp-format-time (file-attr time-index now)
;;   "################")

(defun ls-lisp-format-file-size (file-size human-readable)
  "This is a redefinition of the function from `dired.el'. This
      fixes the formatting of file sizes in dired mode, to support very
      large files. Without this change, dired supports 8 digits max,
      which is up to 10gb.  Some files are larger than that.
      "
  (if (or (not human-readable)
	  (< file-size 1024))
      (format (if (floatp file-size) " %11.0f" " %11d") file-size)
    (do ((file-size (/ file-size 1024.0) (/ file-size 1024.0))
	 ;; kilo, mega, giga, tera, peta, exa
	 (post-fixes (list "k" "M" "G" "T" "P" "E") (cdr post-fixes)))
	((< file-size 1024) (format " %10.0f%s"  file-size (car post-fixes))))))


(defun dired-sort-toggle ()
  "This is a redefinition of the fn from dired.el. Normally,
      dired sorts on either name or time, and you can swap between them
      with the s key.  This function one sets sorting on name, size,
      time, and extension. Cycling works the same.
      "
  (setq dired-actual-switches
	(let (case-fold-search)
	  (cond
	   ((string-match " " dired-actual-switches) ;; contains a space
	    ;; New toggle scheme: add/remove a trailing " -t" " -S",
	    ;; or " -U"
	    ;; -t = sort by time (date)
	    ;; -S = sort by size
	    ;; -X = sort by extension

	    (cond

	     ((string-match " -t\\'" dired-actual-switches)
	      (concat
	       (substring dired-actual-switches 0 (match-beginning 0))
	       " -X"))

	     ((string-match " -X\\'" dired-actual-switches)
	      (concat
	       (substring dired-actual-switches 0 (match-beginning 0))
	       " -S"))

	     ((string-match " -S\\'" dired-actual-switches)
	      (substring dired-actual-switches 0 (match-beginning 0)))

	     (t
	      (concat dired-actual-switches " -t"))))

	   (t
	    ;; old toggle scheme: look for a sorting switch, one of [tUXS]
	    ;; and switch between them. Assume there is only ONE present.
	    (let* ((old-sorting-switch
		    (if (string-match (concat "[t" dired-ls-sorting-switches "]")
				      dired-actual-switches)
			(substring dired-actual-switches (match-beginning 0)
				   (match-end 0))
		      ""))

		   (new-sorting-switch
		    (cond
		     ((string= old-sorting-switch "t") "X")
		     ((string= old-sorting-switch "X") "S")
		     ((string= old-sorting-switch "S") "")
		     (t "t"))))
	      (concat
	       "-l"
	       ;; strip -l and any sorting switches
	       (dired-replace-in-string (concat "[-lt"
						dired-ls-sorting-switches "]")
					""
					dired-actual-switches)

	       new-sorting-switch))))))

  (dired-sort-set-modeline)
  (revert-buffer))


(defun dired-sort-set-modeline ()
  "This is a redefinition of the fn from `dired.el'. This one
      properly provides the modeline in dired mode, supporting the new
      search modes defined in the new `dired-sort-toggle'.
      "
  ;; Set modeline display according to dired-actual-switches.
  ;; Modeline display of "by name" or "by date" guarantees the user a
  ;; match with the corresponding regexps.  Non-matching switches are
  ;; shown literally.
  (when (eq major-mode 'dired-mode)
    (setq mode-name
	  (let (case-fold-search)
	    (cond ((string-match "^-[^t]*t[^t]*$" dired-actual-switches)
		   "Dired by time")
		  ((string-match "^-[^X]*X[^X]*$" dired-actual-switches)
		   "Dired by ext")
		  ((string-match "^-[^S]*S[^S]*$" dired-actual-switches)
		   "Dired by size")
		  ((string-match "^-[^SXUt]*$" dired-actual-switches)
		   "Dired by name")
		  (t
		   (concat "Dired " dired-actual-switches)))))
    (force-mode-line-update)))


(provide 'dired-fixups)

      ;;; dired-fixups.el ends here


;; PACKAGES
;; Configure packages
;; Initialize package sources -- Copied from YT vid
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

;; APPEARANCE
;; Text
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "FiraCode Nerd Font Mono" :foundry "CTDB" :slant normal :weight regular :height 143 :width normal)))))

;; Color Theme
;; Loads in a color theme from different directories on the computer
;; Don't really need because spacemacs theme thing does it for me i think? but maybe if i want another theme
;;(setq custom-theme-load-path '("/home/arjuntina/.config/emacs/elpa/spacemacs-theme-0.2/" custom-theme-directory t))
;; Nice built-in one
;;(load-theme 'adwaita)
;; Spacemacs theme
;; t used to autoload the theme on startup :) -- otherwise I get goofy prompt
;;(load-theme 'spacemacs-dark t)
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-palenight t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-palenight") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


;; UI 
(tool-bar-mode -1) ; turn off the stupidly large GUI lol
(menu-bar-mode 1)  ; leave the "file edit ..." bar in case I need it
(global-display-line-numbers-mode nil) ; turn on line numbers
(setq display-line-numbers 'relative) ; turn on RELATIVE line numbers


(setq org-edit-src-content-indentation 0)
;;(setq org-src-preserve-indentation nil)

(setq org-src-tab-acts-natively t)


;; Backup files!
;; I think it's cool that EMACS saves backup files, but I don't want the clutter
;; Option 1: Disable backup files with code below!
;; (setq make-backup-files nil)
;; Option 2: (from stack overflow) Push all the backups to a directory that you can go hunting for if you really want to!
;; find out more about the options with 'C-h v backup-directory-alist' apparently
(setq backup-directory-alist '(("." . "~/Backups/emacsBackups"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

;; Custom keybindings

;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Better window resize (suggestion copied from the emacs wiki) -- investigate
;; Change ctrl-x ctrl-b to open the buffer window in a new window below the current one instead of replacing the other window in a split screen >:(
;; (defun custom-buffer-interaction ()
;;  "Splits the scren in two and launches a new buffer in the split screen"
;;  (interactive)
;;  (split-window-below)
;;  (buffer-menu-other-window))
;;(global-set-key (kbd "C-x C-b") 'custom-buffer-interaction)

;; Split windows in sensible ways (customize behavior later!!)
;; Need to do bc otherwise org-roam splits vertically (ew)
;; Two key variables -- split-height-threshold & split-width-threshold
;; both measure size how? honestly i'm not sure
;; Logic
;; 1) If height > split-height-threshold, splits vertically (one above the other)
;; 2) else if width > split-width-threshold, splits horizontally (one next to the other)
;; 3) else split window vertically
;; my customization: to make split-height-threshold really big so that it always goes to split-width-threshold? I hope it works
(setq
 split-height-threshold 2000
 split-width-threshold 20)

;; IVY completions
;; not too sure what it is/how it works, but I think this is the most complete finder there is? hmmm
(ivy-mode 1)
;; not really sure if I want it or not, but this allows IVY to store recent files & let me navigate to them as if they were buffers
;; Recommended by those who made the package!
(setq ivy-use-virtual-buffers t)
;; Another recommended setting?
;; changes the way the search file functionality works in IVY mode
;; see https://oremacs.com/swiper/ for more info!
;; change string to "(%d/%d) " to view the number of files as a list of integers!
;; change string to "" to view the file as just a list
(setq ivy-count-format "(%d/%d) ")


;; modify help buffer to always display help in the same window instead of "intelligently" trying to display stuff in new windows
;; idk how the syntax works -- just copied from the manual
;; investigate later so learn how to make custom commands!
;; Source: https://www.gnu.org/software/emacs/manual/html_node/emacs/Window-Choice.html
(setopt
 display-buffer-alist
 '(("\\*Help\\*" (display-buffer-same-window))))

;; ORG MODE
;; allow for tabbing to indent bullet points :) RIP
;; make org mode automatically create indented bullet points after enter
;; (require 'org-autolist)
;; (add-hook 'org-mode-hook (lambda () (org-autolist-mode)))

;; hide excessive markings :) -- don't need to see all the formatting
;; (setq org-hide-emphasis-markers t)

;; make the bullet points look nicer :)
;; using org-superstar-mode and not org-mode because org-bullets is no longer maintained!
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-superstar-headline-bullets-list '("◉" 10022 "" 9675 9663))

;; Startup orgmode with images
(setq org-startup-with-inline-images t)
;; make the bullet points tabbed + nicer to look at
;; (setq org-startup-indented t)

;; make collapsed bullet points less distracting + prettier
(setq org-ellipsis " ▾")

;; hide leading asterisks of bullet points!
(setq org-hide-leading-stars t)

;; Change size of different headings
(dolist (face '((org-level-1 . 1.2)
		(org-level-2 . 1.1)
		(org-level-3 . 1.05)
		(org-level-4 . 1.0)
		(org-level-5 . 1.0)
		(org-level-6 . 1.0)
		(org-level-7 . 1.0)
		(org-level-8 . 1.0)))
  ;; change the font used in org mode to proportional font! bc not code :)
  (set-face-attribute (car face) nil :font "Nunito" :weight 'medium :height (cdr face)))
;; copy n paste images into emacs

(require 'org-download)
;; enables drag-and-drop to `dired` view!
(add-hook 'dired-mode-hook 'org-download-enable)
(setq-default org-download-image-dir (concat "~/Files/noteFiles/RoamImages/"))

;;(defun my-org-download-method (link)
  ;;(let ((filename
         ;;(file-name-nondirectory
          ;;(car (url-path-and-query
                ;;(url-generic-parse-url link)))))
        ;;(dirname (concat ("~/Files/noteFiles/RoamImages/" file-name-sans-extension (buffer-name)) "-img")))
	;;(make-directory dirname)
    ;;(expand-file-name filename dirname)))

;;(setq org-download-heading-lvl "")
;;(setq org-download-image-org-width 500)
;; (setq org-download-image-html-width 500)
;; (setq org-download-timestamp "")


;;(defun my-org-download-method (link)
;;"org download method for adding inserted images to a correct directory :)"
;;(let ((dirname (concat "/home/arjuntina/Files/noteFiles/RoamImages/" (file-name-base (buffer-name)) "-img")))
;;(make-directory dirname)
;;(expand-file-name filename dirname)))
;;
;;(setq org-download-method 'my-org-download-method)
;;
;;(defun my-org-download-method (link)
;;(let ((filename
;;(file-name-nondirectory
;;(car (url-path-and-query
;;(url-generic-parse-url link)))))
;;(dirname (file-name-sans-extension (buffer-name)) ))
	    ;;;; if directory not exist, create it
;;(unless (file-exists-p dirname)
;;(make-directory dirname))
	    ;;;; return the path to save the download files
;;(expand-file-name filename dirname)))
;;
  ;;;; only modify `org-download-method' in this project
;;(setq-local org-download-method 'my-org-download-method)


;; Put this in your init file: (setq dired-dwim-target t). Then, go to dired, split your window, split-window-vertically & go to another dired directory. When you will press C to copy, the other dir in the split pane will be default destination.
(setq dired-dwim-target t)
;; Auctex
;;(use-package tex
;;  :ensure auctex)
(setq-default org-preview-latex-default-process 'dvipng)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.75)) 
;; see this site: https://so.nwalsh.com/2020/01/05-latex 
;; learn more about latex customization in emacs!
(setq org-latex-packages-alist '())
(add-to-list 'org-latex-packages-alist '("version=4" "mhchem" t))

;; check this (http://orgmode.org/worg/) -- especially the org-tutorial folder :)


;; Org Roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Files/noteFiles/RoamNotes"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n g" . org-roam-graph)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n c" . org-roam-capture))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

(defun scimax/org-return ()
  "Add new list or headline "
  (interactive)
  (cond
   ((org-in-item-p)
    (if (org-element-property :contents-begin (org-element-context))
	(org-insert-heading)
      (beginning-of-line)
      (kill-line)
      (org-return)))
   ((org-at-heading-p)
    (if (not (string= "" (org-element-property :title (org-element-context))))
	(org-insert-heading)
      (beginning-of-line)
      (kill-line)
      (org-return)))
   ((org-at-table-p)
    (if (-any?
	 (lambda (x) (not (string= "" x)))
	 (nth
	  (- (org-table-current-dline) 1)
	  (org-table-to-lisp)))
	(org-return)
      ;; empty row
      (beginning-of-line)
      (kill-line)
      (org-return)))
   (t
    (org-return))))

(define-key org-mode-map (kbd "RET")
	    'scimax/org-return)


(setq org-image-actual-width nil)

(use-package consult-org-roam
  :ensure t
  :after org-roam
  :init
  (require 'consult-org-roam)
  ;; Activate the minor mode
  (consult-org-roam-mode 1)
  :custom
  ;; Use `ripgrep' for searching with `consult-org-roam-search'
  (consult-org-roam-grep-func #'consult-ripgrep)
  ;; Configure a custom narrow key for `consult-buffer'
  (consult-org-roam-buffer-narrow-key ?r)
  ;; Display org-roam buffers right after non-org-roam buffers
  ;; in consult-buffer (and not down at the bottom)
  (consult-org-roam-buffer-after-buffers t)
  :config
  ;; Eventually suppress previewing for certain functions
  (consult-customize
   consult-org-roam-forward-links
   :preview-key (kbd "M-."))
  :bind
  ;; Define some convenient keybindings as an addition
  ("C-c n e" . consult-org-roam-file-find)
  ("C-c n b" . consult-org-roam-backlinks)
  ;; ("C-c n l" . consult-org-roam-forward-links)
  ("C-c n r" . consult-org-roam-search))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(add-hooks counsel org-autolist org-roam org-superstar doom-themes))
 '(tool-bar-mode nil))


(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "w v" 'evil-window-vsplit)
(evil-leader/set-key "w c" 'evil-window-delete)

(evil-leader/set-key "w h" 'evil-window-left)
(evil-leader/set-key "w j" 'evil-window-down)
(evil-leader/set-key "w k" 'evil-window-up)
(evil-leader/set-key "w l" 'evil-window-right)

(evil-leader/set-key "b b" 'ivy-switch-buffer)
(evil-leader/set-key "b r" 'revert-buffer)

(evil-leader/set-key "o i" 'org-download-clipboard)

(evil-leader/set-key "o r i" 'org-roam-node-insert)
(evil-leader/set-key "o r l" 'org-roam-buffer-toggle)
(evil-leader/set-key "o r f" 'org-roam-node-find)

(evil-leader/set-key "d" 'dired)

(evil-leader/set-key "f l" 'load-file)
(evil-leader/set-key "f s" 'save-some-buffers)


(require 'which-key)
(which-key-mode)


(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))
