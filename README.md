# Vim-fzf-bibtex

Commands for using [fzf-bibtex](https://github.com/msprev/fzf-bibtex) in Vim.

## Installation and setup

Install using your package manager - e.g. for
[vim-plug](https://github.com/junegunn/vim-plug), add 
`Plug 'rddunphy/vim-fzf-bibtex'` to your .vimrc.

Requirements:
* [fzf-bibtex](https://github.com/msprev/fzf-bibtex)
* [bibtool](https://ctan.org/pkg/bibtool)
* [fzf](https://github.com/junegunn/fzf)

Specify the a directory to use for the cache, and a colon-separated list of
bibtex source files:

```vim
let $FZF_BIBTEX_CACHEDIR = 'path/to/cache/dir'
let $FZF_BIBTEX_SOURCES = 'paths/to/bibtex/files'
```

If `$FZF_BIBTEX_CACHEDIR` is not specified, it defaults to
`%APPDATA%\fzf-bibtex` on Windows, or `$HOME/.cache/fzf-bibtex` elsewhere.

## Commands

* `:FzfBibtex[!] [pre] [post] [sep]` - Use Fzf to select citations and insert
	their keys as a comma-separated list. Optionally takes arguments for prefix,
	postfix, and separators.
* `:FzfPandoc[!]` - Insert Pandoc-style citation keys.
* `:FzfLatex[!]` - Insert LaTeX-style citations with `~\cite{}`.
* `:FzfMarkdown[!]` - Insert pretty-printed summaries of citations.

Each command has a version with with the postfix `Insert` (e.g.
`:FzfBibtexInsert`), which returns to insert mode after inserting the
citations.

Appending an explamation mark to any command will open Fzf fullscreen.

## Default mappings

By default, the following normal mode mappings are provided for LaTeX files:

* `<localleader>cc` &rarr; `~\cite{keys}`
* `<localleader>ct` &rarr; `\textcite{keys}`
* `<localleader>cy` &rarr; `\citeyear{keys}`
* `<localleader>ca` &rarr; `\citeauthor{keys}`
* `<localleader>cs` &rarr; `\citeauthor*{keys}`
* `<localleader>ck` &rarr; comma-separated list of keys
* `<localleader>cm` &rarr; markdown summary

Corresponding insert mode mappings start with `<C-Z>`:

* `<C-Z><C-Z>` or `<C-Z>z` &rarr; `~\cite{keys}`
* `<C-Z><C-T>` or `<C-Z>t` &rarr; `\textcite{keys}`
* `<C-Z><C-Y>` or `<C-Z>y` &rarr; `\citeyear{keys}`
* `<C-Z><C-A>` or `<C-Z>a` &rarr; `\citeauthor{keys}`
* `<C-Z><C-S>` or `<C-Z>s` &rarr; `\citeauthor*{keys}`
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
