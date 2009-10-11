" Autoload portion of plugin/fontsize.vim.
" Maintainer:   Michael Henry (vim at drmikehenry.com)
" License:      This file is placed in the public domain.

function! fontsize#get()
    let s:font = &guifont
    if has("gui_win32")
        let size = substitute(s:font, '.*:h\(\d\+\):.*', '\1', '')
    elseif has("gui_gtk2")
        let size = substitute(s:font, '.*\D\(\d\+\)', '\1', '')
    else
        let size = "0"
    endif
    " Convert to integer.
    return size + 0
endfunction

function! fontsize#set(size)
    let s:font = &guifont
    if has("gui_win32")
        let newFont = substitute(s:font, '\(.*:h\)\d\+\(:.*\)', 
                    \ '\1' . a:size . '\2', '')
    elseif has("gui_gtk2")
        let newFont = substitute(s:font, '\(.*\D\)\d\+', '\1' . a:size, '')
    else
        let newFont = &guifont
    endif
    let &guifont = newFont
endfunction

function! fontsize#display()
    redraw
    sleep 100m
    echo &guifont . " (+/= - 0 ! q CR SP)"
endfunction

function! fontsize#quit()
    echo &guifont . " (Done)"
endfunction

function! fontsize#inc()
    call fontsize#set(fontsize#get() + 1)
    call fontsize#display()
endfunction

function! fontsize#dec()
    let oldSize = fontsize#get()
    if oldSize > 1
        call fontsize#set(oldSize - 1)
    endif
    call fontsize#display()
endfunction

let fontsize#defaultSize = fontsize#get()

function! fontsize#default()
    call fontsize#set(g:fontsize#defaultSize)
    call fontsize#display()
endfunction

function! fontsize#setDefault()
    let g:fontsize#defaultSize = fontsize#get()
endfunction

" vim: sts=4 sw=4 tw=80 et ai:
