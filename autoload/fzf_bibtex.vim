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

function! fzf_bibtex#select_entries(insert_mode, prefix="", postfix="", separator=", ") abort
	call fzf#run({'source': 'bibtex-ls', 'sink*': function('fzf_bibtex#insert_citation', [a:insert_mode, a:prefix, a:postfix, a:separator]), 'down': '40%', 'options': '--ansi --multi --prompt "Cite> "'})
endfunction
