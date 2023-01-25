if exists('g:autoloaded_fzf_bibtex')
	finish
endif
let g:autoloaded_fzf_bibtex = 1

function! s:check_cache_directory() abort
	if $FZF_BIBTEX_CACHEDIR == ""
		if has('win32')
			let $FZF_BIBTEX_CACHEDIR = "%APPDATA%\\fzf-bibtex"
		else
			let $FZF_BIBTEX_CACHEDIR = "$HOME/.cache/fzf-bibtex"
		endif
	endif
	if !isdirectory($FZF_BIBTEX_CACHEDIR)
		call mkdir($FZF_BIBTEX_CACHEDIR, "p")
	endif
endfunction

function! s:fzf_bibtex_options() abort
	let bib_sources = "'".join(split($FZF_BIBTEX_SOURCES, ":"), "' '")."'"
	let extract_key_cmd = "\"$(echo {} | sed -e \"s/\x1B\[[0-9;]*m//g\" | awk -F@ '{print $NF}')\""
	let get_bib_entry_cmd = "bibtool 2>&1 ".bib_sources." -X ^".extract_key_cmd."$ -d -- print.line.length=$FZF_PREVIEW_COLUMNS"
	let trim_cmd = "sed '/./,$!d'"
	let print_cmd = "COLORTERM=truecolor bat --language=bibtex --tabs=8 --color=always --decorations=never --wrap=character --terminal-width=$FZF_PREVIEW_COLUMNS"
	let preview_cmd = get_bib_entry_cmd." | ".trim_cmd." | ".print_cmd
	return ['--ansi', '--preview', preview_cmd, '--bind', 'ctrl-l:toggle-preview']
endfunction

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

function! fzf_bibtex#select_entries(insert_mode=0, bang=0, prefix="", postfix="", separator=", ") abort
	if !exists("*fzf#run")
		echohl ErrorMsg | echomsg "Fzf is not installed" | echohl NONE
	elseif !executable('bibtex-ls')
		echohl ErrorMsg | echomsg "Bibtex-ls is not installed" | echohl NONE
	elseif !executable('bibtex-cite')
		echohl ErrorMsg | echomsg "Bibtex-cite is not installed" | echohl NONE
	else
		call s:check_cache_directory()
		let fzf_params = extend(g:fzf_bibtex_default_fzf_params, {'source': 'bibtex-ls', 'sink*': function('fzf_bibtex#insert_citation', [a:insert_mode, a:prefix, a:postfix, a:separator]), 'options': s:fzf_bibtex_options()})
		call fzf#run(fzf#wrap(fzf_params, a:bang))
	endif
endfunction

function! fzf_bibtex#select_entries_markdown(insert_mode=0, bang=0) abort
	if !exists("*fzf#run")
		echohl ErrorMsg | echomsg "Fzf is not installed" | echohl NONE
	elseif !executable('bibtex-ls')
		echohl ErrorMsg | echomsg "Bibtex-ls is not installed" | echohl NONE
	elseif !executable('bibtex-markdown')
		echohl ErrorMsg | echomsg "Bibtex-markdown is not installed" | echohl NONE
	else
		call s:check_cache_directory()
		let fzf_params = extend(g:fzf_bibtex_default_fzf_params, {'source': 'bibtex-ls', 'sink*': function('fzf_bibtex#insert_citation_markdown', [a:insert_mode]), 'options': s:fzf_bibtex_options()})
		call fzf#run(fzf#wrap(fzf_params, a:bang))
	endif
endfunction
