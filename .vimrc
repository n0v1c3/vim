" File: .vimrc
" Description: VIM configuration file

" Plugins {{{1
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
" filetype off
filetype indent plugin on
" set rtp+=~/.vim/bundle/Vundle.vim
let plugDir = $HOME . '/.vim/plugged'
call plug#begin(plugDir)
" Git {{{3
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'ryanoasis/vim-devicons'

" Jira {{{3
Plug 'n0v1c3/vira', { 'do': 'ViraIssues', 'branch': 'dev'}            " Jira integration
Plug 'n0v1c3/vql'

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
" Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'

" Linting {{{3
Plug 'w0rp/ale'

" Formatting {{{3
Plug 'google/yapf'
Plug 'chiel92/vim-autoformat'
Plug 'OmniSharp/omnisharp-vim'
Plug 'pignacio/vim-yapf-format'

" Faster/pretty code {{{3
Plug 'tpope/vim-surround'
" Plug 'lifepillar/vim-solarized8'        " Colour scheme
" Plug 'altercation/vim-colors-solarized' " Colour scheme
Plug 'yggdroot/indentline'
Plug 'sjl/gundo.vim'

" Python {{{3
Plug 'mattboehm/vim-unstack'                                            " Jump to python errors

" Bash {{{3
" Plug 'dbeniamine/cheat.sh-vim'

" Markdown {{{3
Plug 'masukomi/vim-markdown-folding'
Plug 'JamshedVesuna/vim-markdown-preview'

" Games {{{3
Plug 'kalekundert/vim-coiled-snake'

" General {{{3
Plug 'vim-airline/vim-airline'

" Boiko {{{3
Plug 'PProvost/vim-ps1'                                                 " Powershell file types
Plug 'Shougo/deoplete.nvim'                                             " Auto-completion engine
Plug 'SirVer/ultisnips'                                                 " Snippet engine
Plug 'christoomey/vim-tmux-navigator'                                   " Switch beween vim splits & tmux panes seamslessly
Plug 'deoplete-plugins/deoplete-tag'                                    " Complete from ctags
Plug 'godlygeek/tabular'                                                " Align things
Plug 'honza/vim-snippets'                                               " Snippet library
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " Preview md in brwoser
Plug 'junegunn/vader.vim'                                               " VimScript testing
Plug 'ludovicchabant/vim-gutentags'                                     " Manage ctags
Plug 'majutsushi/tagbar'                                                " Use c-tags in real time and display tag bar
Plug 'mikeboiko/auto-pairs'                                             " Auto-close brackets
Plug 'mikeboiko/vim-sort-folds'                                         " Sort vim folds
Plug 'posva/vim-vue'                                                    " Vue filetype recognition
Plug 'roxma/nvim-yarp'                                                  " Auto-completion engine
Plug 'roxma/vim-hug-neovim-rpc'                                         " Auto-completion engine
Plug 'sheerun/vim-polyglot'                                             " Language Pack (syntax/indent)
Plug 'tommcdo/vim-fubitive'                                             " Extend fugitive.vim to support Bitbucket URLs in :Gbrowse.
Plug 'tpope/vim-repeat'                                                 " Repeat surround and commenting with .
Plug 'tpope/vim-rhubarb'                                                " GitHub integration with fugitive
Plug 'tpope/vim-scriptease'                                             " For debugging and writing plugins
Plug 'yssl/QFEnter'                                                     " QuickFix lists - open in tabs/split windows

Plug 'chisbra/csv.vim'
call plug#end()
" filetype plugin indent on

" ALE {{{2
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'cs': ['uncrustify'],
      \ 'html': ['prettier'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascript.jsx': ['eslint'],
      \ 'json': ['prettier'],
      \ 'markdown': ['prettier'],
      \ 'python': ['yapf'],
      \ 'vue': ['prettier'],
      \ 'yaml': ['prettier']
      \ }
let g:ale_linters = {
      \ 'cs': ['OmniSharp'],
      \ 'python': ['flake8', 'pyls'],
      \ 'vim': ['vint']
      \ }
let g:ale_python_pyls_config = {
      \   'pyls': {
      \     'plugins': {
      \       'pyflakes': {
      \         'enabled': v:false
      \       },
      \       'pycodestyle': {
      \         'enabled': v:false
      \       }
      \     }
      \   },
      \ }
