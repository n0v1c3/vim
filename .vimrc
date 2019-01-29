" File: .vimrc
" Description: VIM configuration file


" Plugins {{{1
" Vundle {{{2
" execute pathogen#infect()

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'megaannum/forms'
Plugin 'n0v1c3/vira'
Plugin 'vim-airline/vim-airline'

" Git {{{3
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Commenting {{{3
Plugin 'scrooloose/nerdcommenter'

" File Browser {{{3
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf.vim'

" Auto complete {{{3
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'sirver/ultisnips'

" Linting {{{3
Plugin 'w0rp/ale'

" Formatting {{{3
Plugin 'google/yapf'
Plugin 'pignacio/vim-yapf-format'

" Faster/pretty code {{{3
Plugin 'tpope/vim-surround'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'yggdroot/indentline'
Plugin 'sjl/gundo.vim'

" Bash {{{3
Plugin 'dbeniamine/cheat.sh-vim'

" Markdown {{{3
Plugin 'plasticboy/vim-markdown'
call vundle#end()
filetype plugin indent on

" FZF {{{2
" let g:ctrlp_cmd = 'CtrlPMRU' " Most recent files

" JIRA Complete {{{2
let g:jira_url = 'https://jira.advmeas.com:8443'
let g:jira_username = 'travis.gall'
let g:jira_password = 'AdvMeas2'
let g:unite_source_issue_jira_priority_table = {
      \ 10000: '◡', 1: '⚡', 2: 'ᛏ', 3: '●', 4: '○', 5: '▽' }
let g:unite_source_issue_jira_status_table = {
      \ 1: 'plan', 3: 'develop', 4: 'reopened', 5: 'resolved', 6: 'closed',
      \ 10000: 'feedback', 10001: 'staged', 10002: 'waiting',
      \ 10003: 'deployed', 10004: 'pending', 10008: 'review' }
let g:unite_source_issue_jira_type_table = {
      \ 1: 'bug', 2: 'feature', 3: 'task', 4: 'change', 5: 'sub-task',
      \ 6: 'epic', 7: 'story', 8: 'system', 9: 'sub-bug' }

let g:jiracomplete_url = 'https://jira.advmeas.com:8443'
let g:jiracomplete_username = 'travis.gall'
let g:jiracomplete_password = 'AdvMeas2'
let g:jiracomplete_format = 'v:val.abbr . " -> " . v:val.menu'

" NERD {{{2
let g:NERDSpaceDelims=1 " One space after auto comment
" ALE {{{2
let g:syntastic_php_checkers = ['php', '/bin/phplint']
let g:syntastic_sh_checkers = ['bashate', 'sh', 'shellcheck']
let g:syntastic_sh_shellcheck_args = '--external-sources'
let g:syntastic_vim_checkers = ['vimlint', 'vint']
let g:syntastic_sql_checkers = ['sqlint']
let g:syntastic_python_checkers = ['flake8', 'python']

let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 1
let g:ale_statusline_format = [' %d', ' %d', '⬥ ok']
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=brown

" Always display the sign column for ALE
set signcolumn=yes


" Vira {{{2
let g:vira_serv = 'https://jira.boiko.online'
" let g:vira_serv = 'https://jira.advmeas.com:8443'
let g:vira_user = 'travis.gall'
let g:vira_pass = ''

" YAPF {{{2
let g:yapf_format_yapf_location = '/home/travis/.vim/bundle/yapf'
" Vim scripts {{{1
source ~/.vim/functions/folds.vim
source ~/.vim/functions/todos.vim
source ~/.vim/functions/users.vim

" let g:pymode_python = 'python3'

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

" Fonts {{{2
set guifont=Font\ Awesome\ 14

" Highlights {{{2
" highlight! link Folded Normal
" TODO-TJG [190125] - Tweak these to look better
highlight! Folded ctermfg=102 guifg=#878787 guibg=NONE ctermbg=NONE
highlight! link FoldColumn Folded
highlight! link Column Folded
highlight! link SignColumn Folded
highlight! link GitGutterAdd Folded
highlight! link GitGutterChange Folded
highlight! link GitGutterDelete Folded
highlight! link GitGutterChangeDelete Folded

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
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_section_z = '%{ViraStatusLine()}'

" Flags
" set statusline=%m%r%h%t\
" %{GetFoldStrings()}%=\|%2B\|%3l/%3L\|%{ViraGetActiveIssue()}\|
" Filename
" set statusline+=%t
" Folds
" set statusline+=\ %{GetFoldStrings()}
" Begin right side
" set statusline+=%=
" Cursor in HEX
" set statusline+=\|%2B\|
" Current line
" set statusline+=%3l/%3L\|
" ActiveJira
" set statusline+=%{ViraGetActiveIssue()}\|

" Display {{{2
set lazyredraw      " Postpone screen redraw until macro completion

set t_Co=256
syntax on
" Handled by the OS
" colorscheme solorized
" colorscheme koehler

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

" Highlighting {{{2
let didit = 0
autocmd! InsertEnter * if ! didit | call feedkeys("\<C-\>\<C-o>:nohlsearch|let didit = 1\<CR>", 'n') | endif
autocmd! InsertLeave * let didit = 0


" Remove automatic commenting
set formatoptions-=cro

" Commands {{{1
" QuickFix/Location List {{{2
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

" Key Mappings {{{1
" VIM {{{2
" Key Overrides
noremap j gj
noremap k gk
noremap <silent> p p:SyntasticCheck<cr>
noremap <silent> u u:SyntasticCheck<cr>
nnoremap <silent>/ :let hlstate=1<cr>:set hlsearch<cr>:set incsearch<cr>/\v
nnoremap <silent> H ^
" nnoremap <silent> J }
" noremap <silent> K {
nnoremap <silent> L $
nnoremap <silent> =G mmgg=G`m
nnoremap <silent> <c-h> 3zh
nnoremap <silent> <c-j> 3<c-e>
nnoremap <silent> <c-k> 3<c-y>
nnoremap <silent> <c-l> 3zl

" 'E' Edits / Errors {{{2
nnoremap <silent> <leader>ej :lnext<cr>
nnoremap <silent> <leader>ek :lprev<cr>
nnoremap <silent> <leader>ev :find $MYVIMRC<cr>

" 'F' Formating {{{2
nnoremap <silent> <leader>fu mmviwU`m
nnoremap <silent> <leader>fl mmviwu`m
nnoremap <silent> <leader>; mmA;<esc>`m
nnoremap <silent> <leader><backspace> mmA<backspace><esc>`m

" 'G' Go {{{2
nnoremap <leader>gh :execute "help " . "<cword>"<cr> vnoremap <leader>hh :execute "help " . '<'><cr>
nnoremap <silent> <leader>gf <c-w>vgf

" 'S' Search / Source {{{2
nnoremap <leader>sf :Files<cr>
nnoremap <leader>sh :History<cr>
nnoremap <silent> <leader>sv mm:source $MYVIMRC<cr>`m

" 'T' Tabs / TODOs / Toggles {{{2
" TODO-TJG [190124] - Tabs need to be created
" Tabs {{{3
nnoremap <silent> <leader>tj gt
nnoremap <silent> <leader>tk gT

" TODOs {{{3
nnoremap <silent> <leader>tf /TODO-<cr>
nnoremap <silent> <leader>tg mm:call GetTODOs()<cr>`m
nnoremap <silent> <leader>ti mmO<C-c>:call setline('.',SetTODO('TJG'))<cr>:call NERDComment(0,'toggle')<cr>==`m
nnoremap <silent> <leader>tm :call TakeTODO('TJG')<cr>

" Toggles {{{3
nnoremap <silent> <leader>tc :call NERDComment(0,'toggle')<cr>
nnoremap <silent> <leader>tl :call <SID>LocationListToggle()<cr>
nnoremap <silent> <leader>th :call <SID>ToggleHighlighting()<cr>
nnoremap <silent> <leader>tq :call <SID>QuickfixListToggle()<cr>
nnoremap <silent> <leader>tt :NERDTreeToggle<cr>
nnoremap <silent> <leader>t# :setlocal number!<cr>:setlocal relativenumber!<cr>

" 'V' Vira {{{2
nnoremap <silent> <leader>vc :call ViraInsertComment()<cr>
nnoremap <silent> <leader>vi :call ViraSetActiveIssue()<cr>
nnoremap <silent> <leader>vr :call ViraReport()<cr>

" 'W' Windows {{{2
nnoremap <silent> <leader>w <c-w>
nnoremap <silent> <leader>wch <c-w>h<c-w>c
nnoremap <silent> <leader>wcj <c-w>j<c-w>c
nnoremap <silent> <leader>wck <c-w>k<c-w>c
nnoremap <silent> <leader>wcl <c-w>l<c-w>c

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

set wildmenu
set wildmode=full
source $VIMRUNTIME/menu.vim
set wildcharm=<C-Z>
