;; FONTS
(setq default-frame-alist '((font . "inconsolata")))
;; Get back font antialiasing
(push '(font-backend xft x) default-frame-alist)
;; Set syntax highlighting always on
(global-font-lock-mode t t)
(setq font-lock-maximum-decoration t)

;; HIGHLIGHTING
;; highlight region between point and mark
(transient-mark-mode t)
;; highlight during query
(setq query-replace-highlight t)
;; highlight incremental search
(setq search-highlight t)
;; highlight matching parenthesis'
(show-paren-mode t)
(setq show-paren-style 'mixed)
(delete-selection-mode ) ; delete seleted text when typing

;; RANDOM
;; turn off backup files
(setq make-backup-files nil)
;; Type y for yes and n for no
(fset 'yes-or-no-p 'y-or-n-p)
;; text-mode major mode by default
(setq major-mode 'text-mode)
;; Get rid of the startup screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
;; Default dir, I prefer it to be the dir i start emacs in
;(setq default-directory "~/")
;; Get rid of toolbar, scrollbar, menubar
(tool-bar-mode 0)
;(menu-bar-mode 0)
(scroll-bar-mode 0)

;; FUNCTIONALITY
;; redo
(add-to-list  'load-path "~/.emacs.d/plugins/redo")
(require 'redo)
(global-set-key [(control -)] 'redo)

;; Kills live buffers, leaves some emacs work buffers
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-some-buffers (&optional list)
  "For each buffer in LIST, kill it silently if unmodified. Otherwise ask.
LIST defaults to all existing live buffers."
  (interactive)
  (if (null list)
      (setq list (buffer-list)))
  (while list
    (let* ((buffer (car list))
           (name (buffer-name buffer)))
      (and (not (string-equal name ""))
           ;(not (string-equal name "*Messages*"))
          ;; (not (string-equal name "*Buffer List*"))
           ;(not (string-equal name "*buffer-selection*"))
           ;(not (string-equal name "*Shell Command Output*"))
           (not (string-equal name "work.org"))
           (not (string-equal name "*scratch*"))
           (/= (aref name 0) ? )
           (if (buffer-modified-p buffer)
               (if (yes-or-no-p
                    (format "Buffer %s has been edited. Kill? " name))
                   (kill-buffer buffer))
             (kill-buffer buffer))))
    (setq list (cdr list))))

;; fullscreen
(defun toggle-fullscreen ()
(interactive)
(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
;(toggle-fullscreen)

;; maxframe
(add-to-list  'load-path "~/.emacs.d/plugins/maxframe")
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)
(add-hook 'window-setup-hook 'ecb-redraw-layout t)
(set-background-color "#2b2b2b")
(set-foreground-color "white")
(set-face-background 'modeline "DarkRed")
(set-face-foreground 'modeline "white")

;; Mouse-wheel
(mouse-wheel-mode t)
;; wheel mouse
;(defun up-slightly () (interactive) (scroll-up 5))
;(defun down-slightly () (interactive) (scroll-down 5))
;(global-set-key [mouse-4] 'down-slightly)
;(global-set-key [mouse-5] 'up-slightly)
;(defun up-one () (interactive) (scroll-up 1))
;(defun down-one () (interactive) (scroll-down 1))
;(global-set-key [S-mouse-4] 'down-one)
;(global-set-key [S-mouse-5] 'up-one)
;(defun up-a-lot () (interactive) (scroll-up))
;(defun down-a-lot () (interactive) (scroll-down))
;(global-set-key [C-mouse-4] 'down-a-lot)
;(global-set-key [C-mouse-5] 'up-a-lot)

;; cedet
;; See cedet/common/cedet.info for configuration details.
(load-file "~/.emacs.d/plugins/cedet/common/cedet.el")

;; ecb
(add-to-list 'load-path "~/.emacs.d/plugins/ecb")
(require 'ecb)
(setq ecb-tip-of-the-day nil)
(setq ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
;(ecb-activate)
(custom-set-variables
 '(ecb-layout-name "left3")
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.40")
 '(ecb-windows-width 0.15)
 '(show-paren-mode t))

;; find-recursive
(add-to-list 'load-path "~/.emacs.d/plugins/find-recursive")
(require 'find-recursive)

;; anything
(add-to-list 'load-path "~/.emacs.d/plugins/anything")
(require 'anything)

;; anything-rcodetools
(add-to-list 'load-path "~/.emacs.d/plugins/rcodetools")
(require 'rcodetools)
;(require 'icicles-rcodetools)
(require 'anything-rcodetools)

;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)

;; Rinari
(add-to-list 'load-path "~/.emacs.d/plugins/rinari")
(require 'rinari)
(setq rinari-tags-file-name "TAGS")

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(setq require-final-newline nil)

;; yasnippet rails
(load "~/.emacs.d/plugins/yasnippets-rails/setup.el")

;; autotest
(add-to-list 'load-path "~/.emacs.d/plugins/autotest")
(require 'autotest)

;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
;; (taken from: http://snarfed.org/space/gnu%20emacs%20backup%20files)
(defvar autosave-dir
  (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))
(make-directory autosave-dir t)
(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))
(defun make-auto-save-file-name ()
  (concat autosave-dir
          (if buffer-file-name
              (concat "#" (file-name-nondirectory buffer-file-name) "#")
            (expand-file-name
             (concat "#%" (buffer-name) "#")))))

;; delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; comment bar
(defun comment-bar (&optional without-newline)
  "Create 80 pound signs"
  (interactive "P")
  (insert-char ?# (- 80 (current-column)))
  (if without-newline (beginning-of-line) (newline))
  (indent-according-to-mode))


;; LANGUAGE MODES

;; css
(add-to-list  'load-path "~/.emacs.d/plugins/css-mode")
(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)
(setq auto-mode-alist (append '(("\\.css$" . css-mode)) auto-mode-alist))
(add-hook 'css-mode-hook
         (lambda()
           (local-set-key (kbd "<return>") 'newline-and-indent)
))

;; javascript
(add-to-list  'load-path "~/.emacs.d/plugins/javascript")
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

(defvar javascript-identifier-regexp "[a-zA-Z0-9.$_]+")

(defun javascript-imenu-create-method-index-1 (class bound)
  (let (result)
    (while (re-search-forward (format "^ +\\(\%s\\): *function" javascript-identifier-regexp) bound t)
      (push (cons (format "%s.%s" class (match-string 1)) (match-beginning 1)) result))
    (nreverse result)))

(defun javascript-imenu-create-method-index()
  (cons "Methods"
        (let (result)
          (dolist (pattern (list (format "\\b\\(%s\\) *= *Class\.create" javascript-identifier-regexp)
                                 (format "\\b\\([A-Z]%s\\) *= *Object.extend(%s"
                                         javascript-identifier-regexp
                                         javascript-identifier-regexp)
                                 (format "^ *Object.extend(\\([A-Z]%s\\)" javascript-identifier-regexp)
                                 (format "\\b\\([A-Z]%s\\) *= *{" javascript-identifier-regexp)))
            (goto-char (point-min))
            (while (re-search-forward pattern (point-max) t)
              (save-excursion
                (condition-case nil
                    (let ((class (replace-regexp-in-string "\.prototype$" "" (match-string 1)))
                          (try 3))
                      (if (eq (char-after) ?\()
                          (down-list))
                      (if (eq (char-before) ?{)
                          (backward-up-list))
                      (forward-list)
                      (while (and (> try 0) (not (eq (char-before) ?})))
                        (forward-list)
                        (decf try))
                      (if (eq (char-before) ?})
                          (let ((bound (point)))
                            (backward-list)
                            (setq result (append result (javascript-imenu-create-method-index-1 class bound))))))
                  (error nil)))))
          (delete-duplicates result :test (lambda (a b) (= (cdr a) (cdr b)))))))

(defun javascript-imenu-create-function-index ()
  (cons "Functions"
         (let (result)
           (dolist (pattern '("\\b\\([[:alnum:].$]+\\) *= *function" "function \\([[:alnum:].]+\\)"))
             (goto-char (point-min))
             (while (re-search-forward pattern (point-max) t)
               (push (cons (match-string 1) (match-beginning 1)) result)))
           (nreverse result))))

(defun javascript-imenu-create-index ()
  (list
   (javascript-imenu-create-function-index)
   (javascript-imenu-create-method-index)))

(add-hook 'javascript-mode-hook
  (lambda ()
    (setq imenu-create-index-function 'javascript-imenu-create-index)
    (local-set-key (kbd "<return>") 'newline-and-indent)
  )
t)

;; ruby-mode
(add-to-list 'load-path "~/.emacs.d/plugins/ruby-mode")
(require 'ruby-mode)
(require 'ruby-electric)
(add-hook 'ruby-mode-hook 'turn-on-font-lock)
(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))

;; ruby-block
(add-to-list 'load-path "~/.emacs.d/plugins/ruby-block")
(require 'ruby-block)

;; ruby electric
(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))
(setq hippie-expand-try-functions-list
     '(try-complete-abbrev
   try-complete-file-name
   try-expand-dabbrev))

;; yaml
(add-to-list 'load-path "~/.emacs.d/plugins/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; rdebug
(add-to-list 'load-path "~/.emacs.d/plugins/rdebug")
(require 'rdebug)
(setq rdebug-short-key-mode t)

;; ri-emacs
(setq ri-ruby-script (expand-file-name "~/.emacs.d/plugins/ri-emacs/ri-emacs.rb"))
;(autoload 'ri (expand-file-name "~/.emacs.d/plugins/ri-emacs/ri-ruby.el") nil t)
(load "~/.emacs.d/plugins/ri-emacs/ri-ruby.el")

;; ruby-mode-hook
(add-hook 'ruby-mode-hook
         (lambda()
           (add-hook 'write-file-functions
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
           (set (make-local-variable 'indent-tabs-mode) 'nil)
           (set (make-local-variable 'tab-width) 2)
           (imenu-add-to-menubar "IMENU")
           (ruby-electric-mode t)
           (ruby-block-mode t)
           (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
           (define-key ruby-mode-map "\M-\C-o" 'rct-complete-symbol)
           (local-set-key (kbd "<return>") 'newline-and-indent)
))

;; nxhtml
(setq *nxhtml-autostart-file* (expand-file-name "~/.emacs.d/plugins/nxhtml/autostart.el"))
(load *nxhtml-autostart-file*)
(setq
     nxhtml-global-minor-mode t
     mumamo-chunk-coloring 'submode-colored
     nxhtml-skip-welcome t
     indent-region-mode t
     nxhtml-default-encoding "utf8"
     rng-nxml-auto-validate-flag nil
     nxml-degraded t)
(add-to-list 'auto-mode-alist '("\\.html$" . nxhtml-mumamo-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.erb$" . eruby-nxhtml-mumamo-mode))
(add-hook 'nxhtml-mumamo-mode-hook 'tabkey2-mode)
(add-hook 'eruby-nxhtml-mumamo-mode-hook 'tabkey2-mode)

;; flymake
(add-to-list  'load-path "~/.emacs.d/plugins/flymake")
(require 'flymake)
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))

;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-intemp))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '(".+\\.rjs$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(add-hook 'ruby-mode-hook
          '(lambda ()

             ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
             (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                 (flymake-mode))
             ))

(require 'flymake-jslint)
(add-hook 'javascript-mode-hook
          '(lambda ()
             ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
             (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                 (flymake-mode))
             ))


;; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/plugins/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
  (lambda () (rinari-launch)))

(add-hook 'rhtml-mode
          (let ((original-command (lookup-key rhtml-mode-map [tab])))
            `(lambda ()
               (setq yas/fallback-behavior
                     '(apply ,original-command))
               (local-set-key [tab] 'yas/expand))))


(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)
;(global-auto-complete-mode t)
;(define-key ac-complete-mode-map "\C-n" 'ac-next)
;(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;;     ;; start completion when entered 3 characters
;(setq ac-auto-start 2)
;; Add following code to your .emacs.
;;
;(define-key ac-complete-mode-map "\t" 'ac-complete)
;(define-key ac-complete-mode-map "\r" nil)


;(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
; (when (require 'auto-complete nil t)
;   (require 'auto-complete-yasnippet)
;   (require 'auto-complete-ruby)
;   (require 'auto-complete-css)

   (global-auto-complete-mode t)           ;enable global-mode
   (setq ac-auto-start t)                  ;automatically start
   (setq ac-dwim 3)                        ;Do what i mean
   (setq ac-override-local-map nil)        ;don't override local map
;;   (define-key ac-complete-mode-map "\t" 'ac-expand)
;;   (define-key ac-complete-mode-map "\r" 'ac-complete)
;;   (define-key ac-complete-mode-map "\M-n" 'ac-next)
;;   (define-key ac-complete-mode-map "\M-p" 'ac-previous)
   (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))

   (setq ac-modes
         (append ac-modes
                 '(eshell-mode
                   ;org-mode
                   )))
   (add-hook 'emacs-lisp-mode-hook
             (lambda ()
               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-symbols))))

   (add-hook 'eshell-mode-hook
             (lambda ()
               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-files-in-current-dir ac-source-words-in-buffer))))

   (add-hook 'ruby-mode-hook
             (lambda ()
               (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools)))));)


;; php Mode
(add-to-list 'load-path "~/.emacs.d/plugins/php-mode")
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))


;; org-mode
(add-to-list 'load-path "~/.emacs.d/plugins/org-mode/lisp")
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"))
(setq org-agenda-skip-unavailable-files t)

(setq org-todo-keywords (quote ((sequence "TODO(t)" "NEXT(n)" "CURRENT(a)" "|" "DONE(d)")
 (sequence "WAITING(w)" "CANCELLED(c)"))))

(setq org-todo-keyword-faces
      (quote (("TODO"      :foreground "red"          :weight bold)
              ("NEXT"      :foreground "lightblue"    :weight bold)
              ("DONE"      :foreground "forest green" :weight bold)
              ("WAITING"   :foreground "yellow"       :weight bold)
              ("SOMEDAY"   :foreground "goldenrod"    :weight bold)
              ("CANCELLED" :foreground "orangered"    :weight bold)
              ("QUOTE"     :foreground "hotpink"      :weight bold)
              ("QUOTED"    :foreground "indianred1"   :weight bold)
              ("APPROVED"  :foreground "forest green" :weight bold)
              ("EXPIRED"   :foreground "olivedrab1"   :weight bold)
              ("REJECTED"  :foreground "olivedrab"    :weight bold)
              ("OPEN"      :foreground "magenta"      :weight bold)
              ("CLOSED"    :foreground "forest green" :weight bold))))

;; magit
(add-to-list 'load-path "~/.emacs.d/plugins/magit")
(require 'magit)


;; KEY BINDINGS
(global-set-key [S-backspace] 'backward-delete-char)
(global-set-key (kbd "C-S-Q") 'comment-region)
(global-set-key (kbd "C-S-W") 'uncomment-region)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)
(global-set-key (kbd "C-w") 'clipboard-kill-region)
(global-set-key (kbd "M-w") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-y") 'clipboard-yank)
(global-set-key (kbd "C-c C-c") 'comment-bar)


;; Enabled "advanced" keybindings
(put 'scroll-left 'disabled nil)
