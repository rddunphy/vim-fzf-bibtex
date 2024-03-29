" VimFzfBibtex: Commands for inserting Bibtex citations using Fzf
" Maintainer: R. David Dunphy <rdd.dunphy@gmail.com>
" Version: 0.1
" Source: http://github.com/rddunphy/vim-fzf-bibtex

if exists('g:loaded_fzf_bibtex') || &cp || v:version < 700
	finish
endif
let g:loaded_fzf_bibtex = 1

command! -nargs=* -bang FzfBibtex :call fzf_bibtex#select_entries(0, <bang>0, <f-args>)
command! -nargs=* -bang FzfBibtexInsert :call fzf_bibtex#select_entries(1, <bang>0, <f-args>)
command! -nargs=0 -bang FzfPandoc :call fzf_bibtex#select_entries(0, <bang>0, "@", "", "; @")
command! -nargs=0 -bang FzfPandocInsert :call fzf_bibtex#select_entries(1, <bang>0, "@", "", "; @")
command! -nargs=0 -bang FzfLatex :call fzf_bibtex#select_entries(0, <bang>0, "~\\cite{", "}")
command! -nargs=0 -bang FzfLatexInsert :call fzf_bibtex#select_entries(1, <bang>0, "~\\cite{", "}")
command! -nargs=0 -bang FzfMarkdown :call fzf_bibtex#select_entries_markdown(0, <bang>0)
command! -nargs=0 -bang FzfMarkdownInsert :call fzf_bibtex#select_entries_markdown(1, <bang>0)

let g:fzf_bibtex_use_default_mappings = get(g:, 'fzf_bibtex_use_default_mappings', 1)
let g:fzf_bibtex_default_fzf_params = get(g:, 'fzf_bibtex_default_fzf_params', {'options': '--ansi --multi --prompt "Cite> "'})

if g:fzf_bibtex_use_default_mappings ==# 1
	autocmd FileType tex inoremap <silent><buffer> <c-z><c-z> <c-g>u<c-o>:FzfLatexInsert<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>z <c-g>u<c-o>:FzfLatexInsert<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z><c-t> <c-g>u<c-o>:FzfBibtexInsert \\textcite{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>t <c-g>u<c-o>:FzfBibtexInsert \\textcite{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z><c-y> <c-g>u<c-o>:FzfBibtexInsert \\citeyear{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>y <c-g>u<c-o>:FzfBibtexInsert \\citeyear{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z><c-a> <c-g>u<c-o>:FzfBibtexInsert \\citeauthor{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>a <c-g>u<c-o>:FzfBibtexInsert \\citeauthor{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z><c-s> <c-g>u<c-o>:FzfBibtexInsert \\citeauthor*{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>s <c-g>u<c-o>:FzfBibtexInsert \\citeauthor*{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z><c-k> <c-g>u<c-o>:FzfBibtexInsert<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>k <c-g>u<c-o>:FzfBibtexInsert<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z><c-m> <c-g>u<c-o>:FzfMarkdownInsert<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>m <c-g>u<c-o>:FzfMarkdownInsert<CR>

	autocmd FileType tex nnoremap <silent><buffer> <localleader>cc :FzfLatex<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>ct :FzfBibtex \\textcite{ }<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>cy :FzfBibtex \\citeyear{ }<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>ca :FzfBibtex \\citeauthor{ }<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>cs :FzfBibtex \\citeauthor*{ }<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>ck :FzfBibtex<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>cm :FzfMarkdown<CR>

	inoremap <silent> <c-z><c-z> <c-g>u<c-o>:FzfMarkdownInsert<CR>
	nnoremap <silent> <localleader>cc :FzfMarkdown<CR>
	inoremap <silent> <c-z><c-p> <c-g>u<c-o>:FzfPandocInsert<CR>
	inoremap <silent> <c-z>p <c-g>u<c-o>:FzfPandocInsert<CR>
	nnoremap <silent> <localleader>cp :FzfPandoc<CR>
endif
