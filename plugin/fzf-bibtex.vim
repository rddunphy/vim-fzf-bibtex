" VimFzfBibtex: Commands for inserting Bibtex citations using Fzf
" Maintainer: R. David Dunphy <rdd.dunphy@gmail.com>
" Version: 0.1
" Source: http://github.com/rddunphy/vim-fzf-bibtex

if exists('g:loaded_fzf_bibtex') || &cp || v:version < 700
	finish
endif
let g:loaded_fzf_bibtex = 1

command! -nargs=* FzfBibtex :call fzf_bibtex#select_entries(0, <f-args>)
command! -nargs=* FzfBibtexInsert :call fzf_bibtex#select_entries(1, <f-args>)
command! -nargs=0 FzfPandoc :call fzf_bibtex#select_entries(0, "@", "", "; @")
command! -nargs=0 FzfPandocInsert :call fzf_bibtex#select_entries(1, "@", "", "; @")
command! -nargs=0 FzfLatex :call fzf_bibtex#select_entries(0, "~\\cite{", "}")
command! -nargs=0 FzfLatexInsert :call fzf_bibtex#select_entries(1, "~\\cite{", "}")

let g:fzf_bibtex_use_default_mappings = get(g:, 'fzf_bibtex_use_default_mappings', 1)


if g:fzf_bibtex_use_default_mappings ==# 1
	autocmd FileType tex inoremap <silent><buffer> <c-z><c-z> <c-g>u<c-o>:FzfLatexInsert<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>t <c-g>u<c-o>:FzfBibtexInsert ~\\textcite{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>y <c-g>u<c-o>:FzfBibtexInsert ~\\citeyear{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>a <c-g>u<c-o>:FzfBibtexInsert ~\\citeauthor*{ }<CR>
	autocmd FileType tex inoremap <silent><buffer> <c-z>p <c-g>u<c-o>:FzfBibtexInsert<CR>

	autocmd FileType tex nnoremap <silent><buffer> <localleader>cc :FzfLatex<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>ct :FzfBibtex ~\\textcite{ }<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>cy :FzfBibtex ~\\citeyear{ }<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>ca :FzfBibtex ~\\citeauthor*{ }<CR>
	autocmd FileType tex nnoremap <silent><buffer> <localleader>cp :FzfBibtex<CR>

	autocmd FileType markdown inoremap <silent><buffer> <c-z> <c-g>u<c-o>:FzfPandocInsert<CR>
	autocmd FileType markdown nnoremap <silent><buffer> <localleader>c :FzfPandoc<CR>
endif
