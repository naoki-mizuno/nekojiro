(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)
(defvar my-package-list
  '(helm
    )
  "packages to be installed")
(unless package-archive-contents (package-refresh-contents))
(dolist (pkg my-package-list)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;;;; Basic setups
(setq default-directory "~/")
(setenv "ESHELL" shell-file-name)
(fset 'yes-or-no-p 'y-or-n-p)
;; Highlight matching paren
(show-paren-mode t)
;; Indentation level to 4
(setq c-basic-offset 4)
;; Hide tool bar, menu bar, and scroll bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;;;; Backups and autosaves
(setq delete-old-versions t
      ;; Auto-save interval
      auto-save-timeout 1
      auto-save-interval 20
      ;; Safest, but slowest
      backup-by-copying t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(defvar backups_dir "~/.emacs.d/backups/")
(defvar autosaves_dir "~/.emacs.d/autosaves/")
;; Create directories if they don't exist
(if (not (file-directory-p backups_dir))
    (mkdir backups_dir))
(if (not (file-directory-p autosaves_dir))
    (mkdir autosaves_dir))
(setq backup-directory-alist
      `((".*" . ,backups_dir)))
(setq auto-save-file-name-transforms
      `((".*" ,autosaves_dir t)))

;; Save cursor position
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;; Show numbers
(global-linum-mode t)
(setq linum-format "%3d ")

;; Show column number
(setq column-number-mode t)
;; Show time on modeline
(setq display-time-day-and-date t)
(display-time-mode t)
;; Make file executable if file has #! at beginning
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
;; Follow symbolic link
(setq follow-link t)
(setq vc-follow-symlinks t)
;; Save history
(savehist-mode t)
(setq history-length 10000)
;; Enable recursive call in mini-buffer
(setq enable-recursive-minibuffers t)
;; Use Emacs term info, not the system
(setq system-uses-term-info nil)
;; Use Japanese
(set-language-environment 'Japanese)
;; Use utf-8
(prefer-coding-system 'utf-8)
;; Don't show startup message
(setq inhibit-startup-message t)
;; Set tab width to 4, use space instead of tab
(setq-default
 c-basic-offset 4
 tab-width 4
 indent-tabs-mode nil)
;; Enable fuzzy match
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-auto-merge-work-directories-length -1)
;; Auto-reload file when changed
(global-auto-revert-mode t)
;; Show full path of file in modeline
(setq-default mode-line-buffer-identification
              (list 'buffer-file-name
                    (propertized-buffer-identification "%12f")
                    (propertized-buffer-identification "%12b")))

;;; C-h as backspace
(define-key key-translation-map [?\C-h] [?\C-?])
;;; Auto indent
(define-key global-map (kbd "RET") 'newline-and-indent)
;;; Go to previous buffer
(define-key global-map (kbd "C-x O") 'previous-multiframe-window)

(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))


(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)


;;; Helm
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