" let g:ale_lint_on_text_changed = 'always'
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0
let g:ale_fix_on_save = 1
let g:ale_statusline_format = [' %d', ' %d', '⬥ ok']
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=brown
set signcolumn=yes
nnoremap <leader>se :call ALERunLint()<CR>
let g:maxQFlistRecords = 8
let g:qfListHeight = 5
function! ALEOpenResults() " {{{2
  let l:bfnum = bufnr('')
  let l:items = ale#engine#GetLoclist(l:bfnum)
  call setqflist([], 'r', {'items': l:items, 'title': 'ALE results'})
  let g:qfListHeight = min([ g:maxQFlistRecords, len(getqflist()) ])
  exe 'top ' . g:qfListHeight . ' cwindow'
endfunction"

function! ALERunLint() " {{{2
  if empty(ale#engine#GetLoclist(bufnr('')))
    let b:ale_enabled = 1
    augroup ALEProgress
      autocmd!
      autocmd User ALELintPost call ALEOpenResults() | autocmd! ALEProgress
    augroup end
    call ale#Queue(0, 'lint_file')
  else
    call ALEOpenResults()
  endif
endfunction


" OmniSharp {{{2
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  set previewheight=5
endif
let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_timeout = 2
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_stdio = 1

      " CtrlP {{{2
let g:ctrlp_cmd = 'CtrlPMRU' " Most recent files
nmap <c-p> :execute g:ctrlp_cmd<CR>
command! ToggleCtrlP if (g:ctrlp_cmd == 'CtrlPMRU') | let g:ctrlp_cmd = 'CtrlP' | echo 'CtrlP in Project Files Mode' | else | let g:ctrlp_cmd = 'CtrlPMRU' | echo 'CtrlP in MRU Files Mode' | endif

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
let g:unstack_populate_quickfix=1
let g:unstack_layout = "portrait"

" Functions {{{1
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
let &t_SI = "\<esc>[5 q"    " `Insert` blinky pipe bar
let &t_SR = "\<esc>[3 q"    " `Replace` blinky undercore
let &t_EI = "\<esc>[2 q"    " `Normal` blinky block cursor
" silent !echo -ne "\033]12;orange\007"
" set t_VI=0                " `Normal` blinky block cursor
" set cursorline              " Highligth cursor line

" CtrlP {{{2
" Fuzzy file/buffer/tag open

" Since I'm toggling CtrlP functionality, I remapped my own <c-p> command
let g:ctrlp_map = ''

" Most recent files is default
let g:ctrlp_cmd = 'CtrlPMRU'

" Use filename instead of full path for searching
" let g:ctrlp_by_filename = 1

" Remap hotkeys
let g:ctrlp_prompt_mappings = {
            \ 'PrtSelectMove("j")':   ['J', '<down>'],
            \ 'PrtSelectMove("k")':   ['K', '<up>'],
            \ 'ToggleType(1)':        ['<c-f>'],
            \ 'ToggleType(-1)':       ['<c-b>'],
            \ }

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
set guifont=Font\ Awesome\ 12

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
set tabstop=4               " Tab width
set softtabstop=4           " Tab width
set shiftwidth=0            " Tab width
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
let g:airline_section_a = '%{ViraStatusLine()}'

" Display {{{2
" Postpone screen redraw until macro completion
set lazyredraw            " Postpone screen redraw until macro completion
set t_Co=256              " 256 color
" syntax on               " Highlighting requirement
" syntax enable           " Highlighting requirement
set background=dark       " Dark background for theme
" colorscheme solarized8  " Public colour scheme
" colorscheme solarized   " Public colour scheme

" Wildmenu {{{2
set wildmenu        " Tab to display posible `menu` options
set wildmode=full   " `wildmod` full` list
set wildcharm=<C-Z> " `wildcharm` key mapping `Ctrl+Z`

" Ignore these files when expanding wildcards
set wildignore+=$HOME/.vim/bundle/.*
set wildignore+=*/oh-my-zsh/.*
set wildignore+=*/.oh-my-zsh/.*
set wildignore+=*.swp

