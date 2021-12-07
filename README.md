# Vim-fzf-bibtex

Commands for using [fzf-bibtex](https://github.com/msprev/fzf-bibtex) in Vim.

## Commands

* `:FzfBibtex [pre] [post] [sep]` - Use Fzf to select citations and insert
	their keys as a comma-separated list. Optionally takes arguments for prefix,
	postfix, and separators.
* `:FzfPandoc` - Insert Pandoc-style citation keys.
* `:FzfLatex` - Insert LaTeX-style citations with `~\cite{}`.
* `:FzfMarkdown` - Insert pretty-printed summaries of citations.

Each command has a version with with the postfix `Insert` (e.g.
`:FzfBibtexInsert`), which returns to insert mode after inserting the
citations.

## Default mappings

By default, the following normal mode mappings are provided for LaTeX files:

* `<localleader>cc` &rarr; `~\cite{keys}`
* `<localleader>ct` &rarr; `~\textcite{keys}`
* `<localleader>cy` &rarr; `~\citeyear{keys}`
* `<localleader>ca` &rarr; `~\citeauthor*{keys}`
* `<localleader>ck` &rarr; comma-separated list of keys
* `<localleader>cm` &rarr; markdown summary

Corresponding insert mode mappings start with `<C-Z>`:

* `<C-Z><C-Z>` or `<C-Z>z` &rarr; `~\cite{keys}`
* `<C-Z><C-T>` or `<C-Z>t` &rarr; `~\textcite{keys}`
* `<C-Z><C-Y>` or `<C-Z>y` &rarr; `~\citeyear{keys}`
* `<C-Z><C-A>` or `<C-Z>a` &rarr; `~\citeauthor*{keys}`
* `<C-Z><C-K>` or `<C-Z>k` &rarr; comma-separated list of keys
* `<C-Z><C-M>` or `<C-Z>m` &rarr; markdown summary

For other file types, mappings are defined for markdown summaries and for
Pandoc citation keys:

* `<localleader>cc` &rarr; markdown summary
* `<localleader>cp` &rarr; pandoc keys

Corresponding insert mode mappings start with `<C-Z>`:

* `<C-Z><C-Z>` or `<C-Z>z` &rarr; markdown summary
* `<C-Z><C-P>` or `<C-Z>p` &rarr; pandoc keys

To specify custom mappings, set `'g:fzf_bibtex_use_default_mappings'` to 0.
