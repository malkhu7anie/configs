;; setting melpa
(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-refresh-contents)
(package-initialize)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; lsp-mode 
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))

;; lsp-java
(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

(setq lsp-print-performacs t)

;;(use-package lsp-mode
  ;;:commands (lsp lsp-deferred)
  ;;:hook ((prog-mode . lsp-deferred)
         ;;(lsp-mode . lsp-enable-which-key-integration))
  ;;:custom
  ;;(lsp-enable-folding nil)
  ;;(lsp-enable-links nil)
  ;;(lsp-enable-snippet nil)
  ;;(lsp-keymap-prefix "C-c ;")
  ;;(lsp-session-file (expand-file-name (format "%s/emacs/lsp-session-v1"  xdg-data)))
  ;;(read-process-output-max (* 1024 1024)))


;; clangd
;;(require 'eglot)
;; (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'c++-mode-hook 'eglot-ensure)

 ;;(use-package ccls
   ;;:after projectile
   ;;:ensure-system-package ccls
   ;;:custom
   ;;(ccls-args nil)
   ;;(setq ccls-executable "/home/malkhu7anie/src/ccls/Release/ccls")
   ;;(projectile-project-root-files-top-down-recurring
    ;;(append '("compile_commands.json" ".ccls")
            ;;projectile-project-root-files-top-down-recurring))
   ;;:config (push ".ccls-cache" projectile-globally-ignored-directories))
;;(use-package company-lsp   
  ;;:ensure t :commands company-lsp   
  ;;:config (push 'company-lsp company-backends)) 
;;(use-package ccls
  ;;:hook ((c-mode c++-mode objc-mode cuda-mode) .
         ;;(lambda () (require 'ccls) (lsp))))

;;(setq ccls-executable "/home/malkhu7anie/src/ccls/Release/ccls")    

(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package cmake-font-lock
  :after (cmake-mode)
  :hook (cmake-mode . cmake-font-lock-activate))

(use-package cmake-ide
  :after projectile
  :hook (c++-mode . my/cmake-ide-find-project)
  :preface
  (defun my/cmake-ide-find-project ()
    "Finds the directory of the project for cmake-ide."
    (with-eval-after-load 'projectile
      (setq cmake-ide-project-dir (projectile-project-root))
      (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
    (setq cmake-ide-compile-command
            (concat "cd " cmake-ide-build-dir " && cmake .. && make"))
    (cmake-ide-load-db))

  (defun my/switch-to-compilation-window ()
    "Switches to the *compilation* buffer after compilation."
    (other-window 1))
  :bind ([remap comment-region] . cmake-ide-compile)
  :init (cmake-ide-setup)
  :config (advice-add 'cmake-ide-compile :after #'my/switch-to-compilation-window))


;; java 
;; (use-package lsp-java
  ;; :ensure t
  ;; :hook (java-mode . lsp-deferred)
  ;; :custom (lsp-java-server-install-dir
           ;; (expand-file-name (format "%s/eclipse.jdt.ls/" xdg-lib))))
;; 
;; (use-package gradle-mode
  ;; :hook (java-mode . gradle-mode)
  ;; :preface
  ;; (defun my/switch-to-compilation-window ()
    ;; "Switch to the *compilation* buffer after compilation."
    ;; (other-window 1))
  ;; :bind (:map gradle-mode-map
              ;; ("C-c C-c" . gradle-build)
              ;; ("C-c C-t" . gradle-test))
  ;; :config
  ;; (advice-add 'gradle-build :after #'my/switch-to-compilation-window)
  ;; (advice-add 'gradle-test :after #'my/switch-to-compilation-window))
;; evil mode 
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; which key 
(use-package which-key
	     :ensure t
  :init
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit t
        which-key-separator " → " ))
(which-key-mode)

;; prjectile
(unless (package-installed-p 'projectile)
  (package-install 'projectile))

;; treemacs 
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                5000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

;; end of treemacs 

;; dashboard 
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner
(setq dashboard-startup-banner "/home/malkhu7anie/emacs.png")
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)

;; gui 
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(global-visual-line-mode t)

(menu-bar-mode -1)
(tool-bar-mode -1)

;; c++ indentation
(defun set-newline-and-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'c++-mode-hook 'set-newline-and-indent)

;; java indentation
(add-hook 'java-mode-hook (lambda ()
                                (setq c-basic-offset 4
                                      tab-width 4
                                      indent-tabs-mode t)))

;; disabling gnu indentation style
(setq c-default-style "linux"
          c-basic-offset 4)

;; enabling electric-pair
(electric-pair-mode 1)

;; highlighting brackets
(show-paren-mode 1)

;; demo-it
;;(require 'demo-it)   ;; Load this library of functions
;;
;;(defun my-demo-step/show-code ()
  ;;"Helper demo function that displays some source code and
;;advances the presentation at one time."
  ;;(demo-it-load-file "example/example.py" :right)
  ;;(demo-it-presentation-advance))
;;
;;;; Order the functions and forms for this presentation:
;;(demo-it-create (demo-it-presentation "example/example.org")
                 ;;my-demo-step/show-code
                 ;;demo-it-presentation-return ; close file and advance
                ;;(demo-it-run-in-eshell "python example/example.py"))
;;
;;(demo-it-start)

;; enabling ligatures
;; Enable the www ligature in every possible major mode
;;(ligature-set-ligatures 't '("www"))

;; Enable ligatures in programming modes                                                           
;;(ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                     ;;":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                     ;;"-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                     ;;"#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                     ;;"/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                     ;;"++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                     ;;"=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                     ;;"<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                     ;;"<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                     ;;"<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
;;
;;(global-ligature-mode 't)

;; fonts
;; Set default font
;;(set-face-attribute 'default nil
 ;;                   :family "Fira Code, Light")
                    ;;:height 110
                    ;;:weight 'normal
                    ;;:width 'normal)
;; zoom in/out like we do everywhere else.
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; scrolling 
(setq
 scroll-conservatively 1000                     ;; only 'jump' when moving this far
 scroll-margin 4                                ;; scroll N lines to screen edge
 scroll-step 1                                  ;; keyboard scroll one line at a time
 mouse-wheel-scroll-amount '(6 ((shift) . 1))   ;; mouse scroll N lines
 mouse-wheel-progressive-speed nil              ;; don't accelerate scrolling

 redisplay-dont-pause t                         ;; don't pause display on input

 ;; Always redraw immediately when scrolling,
 ;; more responsive and doesn't hang!
 fast-but-imprecise-scrolling nil
 jit-lock-defer-time 0
 )

;; themes 
;; nord theme

(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))

;; solarized theme
(use-package solarized-theme
	     :ensure t)

;; doom-themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'nord t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;;(load-theme 'solarized-light t)

;; disabling confirmation for kill processes 
(setq kill-buffer-query-function nil)
;; status bar 
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; yasnippets
(use-package yasnippet
 :ensure t)

;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (lsp-javacomp eglot doom-modeline company ccls vertico smart-mode-line-powerline-theme powerline smart-mode-line nordless-theme ## all-the-icons neotree treemacs-persp treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil treemacs company-lsp which-key use-package lsp-ui evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(global-set-key [f8] 'neotree-toggle)


;; all-the-icons
(use-package all-the-icons
  :if (display-graphic-p))

;; Enable vertico
;;(use-package vertico
;;  :init
  ;;:ensure t
 ;; (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
 ;; )

;; Optionally use the `orderless' completion style. See
;; `+orderless-dispatch' in the Consult wiki for an advanced Orderless style
;; dispatcher. Additionally enable `partial-completion' for file path
;; expansion. `partial-completion' is important for wildcard support.
;; Multiple files can be opened at once with `find-file' if you enter a
;; wildcard. You may also give the `initials' completion style a try.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
;;(use-package emacs
  ;;:init
  ;;;; Add prompt indicator to `completing-read-multiple'.
  ;;;; Alternatively try `consult-completing-read-multiple'.
  ;;(defun crm-indicator (args)
    ;;(cons (concat "[CRM] " (car args)) (cdr args)))
  ;;(advice-add #'completing-read-multiple :filter-args #'crm-indicator)
;;
  ;;;; Do not allow the cursor in the minibuffer prompt
  ;;(setq minibuffer-prompt-properties
        ;;'(read-only t cursor-intangible t face minibuffer-prompt))
  ;;(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
;;
  ;;;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;;;; Vertico commands are hidden in normal buffers.
  ;;;; (setq read-extended-command-predicate
  ;;;;       #'command-completion-default-include-p)
;;
  ;;;; Enable recursive minibuffers
  ;;(setq enable-recursive-minibuffers t))
