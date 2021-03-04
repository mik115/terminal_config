"  ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
set encoding=UTF-8

let g:python3_host_prog = $HOME . '/.pyenv/versions/3.6.5/envs/neovim3/bin/python'
let g:python_host_prog = $HOME . '/.pyenv/versions/2.7.15/envs/neovim2/bin/python'

let mapleader = ','

call plug#begin('~/.config/nvim/plugged')

" Common
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'           " CtrlP is installed to support tag finding in vim-go
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'bling/vim-airline'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dyng/ctrlsf.vim'

" Language support
Plug 'lifepillar/pgsql.vim'         " PostgreSQL syntax highlighting
Plug 'fatih/vim-go'                 " Golang support
Plug 'sebdah/vim-delve'             " Golang debugger
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins', 'for': 'python' } " Python autocomplete
Plug 'davidhalter/jedi-vim', { 'for': 'python' }  " Python goto etc
Plug 'tmhedberg/SimpylFold'         " Python folding
Plug 'iamcco/markdown-preview.vim'  " Markdown live preview in browser
Plug 'phanviet/vim-monokai-pro'

call plug#end()

set autoread
set autoindent
set autowrite
set completeopt-=preview
set cursorline
set noerrorbells
set noswapfile
set novisualbell
set smartindent
set number relativenumber

set ruler
set ignorecase

" Colorscheme
set termguicolors
colorscheme monokai_pro

" Font settings
set guifont=Inconsolata:h13

" Enable mouse if possible
if has('mouse')
    set mouse=a
endif

" Remove trailing white spaces on save
autocmd BufWritePre * :%s/\s\+$//e
set title

" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

" Allow vim to set a custom font or color for a word
syntax enable

" Common indentation settings
set noexpandtab
set shiftwidth=4
set tabstop=4


" Javascript
autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Yaml
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Error and warning signs.
let g:ale_sign_error = '‚§´'
let g:ale_sign_warning = '‚ö†'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1


" Fix some common typos
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"----------------------------------------------
" Splits
"----------------------------------------------
" Create horizontal splits below the current window
set splitbelow
set splitright

" Creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

" Closing splits
nnoremap <leader>q :close<cr>

"----------------------------------------------
" Plugin: 'ctrlpvim/ctrlp.vim'
"----------------------------------------------
" Note: We are not using CtrlP much in this configuration. But vim-go depend on
" it to run GoDecls(Dir).

" Disable the CtrlP mapping, since we want to use FZF instead for <c-p>.
let g:ctrlp_map = ''

"----------------------------------------------
" Plugin: 'scrooloose/nerdtree'
"----------------------------------------------
noremap <leader>n :NERDTreeTabsToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.pyc$', '^__pycache__$', 'egg-info$']
"let NERDTreeMapOpenInTab='\r'
"let NERDTreeMapOpenInTab='<ENTER>'
"let NERDTreeMapOpenInTab='o'
let g:nerdtree_tabs_open_on_gui_startup = 2
let g:nerdtree_tabs_smart_startup_focus = 1


"----------------------------------------------
" Plugin: 'junegunn/fzf.vim'
"----------------------------------------------
" Note: We are not using CtrlP much in this configuration. But vim-go depend on
" it to run GoDecls(Dir).


" Disable the CtrlP mapping, since we want to use FZF instead for <c-p>.

nnoremap <c-p> :FZF<cr>

"----------------------------------------------
" Plugin: 'w0rp/ale'
"----------------------------------------------
let g:ale_python_flake8_options = '--max-line-length=100'
let g:ale_python_pylint_options = '--max-line-length=100 --no-docstring-rgx=test'
let g:ale_linters = {
\    'javascript': ['eslint'],
\    'python': ['flake8']
\}

"----------------------------------------------
" Plugin: 'sheerun/vim-polyglot'
"----------------------------------------------
let g:polyglot_disabled = ['md', 'markdown']

"----------------------------------------------
" Plugin: 'tmhedberg/SimpylFold'
"----------------------------------------------
let g:SimpylFold_docstring_preview	= 0
let g:SimpylFold_fold_docstring		= 1
let b:SimpylFold_fold_docstring		= 1
let g:SimpylFold_fold_import		= 0
let b:SimpylFold_fold_import		= 0

"----------------------------------------------
" Plugin: 'Shougo/neosnippet'
"----------------------------------------------

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"----------------------------------------------
" Plugin: 'dyng/ctrlsf.vim'
"----------------------------------------------
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_focus = {
\ "at": "start"
\ }


" for copy inside the clipboard
set clipboard+=unnamedplus

map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

nmap     <C-F>f <Plug>CtrlSFPrompt
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath

