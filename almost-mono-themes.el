;;; almost-mono-themes.el --- Almost monochromatic color themes -*- lexical-binding: t; -*-

;; Copyright (C) 2019 - 2022 John Olsson

;; Author: John Olsson <john@cryon.se>
;; Maintainer: John Olsson <john@cryon.se>
;; URL: https://github.com/cryon/almost-mono-themes
;; Created: 9th May 2019
;; Version: 1.0.0
;; Keywords: faces
;; Package-Requires: ((emacs "24"))

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.

;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A suite of almost monochrome Emacs themes

;;; Code:

(defconst almost-mono-themes-colors
  '((white . ((background         . "#ffffff")
	            (foreground         . "#000000")
	            (weak               . "#999999")
	            (weaker             . "#e0e0e0")
	            (weakest            . "#eeeeee")
	            (highlight          . "#fda50f")
	            (warning            . "#ff0000")
	            (success            . "#228B22")
	            (string             . "#3c5e2b")
              (bg-added           . "#c1f2d1")
              (bg-added-faint     . "#d8f8e1")
              (bg-removed         . "#ffd8d5")
              (fg-added           . "#005000")
              (fg-added-intense   . "#006700")
              (fg-removed         . "#8f1313")
              (fg-removed-intense . "#aa2222")))

    (black . ((background         . "#1a1a1a")
	            (foreground         . "#ffffff")
              (bold               . "#e0e0e0")
	            (weak               . "#aaaaaa")
	            (weaker             . "#666666")
	            (weakest            . "#222222")
	            (highlight          . "#fda50f")
	            (warning            . "#ff0000")
	            (success            . "#228b22")
	            (string             . "#a7bca4")
              (bg-added           . "#00381f")
              (bg-added-faint     . "#002910")
              (bg-removed         . "#4f1119")
              (fg-added           . "#a0e0a0")
              (fg-added-intense   . "#80e080")
              (fg-removed         . "#ffbfbf")
              (fg-removed-intense . "#ff9095")))

    (orange . ((background . "#d14300")
               (foreground . "#151414")
               (weak       . "#434242")
               (weaker     . "#727272")
               (weakest    . "#a1a1a1")
               (highlight  . "#fda50f")
               (warning    . "#67c2e1")
               (success    . "#51dd73")
               (string     . "#9faf96")
               (bg-added    . "")
               (bg-added-faint    . "")
               (bg-removed   . "")
               (fg-added    . "")
               (fg-added-intense    . "")
               (fg-removed    . "")
               (fg-removed-intense    . "")
               ))

    (gray  . ((background  . "#2b2b2b")
	            (foreground  . "#ffffff")
	            (weak        . "#aaaaaa")
	            (weaker      . "#666666")
	            (weakest     . "#222222")
	            (highlight   . "#fda50f")
	            (warning     . "#ff0000")
	            (success     . "#228b22")
	            (string      . "#a7bca4")
              (bg-added    . "")
              (bg-added-faint    . "")
              (bg-removed   . "")
              (fg-added    . "")
              (fg-added-intense    . "")
              (fg-removed    . "")
              (fg-removed-intense    . "")
              ))


    (cream . ((background  . "#f0e5da")
	            (foreground  . "#000000")
	            (weak        . "#7d7165")
	            (weaker      . "#c4baaf")
	            (weakest     . "#dbd0c5")
	            (highlight   . "#fda50f")
	            (warning     . "#ff0000")
	            (success     . "#228b22")
	            (string      . "#3c5e2b")
              (bg-added    . "")
              (bg-added-faint    . "")
              (bg-removed   . "")
              (fg-added    . "")
              (fg-added-intense    . "")
              (fg-removed    . "")
              (fg-removed-intense    . ""))
           )))

(defmacro almost-mono-themes--variant-with-colors (variant &rest body)
  "Execute BODY in a scope where the different colors for given VARIANT is bound."
  `(let* ((colors (or (cdr (assoc ,variant almost-mono-themes-colors))
		                  (error "No such theme variant")))
	        (background (cdr (assoc 'background colors)))
	        (foreground (cdr (assoc 'foreground colors)))
	        (weak	      (cdr (assoc 'weak colors)))
	        (weaker     (cdr (assoc 'weaker colors)))
	        (weakest    (cdr (assoc 'weakest colors)))
	        (highlight  (cdr (assoc 'highlight colors)))
	        (warning    (cdr (assoc 'warning colors)))
	        (success    (cdr (assoc 'success colors)))
	        (string     (cdr (assoc 'string colors))))
     ,@body))

(defmacro almost-mono-themes--faces-spec ()
  "Provide the faces specification."
  (quote
   (mapcar
    (lambda (entry) (list (car entry) `((t ,@(cdr entry)))))
    `(

      ;; default
      (default (:background ,background :foreground ,foreground))
      (fringe  (:background ,background))
      (region  (:background ,highlight  :foreground ,foreground))
      (show-paren-match (:background ,background :foreground ,success :bold nil))
      (show-paren-mismatch (:background ,background :foreground ,warning :bold t))
      (minibuffer-prompt (:weight bold :foreground ,foreground))
      (isearch (:background ,weak :foreground ,foreground :bold t))
      (lazy-highlight (:background ,weaker :foreground ,foreground))
      (link (:underline t))
      ;; (shadow (:foreground ,weaker))

      ;; mode line
      (mode-line (:box (:line-width -1 :color ,weaker)
		                   :background ,weakest :foreground ,foreground))

      (mode-line-inactive (:box (:line-width -1 :color ,weaker)
				                        :background ,background :foreground ,weaker))

      ;; font lock
      (font-lock-keyword-face (:bold t))
      (font-lock-function-name-face (:bold t))
      (font-lock-variable-name-face (:foreground ,foreground))
      (font-lock-warning-face (:foreground ,foreground))
      (font-lock-builtin-face (:bold t))
      ;; (font-lock-property-use-face (:bold t))
      (font-lock-constant-face (:foreground ,foreground))
      (font-lock-type-face (:foreground ,foreground))
      (font-lock-preprocessor-face (:italic nil))
      (font-lock-comment-face (:foreground ,weak :slant italic))
      (font-lock-comment-delimiter-face (:foreground ,weak :slant italic))
      (font-lock-string-face (:foreground ,string))
      (font-lock-doc-face (:foreground ,weak))
      (line-number (:foreground ,weaker))
      (linum (:inherit line-number))
      (vertical-border (:foreground ,weaker))

      ;; forge
      (forge-pullreq-open (:foreground ,foreground :bold nil))
      (forge-pullreq-merged (:foreground ,weaker :bold nil))
      (forge-pullreq-rejected (:foreground ,weaker :strike-through t))

      ;; eshell
      (eshell-prompt (:foreground ,foreground :bold t))
      (eshell-ls-directory (:foreground ,foreground :bold t))
      (eshell-ls-archive (:inherit eshell-ls-unreadable))
      (eshell-ls-backup (:inherit eshell-ls-unreadable))
      (eshell-ls-clutter (:inherit eshell-ls-unreadable))
      (eshell-ls-executable (:inherit eshell-ls-unreadable))
      (eshell-ls-missing (:inherit eshell-ls-unreadable))
      (eshell-ls-product (:inherit eshell-ls-unreadable))
      (eshell-ls-readonly (:inherit eshell-ls-unreadable))
      (eshell-ls-special (:inherit eshell-ls-unreadable))
      (eshell-ls-symlink (:inherit eshell-ls-unreadable))

      ;; company mode
      (company-tooltip (:background ,weakest :foreground ,foreground))
      (company-tooltip-selection (:background ,weaker :foreground ,foreground))
      ;;(company-tooltip-search (:background "#ff0000" :foreground "#00ff00"))
      (company-tooltip-common (:bold t))
      (company-tooltip-common-selection (:bold t))
      (company-scrollbar-bg (:background ,weaker))
      (company-scrollbar-fg (:background ,weak))
      (company-tooltip-annotation-selection (:background ,weaker :foreground ,foreground :italic t))
      (company-tooltip-annotation (:background ,weakest :foreground ,weak :italic t))

      ;; git gutter
      (git-gutter:modified (:background ,highlight :foreground ,highlight))
      (git-gutter:added (:background ,success :foreground ,success))
      (git-gutter:deleted (:background ,warning :foreground ,warning))

      ;; diff hl
      (diff-hl-change (:background ,highlight :foreground ,highlight))
      (diff-hl-insert (:background ,success :foreground ,success))
      (diff-hl-delete (:background ,warning :foreground ,warning))

      ;; hl line
      (hl-line (:background ,weakest))
      (highlight-current-line-face (:inherit hl-line))

      ;; ido
      (ido-first-match (:bold t))
      (ido-only-match (:bold t))
      (ido-subdir (:italic t))
      (ido-virtual (:foreground ,weak))
      (ido-vertical-match-face (:bold t :italic nil))

      ;; org mode
      (org-table (:foreground ,weak))

      ;; go-test-mode
      (go-test--standard-face (:foreground ,string))
      (go-test--ok-face (:foreground ,success))

      ;; treesitter-context
      (treesitter-context-focus-unfocused (:foreground ,weaker))

      ;; consult
      (consult-line-number-wrapped (:underline nil))

      ;; flymake
      (flymake-error (:underline (:color ,warning :style line)))
      (flymake-warning (:underline (:color ,weak :style line)))

      ;; jinx
      (jinx-misspelled (:underline (:color ,highlight :style line)))

      ;; diff
      (diff-added (:background ,bg-added :foreground ,fg-added))
      (diff-removed (:background ,bg-removed :foreground ,fg-removed))
      (diff-refine-added (:background ,bg-added :foreground ,fg-added))
      (diff-refine-added (:background ,bg-added :foreground ,fg-added))
      (diff-refine-removed (:background ,bg-removed :foreground ,fg-removed))

      ;; magit
      (magit-diff-added (:background ,bg-added :foreground ,fg-added))
      (magit-diff-added-highlight (:background ,bg-added :fore-ground ,fg-added))
      (magit-diff-removed (:background ,bg-removed-faint :foreground ,fg-removed))
      (magit-diff-removed-highlight (:background ,bg-removed :foreground ,fg-removed))
      (magit-diff-context-highlight (:background "#f3f3f3"))
      (magit-diff-hunk-heading (:bold t))

      ))))


(defun almost-mono-themes--variant-name (variant)
  "Create symbol for color theme variant VARIANT."
  (intern (format "almost-mono-%s" (symbol-name variant))))

(defmacro almost-mono-themes--define-theme (variant)
  "Define a theme for the almost-mono variant VARIANT."
  (let ((name (almost-mono-themes--variant-name variant))
        (doc (format "almost mono theme (%s version)" variant)))
    `(progn
       (deftheme ,name ,doc)
       (put ',name 'theme-immediate t)
       (almost-mono-themes--variant-with-colors
        ',variant
        (apply 'custom-theme-set-faces ',name
               (almost-mono-themes--faces-spec)))
       (provide-theme ',name))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
	             (file-name-as-directory (file-name-directory load-file-name))))

(provide 'almost-mono-themes)

;;; almost-mono-themes.el ends here
