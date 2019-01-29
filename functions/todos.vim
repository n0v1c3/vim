" Name: todos.vim
" Description: TODOs code
" Authors: n0v1c3 (Travis Gall)
" Notes:
"   - Requires user.vim
"   - Requires NERDComment

" TODO-TJG [171103] - Need a list of binary files to ignore searching

" Data entry prompts
let g:setTodoHeader = 'TODO: '

" Functions {{{1
" TODO-TJG [171103] - Add current file ONLY option
function! GetTODOs() "{{{2
    " Binary files that can be ignored
    set wildignore+=*.jpg,*.docx,*.xlsm,*.mp4,*.vmdk
    " Seacrch the CWD to find all of your current TODOs
    vimgrep /TODO.*\[\d\{6}]/ **/* **/.* | cw 5
    " Un-ignore the binary files
    set wildignore-=*.jpg,*.docx,*.xlsm,*.mp4,*.vmdk
endfunction

function! SetTODO(initials) " Insert a new TODOs {{{2
    " Return the TODOs string
    return 'TODO-' . a:initials .' [' . strftime('%y%m%d') . '] - ' . UserInput(g:setTodoHeader)
endfunction

" TODO-TJG [171105] - Make this more general
function! TakeTODO(initials) " Set your initials to a current TODO {{{2
    execute "normal! 0fTct\<space>TODO-" . a:initials . "\<esc>"
endfunction
