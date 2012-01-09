;; font �ݒ�
(setq mac-allow-anti-aliasing t) ;; �A���`�G�C���A�X
;; �t�H���g�Z�b�g�����
(let* ((fontset-name "myfonts") ; �t�H���g�Z�b�g�̖��O
       (size 15) ; ASCII�t�H���g�̃T�C�Y [9/10/12/14/15/17/19/20/...]
       (asciifont "Menlo") ; ASCII�t�H���g
       (jpfont "Hiragino Maru Gothic ProN") ; ���{��t�H���g
       (font (format "%s-%d:weight=normal:slant=normal" asciifont size))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)) 
       (fsn (create-fontset-from-ascii-font font nil fontset-name)))
  (set-fontset-font fsn 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font fsn 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font fsn 'katakana-jisx0201 jp-fontspec) ; ���p�J�i
  (set-fontset-font fsn '(#x0080 . #x024F) fontspec) ; �������t�����e��
  (set-fontset-font fsn '(#x0370 . #x03FF) fontspec) ; �M���V������
  )

;; �f�t�H���g�̃t���[���p�����[�^�Ńt�H���g�Z�b�g���w��
(add-to-list 'default-frame-alist '(font . "fontset-myfonts"))

;; �t�H���g�T�C�Y�̔��ݒ�
(dolist (elt '(("^-apple-hiragino.*" . 1.2)
		 (".*osaka-bold.*" . 1.2)
		 (".*osaka-medium.*" . 1.2)
		 (".*courier-bold-.*-mac-roman" . 1.0)
		 (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
		 (".*monaco-bold-.*-mac-roman" . 0.9)))
    (add-to-list 'face-font-rescale-alist elt))

;; �f�t�H���g�t�F�C�X�Ƀt�H���g�Z�b�g��ݒ�
;; # ����͋N������ default-frame-alist �ɏ]�����t���[����
;; # �쐬����Ȃ����ۂւ̑Ώ�
(set-face-font 'default "fontset-myfonts")

;; �e�[�}�ǂݍ���
(add-to-list 'load-path "/opt/local/share/emacs/site-lisp/color-theme-6.6.0")
 (require 'color-theme)
 (eval-after-load "color-theme"
 	'(progn
 		(color-theme-initialize)
 		(color-theme-clarity)))
;; �����x
(set-frame-parameter (selected-frame) 'alpha '(85 60))
;; �E�B���h�E�T�C�Y
(cond (window-system
       (setq default-frame-alist
             (append (list
                      '(width  . 140)
                      '(height . 60)
                      '(top    . 0)
                      '(left   . 0)
                      )
                     initial-frame-alist))
       ))
 
;; paren ����
(show-paren-mode t)

(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)
;; (setq show-paren-style 'mixed)
;; (set-face-background 'show-paren-match-face "#330066")
;; (set-face-foreground 'show-paren-match-face "99ff33")
(set-face-attribute 'show-paren-match-face nil :weight 'extra-bold)
;;(set-face-attribute 'show-paren-match-face nil
;;                    :background nil :foreground nil
;;                    :underline "#ffff00" :weight 'extra-bold)

;; goto
(global-set-key "\M-g" 'goto-line)
;; scroll
(setq scroll-step 3)
;; ���s
(setq require-final-newline t)
;; �^�C�g���o�[
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))
;; 

;; �J�[�\���F��IME��ON/OFF�ŕύX
;; ���܂������Ȃ��B�B�B

;; load path �ݒ�
(add-to-list 'load-path "~/.emacs.d/site-lisp" )
(add-to-list 'load-path "~/.emacs.d/auto-install" )

;; auto-install.el
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup) ; �݊����m��

;; anything
(require 'anything-startup)

(defun my-anything-filelist+ ()
  "Preconfigured `anything' to open files/buffers/bookmarks instantly.
This is a replacement for `anything-for-files'."
  (interactive)
  (anything-other-buffer
   '(anything-c-source-ffap-line
     anything-c-source-ffap-guesser
     anything-c-source-buffers+
     anything-c-source-recentf
     anything-c-source-bookmarks
     anything-c-source-file-cache
;;     anything-c-source-filelist
     anything-c-source-mac-spotlight
     )
   "*anything file list*"))

;; (setq anything-c-filelist-file-name "/Users/tmaeda/tmp/all.filelist")
;; (setq anything-grep-candidates-fast-directory-regexp "^/tmp")
;;;;;;;;;;;;;;;;;;;
;; anything-kill-ring
(defun anything-kill-ring ()
  (interactive)
  (anything 'anything-c-source-kill-ring nil nil nil nil "*anything kill ring*"))

(global-set-key (kbd "M-y") 'anything-kill-ring)
(global-set-key (kbd "C-;") 'my-anything-filelist+)
;; reconf-ext
(require 'recentf-ext)
(recentf-mode t)
(setq recentf-max-saved-items 3000)


(setq make-backup-files t)           ;; �o�b�N�A�b�v�t�@�C�����܂Ƃ߂�
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
    backup-directory-alist))
(setq version-control t)             ;; �����̃o�b�N�A�b�v������Ǘ�
(setq kept-new-versions 5)           ;; �V�������̂������c����
(setq kept-old-versions 5)           ;; �Â����̂������c����
(setq delete-old-versions t)         ;; �m�F�����ɌÂ����̂������B
(setq vc-make-backup-files t)        ;; �o�[�W�����Ǘ����̃t�@�C�����o�b�N�A�b�v�����B
(setq auto-save-default nil)         ;; #hoge#�t�@�C�������Ȃ�

;; ����N�����Ƀt�@�C���̊J��������̂܂܂ɂ��Ă����
(require 'session)
(setq session-undo-check -1)
(add-hook 'after-init-hook 'session-initialize)

;; auto-save ����ɕۑ����Ă����
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 3)
(auto-save-buffers-enhanced t)

;; emacs�N������Python�̃p�X��port select�������̂ɂ��킹��
(dolist (dir (list  
              "/sbin"  
              "/usr/sbin"  
              "/bin"  
              "/usr/bin"  
              "/opt/local/bin"  
              "/sw/bin"  
              "/usr/local/bin"  
	      "/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin"
              (expand-file-name "~/bin")  
              (expand-file-name "~/.emacs.d/bin")  
              ))  
 ;; PATH �� exec-path �ɓ�������ǉ����܂�  
 (when (and (file-exists-p dir) (not (member dir exec-path)))  
   (setenv "PATH" (concat dir ":" (getenv "PATH")))  
   (setq exec-path (append (list dir) exec-path))))
(setenv "MANPATH" (concat "/usr/local/man:/usr/share/man:/Developer/usr/share/man:/sw/share/man" (getenv "MANPATH")))

;;; key �ݒ�
;; Option��Command�L�[����ւ�
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
;; �V�X�e���V���[�g�J�b�g��D�悵�Ȃ�?
(setq mac-pass-control-to-system nil)
(setq mac-pass-command-to-system nil)
(setq mac-pass-option-to-system nil)

; ���{��
(set-language-environment 'Japanese)
; utf-8
(prefer-coding-system 'utf-8-unix)
; backspace
(global-set-key "\C-h" 'delete-backward-char)
;;; �s�ԍ���\������
(line-number-mode t)
(global-linum-mode t)
;;; �N�����̉�ʂ͂���Ȃ�
(setq inhibit-startup-message t)
;;; �t�@�C���I�[�v�����ɁA�t�@�C���_�C�A���O��\���������ɁA
;;; �~�j�o�b�t�@�ɂē��͂ł���悤�ɂ���
(setq use-file-dialog nil)

;; moccur
(require 'color-moccur)
(require 'moccur-edit)

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(push '(dired-mode :position top :noselect t) popwin:special-display-config)


;; undo, redo
(require 'redo+)
(require 'undo-tree)
(global-undo-tree-mode)

;; yasnippet
(add-to-list 'load-path
              "~/.emacs.d/site-lisp/yasnippet-0.6.1c")
(require 'yasnippet)
;;  (setq yas/trigger-key nil)
(setq yas/trigger-key "C-,")
;; �R�����g�⃊�e�����ł̓X�j�y�b�g��W�J���Ȃ�
(setq yas/buffer-local-condition
      '(or (not (or (string= "font-lock-comment-face"
                             (get-char-property (point) 'face))
                    (string= "font-lock-string-face"
                             (get-char-property (point) 'face))))
           '(require-snippet-condition . force-in-comment)))
(yas/load-directory "~/.emacs.d/site-lisp/yasnippet-0.6.1c/snippets")
(setq yas/prompt-functions '(yas/x-prompt yas/dropdown-prompt))
(yas/initialize)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(ac-config-default)
(setq ac-auto-start 3)
(setq ac-auto-show-menu 0.7)
(setq ac-dwim t)
(setq ac-stop-flymake-on-completing t)
(define-key ac-mode-map (kbd "C-.") 'auto-complete)
(setq ac-use-menu-map t)
;; �f�t�H���g�Őݒ�ς�
;; 20�s���\��
(setq ac-menu-height 20)

;; js2-mode
(add-to-list 'load-path "~/.emacs.d/js2-mode" )
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; for rst-mode
(setq frame-background-mode 'dark)
;; for coffee mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/coffee-mode")
(require 'coffee-mode)

;; python
(add-hook 'python-mode-hook '(lambda () 
     (define-key python-mode-map "\C-m" 'newline-and-indent)))
  (when (load "flymake" t) 
         (defun flymake-pyflakes-init () 
           (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                              'flymake-create-temp-inplace)) 
              (local-file (file-relative-name 
                           temp-file 
                           (file-name-directory buffer-file-name)))) 
             (list "pyflakes" (list local-file)))) 

         (add-to-list 'flymake-allowed-file-name-masks 
                  '("\\.py\\'" flymake-pyflakes-init))) 

   (add-hook 'find-file-hook 'flymake-find-file-hook)

;; flymake
(require 'flymake-cursor) ;; tooltip���o���悤�ɒ��ڏ�������
;; (require 'flymake-extension)
;; (setq flymake-extension-use-showtip t)
;; (setq flymake-extension-auto-show t)
(global-set-key "\C-cff" 'flymake-goto-next-error)
(global-set-key "\C-cfb" 'flymake-goto-prev-error)

(require 'rfringe)
(custom-set-faces
  '(flymake-errline 
     ((((class color)) 
     (:italic t :underline "red" :weight extra-bold))))
  '(flymake-warnline 
     ((((class color)) 
       (:italic t :underline "violet" :weight extra-bold)))))

;; org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-default-notes-file  "~/Dropbox/org/inbox.org")
(setq org-todo-keywords '((sequence "TASK(t)"  "STARTED(s)"  "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")
                          (sequence  "APPT(a)" "|" "DONE(x)" "CANCEL(c)")
                          (sequence "NEXT(n)" "|" "DONE(x)")))
(setq org-capture-templates
  '(("t" "Task" entry (file+headline "~/Dropbox/org/task.org" "TaskList")
         "* TASK [%^G]%u %?\n %i\n %a")
    ("c" "CodeReading" entry (file+headline "~/Dropbox/org/codereding.org" "CodeReadingList")
         "* COMMENT [%^G]%U %?\n %i\n %a")
    ("j" "Journal" entry (file+datetree "~/Dropbox/org/journal.org")
         "* [%^G]%U %?\n %i\n %a")
    ("m" "Memo" entry (file+headline "~/Dropbox/org/notes.org" "MemoList")
         "* [%^G]%U %?\n %i")
))



