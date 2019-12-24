" File: .vimrc
" Description: VIM configuration file

" Plugins {{{1
" Vundle {{{2
" execute pathogen#infect()

function! BuildYCM(info) " {{{3
  " Build YouCompleteMe after vim-plug clones the repo
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    if has("unix")
      " !./install.py --cs-completer --js-completer
      !~/.vim/bundle/YouComplteMe/install.py --all
    else
      !.\install.py --all
    endif
  endif
endfunction

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug.vim'
Plug 'kalekundert/vim-coiled-snake'
" Plug 'Konfekt/FastFold'


" Plug 'megaannum/forms'
Plug 'vim-airline/vim-airline'

" Git {{{3
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'n0v1c3/vira', { 'do': './install.sh' }

" Commenting {{{3
Plug 'scrooloose/nerdcommenter'

" File Browser {{{3
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Auto complete {{{3
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') } " Auto-completion
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
"Plug 'SirVer/ultisnips'

" Linting {{{3
Plug 'w0rp/ale'

" Formatting {{{3
Plug 'google/yapf'
" Plug 'pignacio/vim-yapf-format'

" Faster/pretty code {{{3
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'terryma/vim-multiple-cursors'
Plug 'yggdroot/indentline'
Plug 'sjl/gundo.vim'

" Bash {{{3
Plug 'dbeniamine/cheat.sh-vim'

" Markdown {{{3
" Plug 'plasticboy/vim-markdown'
Plug 'masukomi/vim-markdown-folding'

call plug#end()
" filetype plugin indent on

" ALE {{{2
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'markdown': ['prettier'],
      \ 'python': ['yapf'],
      \ 'yaml': ['prettier']
      \ }
let g:ale_linters = {
      \ 'python': ['flake8'],
      \ 'vim': ['vint']
      \ }
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 1
let g:ale_statusline_format = [' %d', ' %d', '⬥ ok']
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=brown
set signcolumn=yes

" CtrlP {{{2
let g:ctrlp_cmd = 'CtrlPMRU' " Most recent files

" NERD {{{2
let g:NERDSpaceDelims=1 " One space after auto comment
" Syntastic {{{2
let g:syntastic_php_checkers = ['php', '/bin/phplint']
let g:syntastic_sh_checkers = ['bashate', 'sh', 'shellcheck']
let g:syntastic_sh_shellcheck_args = '--external-sources'
let g:syntastic_vim_checkers = ['vimlint', 'vint']
let g:syntastic_sql_checkers = ['sqlint']
let g:syntastic_python_checkers = ['flake8', 'python']

" YAPF {{{2
let g:yapf_format_yapf_location = '$HOME/.vim/bundle/yapf'

" Vim scripts {{{1
source ~/.vim/functions/folds.vim
source ~/.vim/functions/users.vim

" Test Functions {{{1
" Quickfix List Toggle
" set wildmenu
" set wildmode=full
" source $VIMRUNTIME/menu.vim
" set wildcharm=<C-Z>

" Functions {{{1
function! s:ToggleHighlight() " {{{2
  if g:hlstate
    call feedkeys(":nohlsearch\<cr>")
  else
    call feedkeys(":set hlsearch\<cr>")
  endif
  let g:hlstate = !g:hlstate
endfunction

function! s:QuickfixListToggle() " {{{2
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
function! s:LocationListToggle() " {{{2
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

" Format {{{1
" Quick Attention {{{2
" highlight Attention ctermbg=yellow ctermfg=black

" StatusLine {{{2
" highlight StatusLine ctermbg=black ctermfg=lightgreen
" highlight StatusLineNC ctermbg=lightgreen ctermfg=black

" Configuration {{{1
" Global {{{2
let g:mapleader="\<space>"
let g:maplocalleader='-'
" let g:foldcolumn_init=4
let g:quickfixlist_open=0
let g:locationlist_open=0
let g:quifixlist_height=5
let g:hlstate = 1

" Folds {{{2
set foldenable
" let &foldcolumn=g:foldcolumn_init
set foldlevel=1
set foldlevelstart=1
set foldmethod=marker
set foldnestmax=10
set foldtext=v:folddashes.FormatFoldString(v:foldstart)

" Comments {{{2
" Remove automatic commenting
set formatoptions-=cro

" Fonts {{{2
set guifont=Font\ Awesome\ 14

" Highlights {{{2
" highlight! link Folded Normal
" Folding {{{3
highlight! Folded ctermfg=102 guifg=#878787 guibg=NONE ctermbg=NONE
highlight! link FoldColumn Folded
highlight! link Column Folded
highlight! link SignColumn Folded
highlight! link GitGutterAdd Folded
highlight! link GitGutterChange Folded
highlight! link GitGutterDelete Folded
highlight! link GitGutterChangeDelete Folded

" TODOs {{{3
" highlight! TODO ctermbg=green ctermfg=black

" Whitespace {{{3
highlight WhiteSpace ctermbg=yellow
match WhiteSpace /\v\s+$/

" Indents {{{2
filetype plugin indent on
set tabstop=2               " Tab width
set softtabstop=2           " Tab width
set shiftwidth=2            " Tab width
set expandtab               " Replace tabs with spaces
set smarttab                " Delete spaces like tabs

" Search {{{2
set incsearch               " Search as characters are entered

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

" Display {{{2
" Postpone screen redraw until macro completion
set lazyredraw              " Postpone screen redraw until macro completion
set t_Co=256                " 256 color
syntax on                   " Highlighting requirement
colorscheme solarized       " Public color scheme
set background=dark         " Dark background for theme

" Wildignore {{{2
" Ignore these files when expanding wildcards
set wildignore+=$HOME/.vim/bundle/.*
set wildignore+=*/oh-my-zsh/.*
set wildignore+=*/.oh-my-zsh/.*
set wildignore+=*.swp

" Vira {{{2
" Use YAML files
let g:vira_config_file_servers = $HOME . '/.config/vira/vira_servers.yaml'
let g:vira_config_file_projects = $HOME . '/.config/vira/vira_projects.yaml'

" AutoGroups {{{1
" AutoHotKey {{{2
augroup AHK
  autocmd!
  autocmd  BufNewFile,BufRead *.ahk setfiletype autohotkey
  autocmd  BufNewFile,BufRead *.ahk source $VIM/indents/autohotkey.vim
augroup END

" Commands {{{1
" QuickFix/Location List {{{2
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

" Key Mappings {{{1
" VIM {{{2
noremap <silent> j gj
noremap <silent> k gk
noremap <silent> p p:SyntasticCheck<cr>
noremap <silent> <leader>qa :qa<cr>
noremap <silent> u u:SyntasticCheck<cr>
nnoremap / :set hlsearch<cr>:let g:hlstate=1<cr>/
nnoremap <silent> <leader>l l
nnoremap <silent> <leader>h h
" nnoremap <silent> H ^
" nnoremap <silent> J }
" noremap <silent> K {
" nnoremap <silent> L $
nnoremap <silent> =G mmgg=G`m
nnoremap <silent> <leader>0 mm0`m
nnoremap <silent> <c-h> 3zh
nnoremap <silent> <c-j> 3<c-e>
nnoremap <silent> <c-k> 3<c-y>
nnoremap <silent> <c-l> 3zl

" 'E' Edits / Errors {{{2
nnoremap <silent> <leader>ev :find $MYVIMRC<cr>

nnoremap <silent> <leader>ej :lnext<cr>
nnoremap <silent> <leader>ek :lprev<cr>

" 'F' Formating {{{2
nnoremap <silent> <leader>fu mmviwU`m
nnoremap <silent> <leader>fl mmviwu`m
nnoremap <silent> <leader>; mmA;<esc>`m
nnoremap <silent> <leader><backspace> mmA<backspace><esc>`m

" 'G' Git / Go {{{2
nnoremap <silent> <leader>ga :Git add .<cr><cr>
nnoremap <silent> <leader>gb :execut("Git checkout -b " . input("Branch: "))<cr>
nnoremap <silent> <leader>gl :GV<cr>
nnoremap <silent> <leader>gB :Gblame<cr><c-w>lzz
nnoremap <silent> <leader>gc :Gcommit<cr>
nnoremap <silent> <leader>gC :Git add .<cr>:Gcommit<cr>
nnoremap <silent> <leader>gd :Gvdiffsplit<cr>
nnoremap <silent> <leader>gD :Gvdiffsplit master<cr>
nnoremap <silent> <leader>gM :Gmerge master<cr>
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gp :Git push<cr>

nnoremap <silent> <leader>gf <c-w>vgf

" 'P' Plug {{{2
nnoremap <leader>pu :PlugInstall<cr>:PlugUpdate<cr>

" 'S' Search / Source {{{2
nnoremap <leader>sf :Files<cr>
nnoremap <leader>sh :History<cr>
nnoremap <leader>sw :set ignorecase<cr>:set hlsearch<cr>:let g:hlstate=1<cr>/
nnoremap <leader>sW :set noignorecase<cr>:set hlsearch<cr>:let g:hlstate=1<cr>/

nnoremap <silent> <leader>sv mm:source $MYVIMRC<cr>`m

" 'T' Tabs / Toggles {{{2
" TODO-TJG [190124] - Tabs need to be created
nnoremap <silent> <leader>tj gt
nnoremap <silent> <leader>tk gT

nnoremap <silent> <leader>t# :setlocal number!<cr>:setlocal relativenumber!<cr>
nnoremap <silent> <leader>th :call <SID>ToggleHighlight()<cr>
nnoremap <silent> <leader>tl :call <SID>LocationListToggle()<cr>
nnoremap <silent> <leader>tq :call <SID>QuickfixListToggle()<cr>
nnoremap <silent> <leader>tt :NERDTreeToggle<cr>
noremap <silent> <leader>tc :call NERDComment(0,'toggle')<cr>

" 'V' Vira {{{2
nnoremap <silent> <leader>vI :ViraIssue<cr>
nnoremap <silent> <leader>vT :ViraTodo<cr>
nnoremap <silent> <leader>vb :ViraBrowse<cr>
nnoremap <silent> <leader>vc :ViraComment<cr>
nnoremap <silent> <leader>ve :ViraEpics<cr>
nnoremap <silent> <leader>vi :ViraIssues<cr>
nnoremap <silent> <leader>vq :ViraQuit<cr>
nnoremap <silent> <leader>vr :ViraReport<cr>
nnoremap <silent> <leader>vs :ViraServers<cr>
nnoremap <silent> <leader>vt :ViraTodos<cr>

" Search filters
nnoremap <silent> <leader>vfP :ViraFilterPriorities<cr>
nnoremap <silent> <leader>vfa :ViraFilterAssignees<cr>
nnoremap <silent> <leader>vfp :ViraFilterProjects<cr>
nnoremap <silent> <leader>vfr :ViraFilterReset<cr>
nnoremap <silent> <leader>vfs :ViraFilterStatuses<cr>
nnoremap <silent> <leader>vft :ViraFilterTypes<cr>

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