" Vira {{{2
" Use YAML files
let g:vira_config_file_servers = $HOME . '/.config/vira/vira_servers.yaml'
let g:vira_config_file_servers = $HOME . '/.config/vira/vira_servers.yaml'
let g:vira_config_file_projects = $HOME . '/.config/vira/vira_projects.yaml'
let g:vira_async_sleep = 0
let g:vira_async_timer = 0
" let g:vira_async_timer = 1000
" let g:vira_jql_max_results = '100'
let g:vira_menu_height = '10'
" let g:vira_menu_height = 'J'
" let g:vira_report_width = 'R'


" AutoGroups {{{1
augroup AHK " {{{2
  autocmd!
  autocmd  BufNewFile,BufRead *.ahk setfiletype autohotkey
  autocmd  BufNewFile,BufRead *.ahk source $VIM/indents/autohotkey.vim
augroup END

augroup VIM " {{{2
  autocmd!
  autocmd FileType vim setlocal keywordprg=:help
  autocmd FileType vim setlocal expandtab
  autocmd FileType vim setlocal tabstop=2
  autocmd FileType vim setlocal shiftwidth=2
augroup END

augroup GV " {{{2
  autocmd!
  autocmd FileType GV nmap <buffer> <silent> <leader>g 0f-f wyiw:Git checkout <c-r>"<cr>
  autocmd FileType GV nmap <buffer> <silent> <leader>v /[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  autocmd FileType GV nmap <buffer> <silent> <leader>V ?[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  autocmd FileType GV nmap <buffer> <silent> s /[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  autocmd FileType GV nmap <buffer> <silent> S $[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  autocmd FileType GV nmap <buffer> <silent> R /[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  autocmd FileType GV nmap <buffer> <silent> r :ViraReport<cr>
  autocmd FileType GV nmap <buffer> <silent> i /[a-zA-Z]\+-[0-9]\+<cr>
  autocmd FileType GV nmap <buffer> <silent> I ?[a-zA-Z]\+-[0-9]\+<cr>
augroup END
nnoremap <silent> <leader>gl :GV --all<cr>

augroup vira " {{{2
  autocmd!
  autocmd FileType conf nmap <buffer> <silent> <leader>vb $A<cr><cr>----<cr><cr>
  autocmd FileType vira_report nmap <buffer> <silent> <leader>g 0f-f wyiw:Git checkout <c-r>"<cr>
  autocmd FileType vira_report nmap <buffer> <silent> <leader>v /[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  autocmd FileType vira_report nmap <buffer> <silent> <leader>V ?[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  " autocmd FileType vira_report nmap <buffer> <silent> s /[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  " autocmd FileType vira_report nmap <buffer> <silent> S $[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  " autocmd FileType vira_report nmap <buffer> <silent> R /[a-zA-Z]\+-[0-9]\+<cr>3yiw:let g:vira_active_issue = "<c-r>""<cr>:ViraReport<cr>
  " autocmd FileType vira_report nmap <buffer> <silent> r :ViraReport<cr>
  autocmd FileType vira_report nmap <buffer> <silent> i /[a-zA-Z]\+-[0-9]\+<cr>
  autocmd FileType vira_report nmap <buffer> <silent> I ?[a-zA-Z]\+-[0-9]\+<cr>
augroup END

augroup dev_web " {{{2
  autocmd!
  autocmd BufNewFile,BufRead *.js, *.html, *.css
  autocmd BufNewFile,BufRead *.js, *.html, *.css set tabstop=2
  autocmd BufNewFile,BufRead *.js, *.html, *.css set softtabstop=2
  autocmd BufNewFile,BufRead *.js, *.html, *.css set shiftwidth=2
augroup END


" Commands {{{1
" QuickFix/Location List {{{2
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast  | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast  | catch | endtry

" Key Mappings {{{1
" VIM {{{2
noremap <silent> j gj
noremap <silent> k gk
" noremap <silent> p p:SyntasticCheck<cr>
" noremap <silent> u u:SyntasticCheck<cr>
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

nnoremap <silent> <leader>ej :lnext<cr>
nnoremap <silent> <leader>ek :lprev<cr>
nnoremap <silent> <leader>J :prev<cr>
nnoremap <silent> <leader>K :next<cr>

" nnoremap <silent> <leader>vn :ViraServers<cr>:! vim<cr>
nnoremap <silent> <leader>vvh :vert terminal htop<cr>
nnoremap <silent> <leader>vvi :terminal nohup vim<cr>:ViraIssues<cr><cr>:q<cr>exit<cr>
nnoremap <silent> <leader>vvr :terminal nohup<cr>vim<cr>:ViraReport<cr><cr>
" nnoremap <silent> <leader>vvi :terminal nohup vim<cr>:ViraIssues<cr><cr>
" nnoremap <silent> <leader>vvr :terminal nohup vim<cr>:ViraReport<cr><cr>
"<cr>vim<cr>:ViraServers<cr>
nnoremap <silent> <leader>vtf :let g:vira_async_timer=1000<cr>
nnoremap <silent> <leader>vts :let g:vira_async_timer=25<cr>

" 'C' Code {{{2
nnoremap <silent> <leader>cf :OmniSharpCodeFormat<cr>

" 'E' Edits / Errors {{{2
nnoremap <silent> <leader>ev <c-w>s:find $MYVIMRC<cr>
nnoremap <silent> <leader>eV :find $MYVIMRC<cr>

nnoremap <silent> <leader>ej :lnext<cr>
nnoremap <silent> <leader>ek :lprev<cr>

" 'F' Formating {{{2
nnoremap <silent> <leader>fu mmviwU`m
nnoremap <silent> <leader>fl mmviwu`m
nnoremap <silent> <leader>; mmA;<esc>`m
nnoremap <silent> <leader><backspace> mmA<backspace><esc>`m

" 'G' Git / Go {{{2
function! s:VGprompt()
  if g:vira_active_issue != 'None'
    return '"' . g:vira_active_issue . ': ' . input(g:vira_active_issue . ': ') . '"' | endif
  return '"' . input(g:vira_active_issue . ': ') . '"'
endfunction

function! s:VGcommit()
  execute 'Git commit -m ' . s:VGprompt()
  execute 'Git push'
endfunction

function! s:VGbranch()
  execute 'Git checkout dev'
  execute 'Git pull'
  execute 'Git checkout -b ' . g:vira_active_issue
  execute 'Git checkout ' . g:vira_active_issue
  execute 'Git push -u origin ' . g:vira_active_issue
endfunction

function s:VGmerge()
  execute 'Git checkout dev'
  execute 'Git pull'
  execute 'Gmerge --no-ff ' . g:vira_active_issue . ' -m ' . s:VGprompt()
  execute 'Git push'

  execute 'Git branch -d ' . g:vira_active_issue
  execute 'Git push origin --delete ' . g:vira_active_issue
  execute 'Git push'
endfunction

" TODO: VIRA-164 [200608] - update my master merge function in vim
function s:VGmaster()
  execute 'Git checkout master'
  execute 'Git pull'
  execute 'Gmerge --no-ff dev -m "' . input('VIRA ' . input('Version: ') .  ' - ')
  execute 'Git push'
endfunction

nnoremap <leader>gb :call <SID>VGbranch()<cr>
nnoremap <leader>gc :call <SID>VGcommit()<cr>
nnoremap <leader>gm :call <SID>VGmerge()<cr>
nnoremap <leader>gM :call <SID>VGmaster()<cr>

nnoremap <silent> <leader>ga :Git add .<cr><cr>
nnoremap <silent> <leader>gB :Gblame<cr><c-w>lzz
nnoremap <silent> <leader>gCd :Git checkout dev<cr>
nnoremap <silent> <leader>gCf :Git checkout %<cr>
nnoremap <silent> <leader>gd :Gvdiffsplit<cr><c-w>llh
nnoremap <silent> <leader>gD :Gvdiffsplit master<cr>
nnoremap <silent> <leader>gp :Git push<cr>
nnoremap <silent> <leader>gP :Git pull<cr>
nnoremap <silent> <leader>gs :Gstatus<cr>

nnoremap <silent> <leader>gf <c-w>vgf

" 'H' Help {{{2
nnoremap <expr> <leader>h ':help ' . expand('<cword>') . '\n'

" 'N' Notes {{{2
nnoremap <silent> <leader>nh <C-w>s:find $dev/travis/health/README.md<cr>ggVGzCG
nnoremap <silent> <leader>Nh :find $dev/travis/health/README.md<cr>ggVGzCG
nnoremap <silent> <leader>np <C-w>s:find ~/notes.md<cr>ggVGzCG
nnoremap <silent> <leader>Np :find ~/notes.md<cr>ggVGzCG
nnoremap <silent> <leader>nf <C-w>s:find /var/syncthing/mb-accutune/Notes/Meeting/<cr>G
nnoremap <silent> <leader>Nf :find /var/syncthing/mb-accutune/Notes/Meeting/<cr>G

" 'L' Logs {{{2
nnoremap <silent> <leader>lc A<cr><esc>i- [ ]<space>
nnoremap <silent> <leader>ln A<cr><esc>4<space>i-<space>
nnoremap <silent> <leader>ld mm03lrx`m " done
nnoremap <silent> <leader>lf mm03lr>`m " forward
nnoremap <silent> <leader>lq mmk3lr?`m " question
nnoremap <silent> <leader>lr mm03lr-`m " remvoed
nnoremap <silent> <leader>lx mm03lrx`m " done

" 'P' Plug {{{2
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pu :PlugUpdate<cr>
nnoremap <leader>pc :PlugClean<cr>

" 'Q' Quit {{{2
noremap <silent> <leader>qa :qa<cr>
noremap <silent> <leader>qw <c-w>q

" 'S' Select / Search / Source / Spell {{{2
nnoremap <leader>si :call Select_ViraActiveIssue()<cr>
nnoremap <leader>sf :Files<cr>
nnoremap <leader>sh :History<cr>
nnoremap <leader>sw :set ignorecase<cr>:set hlsearch<cr>:let g:hlstate=1<cr>/
nnoremap <leader>sW :set noignorecase<cr>:set hlsearch<cr>:let g:hlstate=1<cr>/

nnoremap <silent> <leader>sv mm:source $MYVIMRC<cr>`mVzO`m

" `W` Wildmenu/mode/charm mappings
cnoremap sv source $HOME/.vimrc<C-Z>

" nnoremap <leader>sl :set spelllang=en_ca<cr>
nnoremap <leader>ss :setlocal spell!<cr>
nnoremap <leader>sc z=1<cr>

" 'T' Tabbles / Tabs / Tags / Toggles {{{2
let g:table_mode_header_fillchar='='
let g:table_mode_corner='+'
nnoremap <silent> <leader>tm :TableModeToggle<cr>
nnoremap <silent> <leader>tr :TableModeRealign<cr>
nnoremap <silent> <leader>Tc retab<cr>

nnoremap <silent> <leader>tn :tabnew<cr>
nnoremap <silent> <leader>j gT
nnoremap <silent> <leader>k gt
nnoremap <silent> <leader>tj gT
nnoremap <silent> <leader>tk gt

nnoremap <silent> <leader>t# :setlocal number!<cr>:setlocal relativenumber!<cr>
noremap <silent> <leader>tc :call NERDComment(0,'toggle')<cr>
nnoremap <silent> <leader>th :set hls!<cr>
nnoremap <silent> <leader>tl :call <SID>LocationListToggle()<cr>
nnoremap <silent> <leader>tq :call <SID>QuickfixListToggle()<cr>
nnoremap <silent> <leader>tt :NERDTreeToggle<cr>
nnoremap <silent> <leader>tw :setlocal wrap!<cr>0^
nnoremap <silent> <leader>ts :setlocal spell!<cr>
nnoremap <silent> <leader>tC :setlocal cursorline!<cr>

" 'V' Vira {{{2
" let g:vira_browser = "chromium"
let g:vira_browser = "firefox"

" Custom
function! Git_ViraActiveIssue()
    let g:vira_active_issue = execute('Git branch --show-current > echo')
    ViraReport
endfunction
function! Select_ViraActiveIssue()
    let g:vira_active_issue = expand('<cWORD>')
    ViraReport
endfunction
nnoremap <silent> <leader>vgi :call Git_ViraActiveIssue()<cr>

function! Enter_ViraActiveIssue()
    let g:vira_active_issue = input("Enter issue.key: ")
    ViraReport
endfunction
nnoremap <silent> <leader>vei :call Enter_ViraActiveIssue()<cr>

nnoremap <silent> <leader>vA :ViraAssignIssue<cr>
nnoremap <silent> <leader>vI :ViraIssue<cr>
nnoremap <silent> <leader>vT :ViraTodo<cr>
nnoremap <silent> <leader>vB :ViraBrowse<cr>
nnoremap <silent> <leader>vc :ViraComment<cr>
nnoremap <silent> <leader>vi :ViraIssues<cr>
nnoremap <silent> <leader>vq :ViraQuit<cr>
nnoremap <silent> <leader>vr :ViraReport<cr>
nnoremap <silent> <leader>vR :ViraRefresh<cr>
nnoremap <silent> <leader>vS :ViraServers<cr>
nnoremap <silent> <leader>t :ViraTodos<cr>

            " 0\w\>-\wbyiw
            " 03f-b3yiw
nnoremap <silent> <leader>vh /\vVIRA-\d*<cr>
nnoremap <silent> <leader>vy v3ey

" Sets
nnoremap <silent> <leader>vsa :ViraSetAssignee<cr>
nnoremap <silent> <leader>vsc :ViraSetComponent<cr>
nnoremap <silent> <leader>vse :ViraSetEpic<cr>
nnoremap <silent> <leader>vsp :ViraSetPriority<cr>
nnoremap <silent> <leader>vss :ViraSetStatus<cr>
nnoremap <silent> <leader>vsv :ViraSetVersion<cr>

" Edit
nnoremap <silent> <leader>ved :ViraEditDescription<cr>
nnoremap <silent> <leader>ves :ViraEditSummary<cr>

" Filters
nnoremap <silent> <leader>v/ :ViraFilterText<cr>
nnoremap <silent> <leader>vf/ :ViraFilterText<cr>

nnoremap <silent> <leader>vfE :ViraFilterEdit<cr>
nnoremap <silent> <leader>vfP :ViraFilterProjects<cr>
nnoremap <silent> <leader>vfR :ViraFilterReset<cr>
nnoremap <silent> <leader>vfa :ViraFilterAssignees<cr>
nnoremap <silent> <leader>vfc :ViraFilterComponent<cr>
nnoremap <silent> <leader>vfe :ViraFilterEpics<cr>
nnoremap <silent> <leader>vfi :ViraIssues<cr>
nnoremap <silent> <leader>vfp :ViraFilterPriorities<cr>
nnoremap <silent> <leader>vfr :ViraFilterReporters<cr>
nnoremap <silent> <leader>vfs :ViraFilterStatuses<cr>
nnoremap <silent> <leader>vft :ViraFilterTypes<cr>
nnoremap <silent> <leader>vfv :ViraFilterVersions<cr>

" Branches and Projects
nnoremap <silent> <leader>vbA :ViraLoadProject __accutune__<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbR :ViraLoadProject __default__<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbV :ViraLoadProject vira<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbam :ViraLoadProject main<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbd :ViraLoadProject deminicos<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbh :ViraLoadProject home<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbH :ViraLoadProject health<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbl :ViraLoadProject linux<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbN :ViraLoadProject __n0v1c3__<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbv :ViraLoadProject vim<cr>:ViraQuit<cr>:ViraIssues<cr>
nnoremap <silent> <leader>vbw :ViraLoadProject website<cr>:ViraQuit<cr>:ViraIssues<cr>

" 'W' Windows {{{2
nnoremap <silent> <leader>w <c-w>
nnoremap <silent> <leader>wo <c-w>oVzokj
nnoremap <silent> <leader>wr <c-w>oVzokj:ViraReport<cr>

" 'Z' Folding {{{2
nnoremap <silent> zC mmggVGzC`m<esc>kj
nnoremap <silent> zO mmggVGzO`m<esc>kj
nnoremap <silent> <leader><leader> za

nnoremap <silent> <leader>gw :tabnew<cr>:terminal ++curwin curl wttr.in/Calgary<cr>

inoremap <F5> <C-R>=ListMonths()<CR>

let g:unstack_populate_quickfix=1
let g:unstack_layout = "portrait"

set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
            \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

func! ListMonths()
    call complete(col('.'), ['','January', 'February', 'March',
                \ 'April', 'May', 'June', 'July', 'August', 'September',
                \ 'October', 'November', 'December'])
    return ''
endfunc

function! PrintWorkingDir()

endfunction
