if exists('g:autoloaded_fzf_bibtex')
	finish
endif
let g:autoloaded_fzf_bibtex = 1

function! fzf_bibtex#insert_citation(insert_mode, prefix, postfix, separator, lines) abort
	let r = system("bibtex-cite -prefix=\"".a:prefix."\" -postfix=\"".a:postfix."\" -separator=\"".a:separator."\"", a:lines)
	execute ':normal! i' . r
	if a:insert_mode
		call feedkeys('a')
	endif
endfunction

function! fzf_bibtex#insert_citation_markdown(insert_mode, lines) abort
	let r = system("bibtex-markdown", a:lines)
	execute ':normal! i' . r
	if a:insert_mode
		call feedkeys('a')
	endif
endfunction

function! fzf_bibtex#select_entries(insert_mode=0, prefix="", postfix="", separator=", ") abort
	if !exists("*fzf#run")
		echohl ErrorMsg | echomsg "Fzf.vim is not installed" | echohl NONE
	elseif !executable('bibtex-ls')
		echohl ErrorMsg | echomsg "Bibtex-ls is not installed" | echohl NONE
	elseif !executable('bibtex-cite')
		echohl ErrorMsg | echomsg "Bibtex-cite is not installed" | echohl NONE
	else
		let fzf_params = extend(g:fzf_bibtex_default_fzf_params, {'source': 'bibtex-ls', 'sink*': function('fzf_bibtex#insert_citation', [a:insert_mode, a:prefix, a:postfix, a:separator])})
		call fzf#run(fzf_params)
	endif
endfunction

function! fzf_bibtex#select_entries_markdown(insert_mode=0) abort
	if !exists("*fzf#run")
		echohl ErrorMsg | echomsg "Fzf.vim is not installed" | echohl NONE
	elseif !executable('bibtex-ls')
		echohl ErrorMsg | echomsg "Bibtex-ls is not installed" | echohl NONE
	elseif !executable('bibtex-markdown')
		echohl ErrorMsg | echomsg "Bibtex-markdown is not installed" | echohl NONE
	else
		let fzf_params = extend(g:fzf_bibtex_default_fzf_params, {'source': 'bibtex-ls', 'sink*': function('fzf_bibtex#insert_citation_markdown', [a:insert_mode])})
		call fzf#run(fzf_params)
	endif
endfunction
