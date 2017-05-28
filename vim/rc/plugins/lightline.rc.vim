"===========================================================
" Lightline
"===========================================================
let g:lightline={
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \       'left': [ ['mode', 'paste'],['readonly','fugitive', 'gitgutter', 'filename', 'modified'] ],
    \       'right': [ ['percent', 'lineinfo'],['fileformat','fileencoding', 'filetype'],['charcode'] ]
    \ },
    \ 'component_function': {
    \       'mode': 'MyMode',
    \       'charcode': 'MyCharCode',
    \       'fugitive': 'MyFugitive',
    \       'gitgutter': 'MyGitgutter'
    \ },
    \ 'separator': {'left': "", 'right': ""},
    \ 'subseparator': {'left': "|", 'right': "|"},
    \ }

function! MyMode()
    return &ft == 'unite' ? 'Unite':
        \ &ft == 'vimfiler' ? 'VimFiler':
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! MyCharCode()
    if winwidth('.') <= 70
        return ''
    endif

    " Get the output of :ascii
    redir => ascii
    silent! ascii
    redir END

    if match(ascii, 'NUL') != -1
        return 'NUL'
    endif

    " Zero pad hex values
    let nrformat = '0x%02x'

    let encoding = (&fenc == '' ? &enc : &fenc)

    if encoding == 'utf-8'
        " Zero pad with 4 zeroes in unicode files
        let nrformat = '0x%04x'
    endif

    " Get the character and the numeric value from the return value of :ascii
    " This matches the two first pieces of the return value, e.g.
    " "<F>  70" => char: 'F', nr: '70'
    let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

    " Format the numeric value
    let nr = printf(nrformat, nr)

    return "'". char ."' ". nr
endfunction

function! MyFugitive() 
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            let _ = fugitive#head()
            return strlen(_) ? '<' . _ . '>' : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyGitgutter()
    if !exists('*GitGutterGetHunkSummary') || !get(g:, 'gitgutter_enabled', 0) || winwidth('.') <= 90
        return ''
    endif

    let symbols = [
        \ g:gitgutter_sign_added,
        \ g:gitgutter_sign_modified,
        \ g:gitgutter_sign_removed,
        \ ]
    let hunks = GitGutterGetHunkSummary()
    let ret = []
    for i in [0, 1, 2]
        if hunks[i] > 0
            call add(ret, '(' . symbols[i] . hunks[i] . ')')
        endif
    endfor
    return join(ret, ' ')
endfunction
