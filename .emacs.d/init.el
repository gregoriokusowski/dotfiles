;; UI stuff
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(load-theme 'adwaita)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)
(setq frame-title-format nil)

;; Packages
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1))
  (use-package evil-collection
    :ensure t
    :config
    (evil-collection-init))
  (use-package evil-nerd-commenter
    :ensure t)
  (use-package evil-easymotion
    :ensure t))

(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
	helm-mode-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-locate-fuzzy-match t
	helm-semantic-fuzzy-match t
	helm-imenu-fuzzy-match t
	helm-completion-in-region-fuzzy-match t
	helm-candidate-number-list 150
	helm-split-window-in-side-p t
	helm-move-to-line-cycle-in-source t
	helm-echo-input-in-header-line t
	helm-autoresize-max-height 0
	helm-autoresize-min-height 20)
	:config
	(helm-mode 1)
	(use-package helm-ag
	    :ensure t))

;; Offers project support/switch/etc
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  (setq projectile-completion-system 'helm)
  :config
  (projectile-mode 1)
  (use-package helm-projectile :ensure t)
  (use-package neotree
    :ensure t
    :init
    (setq projectile-switch-project-action 'neotree-projectile-action)
    :config
    (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
    (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
    (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
    (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
    (evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
    (evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
    (evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)))

;; Shows the available shortcuts in a side window
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode 1)
  (which-key-setup-side-window-right-bottom))

;; Based on the specified prefix, is shows/enable the defined options
(use-package general
  :ensure t
  :config (general-define-key
    :states '(normal visual insert emacs)
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
    "SPC" '(helm-M-x :which-key "M-x")
    ;; Buffers
    "bb"  '(helm-buffers-list :which-key "buffers list")
    "bn"  '(evil-buffer-new :which-key "new buffer")
    "bd"  '(evil-delete-buffer :which-key "delete buffer")
    "cl"  '(evilnc-comment-or-uncomment-lines :which-key "comment/uncomment lines")
    ;; Window
    "w"   '(evil-window-map :which-key "evil window")
    ;; Others
    "j"   '(evilem-map :which-key "evil motion")
    "p"   '(projectile-command-map :which-key "projectile")
    "t"   '(neotree-toggle :which-key "neotree")
    ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (neotree evil-easymotion evil-nerd-commenter general which-key helm-projectile projectile helm evil-commentary evil-collection evil-surround evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
