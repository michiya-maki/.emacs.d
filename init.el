;=======================================
; 基本設定
;=======================================

; 言語を日本語にする
(set-language-environment 'Japanese)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)
; 背景色を黒にする
(set-background-color "black")
; 全景色を緑系にする
(set-foreground-color "#55ff55")

; 行番号表示
(when (eval-and-compile (require 'linum nil t)) ; 画面左に行数を表示する
  (global-linum-mode t)                         ; デフォルトで linum-mode を有効にする
  (setq linum-format "%5d"))                    ; 5桁分の領域を確保して行番号を表示

; 行番号表示する必要のないモードでは表示しない
(defadvice linum-on(around linum-off activate)
  (unless (or (minibufferp)
              (member
               major-mode
               '(eshell-mode
                 mew-summary-mode
                 speedbar-mode
                 compilation-mode
                 dired-mode
                 term-mode))) ad-do-it))

;; 釣り合いのとれる括弧をハイライト
(when (eval-when-compile (require 'paren nil t))
  (when (boundp 'show-paren-delay)
    (setq show-paren-delay 0)) ; 初期値は 0.125
  (when (fboundp 'show-paren-mode)
    (show-paren-mode t)))      ; 有効化

;;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "red")

;; 強調表示しない設定
;(add-hook 'fundamental-mode-hook (lambda () (setq show-trailing-whitespace nil)))
;(add-hook 'calendar-mode-hook (lambda () (setq show-trailing-whitespace nil)))

;; キーストロークをエコーエリアに早く表示
(setq echo-keystrokes 0.1)

;;; 4タブ
(setq-default tab-width 4)
;;; タブをスペースにする
(setq-default indent-tabs-mode nil)
;;; makefile ではスペースにしない
(add-hook 'makefile-mode-hook (lambda () (setq indent-tabs-mode t)))

;; ビープ音とフラッシュを消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; ツールバーの非表示
(tool-bar-mode -1)
 
;; スタートアップページを表示しない
(setq inhibit-startup-message t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gud-gdb-command-name "gdb --annotate=1")
 '(initial-frame-alist
   (quote
    ((height . 35)
     (width . 120)
     (top . 10)
     (left . 10)
     (vertical-scroll-bars . right))))
 '(large-file-warning-threshold nil)
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-tomorrow undo-tree auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

 ;; 英語
 (set-face-attribute 'default nil
             :family "Menlo" ;; font
             :height 150)    ;; font size

;; 日本語
;(set-fontset-font
; nil 'japanese-jisx0208
;; (font-spec :family "Hiragino Mincho Pro")) ;; font
;  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 半角と全角の比を1:2に
(setq face-font-rescale-alist
      '((".*Hiragino_Mincho_pro.*" . 1.2)))

;=======================================
; キー定義
;=======================================
;デフォルトのフォントサイズを大きく
(define-key global-map [(M up)]   'increase-frame-font-size)
;デフォルトのフォントサイズを小さく
(define-key global-map [(M down)] 'decrease-frame-font-size)
;backspaceをCtrl-hにする
(global-set-key (kbd "C-h") 'delete-backward-char)

;=======================================
; フォント
;=======================================
;; FONT_FAMILYのエラーが発生するのでコメントアウト
;(set-frame-font (concat FONT_FAMILY "-" (format "%s" FONT_SIZE)))

;;=======================================
;; フレームのフォントサイズを変更する
;;=======================================
(defun increase-frame-font-size ()
    "increase current font size"
    (interactive)
    (change-font-size t)
)

(defun decrease-frame-font-size ()
    "decrease current font size"
    (interactive)
    (change-font-size nil)
)

;;フォントサイズの変更
(defun change-font-size (toIncrease)
    "change font size."
    (interactive)
    (save-size)
    (if toIncrease 
        (setq FONT_SIZE (+ FONT_SIZE 1) )
        (setq FONT_SIZE (- FONT_SIZE 1) )
    )
;    (set-frame-font (concat FONT_FAMILY "-" (format "%.1f" FONT_SIZE )))
    (message (format "font size : %d" FONT_SIZE))
    ;; フレームサイズの再設定する
    (setq col (round (/ fw (frame-char-width) ) ))
    (setq row (round (/ fh (frame-char-height) ) ))
    (set-frame-size (selected-frame) col row)
)

;;現在のフレームサイズを保存
(defun save-size ()
     ""
    (setq fw (* (frame-width) (frame-char-width)))
    (setq fh (* (frame-height) (frame-char-height)))
)

;;フレームサイズが変更されたときは保存する
(add-hook 'window-size-change-hook '(lambda ()(save-size)))

;; バックアップファイルを作らないようにする
(setq make-backup-files nil)

;;; 終了時にオートセーブファイルを消す
(setq auto-save-default nil)


;=======================================
; パッケージ定義
;=======================================
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
