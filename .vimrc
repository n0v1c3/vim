" File: .vimrc
" Description: VIM configuration file
" Authors: Travis Gall

source ~/.vim/functions/folds.vim
source ~/.vim/functions/todos.vim
source ~/.vim/functions/users.vim

" Configuration {{{1
" Global {{{2
let g:mapleader="\<space>"
let g:maplocalleader='-'
let g:foldcolumn_init=4
let g:quickfixlist_open=0
let g:locationlist_open=0
let g:quifixlist_height=5
let g:hlstate = 1

" Folds {{{2
set foldenable
let &foldcolumn=g:foldcolumn_init
set foldlevel=1
set foldlevelstart=1
set foldmethod=marker
set foldnestmax=10
set foldtext=v:folddashes.FormatFoldString(v:foldstart)

" Indents {{{2
filetype plugin indent on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Navigation {{{2
set listchars+=extends:>    " Display symbol for extended information
set listchars+=precedes:<   " Display symbol for preceding information
set nowrap                  " Disable automatic text wrapping
set number                  " Display actual number for the current line
set relativenumber          " Enable relative line numbering
set scrolloff=5             " Start scrolling the screen X lines before window border
set sidescroll=5            " Scroll X columns at a time
set virtualedit=all         " Move cursor to any column on an existing line

" StatusLine {{{2
" Always display the status bar
set laststatus=2

" Flags
set statusline=%m%r%h
" Filename
set statusline+=%t
" Folds
set statusline+=\ %{GetFoldStrings()}
" Begin right side
set statusline+=%=
" Cursor in HEX
set statusline+=\|%2B\|
" Current line
set statusline+=%3l/%3L\|

" Display {{{2
set lazyredraw      " Postpone screen redraw until macro completion

set t_Co=256
syntax on
colorscheme koehler
set background=dark " Dark background for theme

" Wildignore {{{2
" Ignore these files when expanding wildcards
set wildignore+=/home/travis/.vim/bundle/.*
set wildignore+=*/oh-my-zsh/.*
set wildignore+=*/.oh-my-zsh/.*
set wildignore+=*.swp

" AutoGroups {{{1
" AutoHotKey {{{2
augroup AHK
  autocmd!
  autocmd  BufNewFile,BufRead *.ahk setfiletype autohotkey
  autocmd  BufNewFile,BufRead *.ahk source $VIM/indents/autohotkey.vim
augroup END

" Remove automatic commenting
set formatoptions-=cro

" Plugins {{{1
" Pathogen {{{2
execute pathogen#infect()

" CtrlP {{{2
let g:ctrlp_cmd = 'CtrlPMRU' " Most recent files

" NERD {{{2
let g:NERDSpaceDelims=1 " One space after auto comment
" Syntastic {{{2
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php', '/bin/phplint']
let g:syntastic_sh_checkers = ['bashate', 'sh', 'shellcheck']
let g:syntastic_sh_shellcheck_args = '--external-sources'
let g:syntastic_vim_checkers = ['vimlint', 'vint']
let g:syntastic_sql_checkers = ['sqlint']

" Key Mappings {{{1
" VIM {{{2
" Key Overrides
noremap j gj
noremap k gk
nnoremap <silent>/ :let hlstate=1<cr>:set hlsearch<cr>:set incsearch<cr>/\v
nnoremap <silent> H ^
nnoremap <silent> J }
noremap <silent> K {
nnoremap <silent> L $
nnoremap <silent> =G mmgg=G`m
nnoremap <silent> <c-h> 3zh
nnoremap <silent> <c-j> 3<c-e>
nnoremap <silent> <c-k> 3<c-y>
nnoremap <silent> <c-l> 3zl

" vimrc
nnoremap <silent> <leader>ev :find $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" TODOs {{{2
nnoremap <silent> <leader>tf /TODO-<cr>
nnoremap <silent> <leader>tg mm:call GetLocalTODOs()<cr>`m
nnoremap <silent> <leader>tG mm:call GetTODOs()<cr>`m
nnoremap <silent> <leader>ti mmO<C-c>:call setline('.',SetTODO('TJG'))<cr>:call NERDComment(0,'toggle')<cr>==`m
0
nnoremap <silent> <leader>td :call TakeTODO('TJG')<cr>

" 'F' Formating {{{2
nnoremap <silent> <leader>fu mmviwU`m
nnoremap <silent> <leader>fl mmviwu`m
nnoremap <silent> <leader>; mmA;<esc>`m
nnoremap <silent> <leader><backspace> mmA<backspace><esc>`m

" 'G' Go {{{2
nnoremap <leader>gh :execute "help " . "<cword>"<cr> vnoremap <leader>hh :execute "help " . '<'><cr>
nnoremap <silent> <leader>gf <c-w>vgf

" 'T' Toggles {{{2
nnoremap <silent> <leader>tc :call NERDComment(0,'toggle')<cr>
nnoremap <silent> <leader>tl :call <SID>LocationListToggle()<cr>
nnoremap <silent> <leader>th :call <SID>ToggleHighlighting()<cr>
nnoremap <silent> <leader>tn :setlocal number!<cr>:setlocal relativenumber!<cr>
nnoremap <silent> <leader>tq :call <SID>QuickfixListToggle()<cr>
nnoremap <silent> <leader>tt :NERDTreeToggle<cr>

" 'W' Windows {{{2
nnoremap <silent> <leader>w <c-w>

" 'Z' Folding {{{2
nnoremap <silent> zC mmggvGzC`m<esc>
nnoremap <silent> zO mmggvGzO`m
nnoremap <silent> <leader><leader> za

" Format {{{1
" TODOs {{{2
highlight TODO ctermbg=green ctermfg=black

" Quick Attention {{{2
highlight Attention ctermbg=yellow ctermfg=black

" StatusLine {{{2
highlight StatusLine ctermbg=black ctermfg=lightgreen
highlight StatusLineNC ctermbg=lightgreen ctermfg=black

" Whitespace {{{2
highlight WhiteSpace ctermbg=yellow
match WhiteSpace /\v\s+$/

" Test Functions {{{1
" Quickfix List Toggle
function! s:QuickfixListToggle()
  if g:quickfixlist_open
    execute g:quickfixlist_return_to_window . 'wincmd w'
    let g:quickfixlist_open=0
    cclose
  else
    let g:quickfixlist_return_to_window = winnr()
    let g:quickfixlist_open=1
    copen 5
  endif
endfunction

" Location List Toggle
function! s:LocationListToggle()
  if g:locationlist_open
    execute g:locationlist_return_to_window . 'wincmd w'
    let g:locationlist_open=0
    lclose
  else
    let g:locationlist_return_to_window = winnr()
    let g:locationlist_open=1
    lopen 5
  endif
endfunction

function! s:ToggleHighlighting()
  if g:hlstate
    call feedkeys(":nohlsearch\<cr>")
    let g:hlstate = 0
  else
    call feedkeys(":set hlsearch\<cr>")
    let g:hlstate = 1
  endif
endfunction
