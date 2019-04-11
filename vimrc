" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle setup
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Plugin 'scrooloose/nerdtree'
Plugin 'klen/python-mode'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'bling/vim-airline'
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'jnurmine/Zenburn'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'fisadev/vim-isort'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'jpalardy/vim-slime'
" Plugin 'LaTeX-Box-Team/LaTeX-Box'
" Plugin 'vim-latex/vim-latex'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'supercollider/scvim'
" Plugin 'thaerkh/vim-indentguides'
call vundle#end()            " required
filetype plugin indent on    " required

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set showmatch				" show matching brackets
set ignorecase				" case insensitive search...
set smartcase				" ...except if string includes upper-case

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent		" always set autoindenting on
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd				" display incomplete commands
" set incsearch		" do incremental searching
" set autochdir		" automatically change window's cwd to file's dir
set title
set mouse=nv
set mousefocus=on
set tabstop=3
set softtabstop=3
set shiftwidth=3
set smarttab
" set ignorecase
syntax on    " enable syntax highlighting
set hlsearch " Also switch on highlighting the last used search pattern.
set listchars=tab:▷⋅ " makes Tab characters show up nicely on :set list
set wildmenu
set wildmode=list:longest " for bash like handling of ambiguous completion
set pastetoggle=<F2> " for pasting code without auto formatting
set nobackup          " do not keep a backup file, use versions instead
" set backup            " keep a backup file
set timeoutlen=400

"" vim-session configuration
" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers
let g:session_autosave_periodic = 5
let g:session_autoload = 0
let g:session_autosave = 'yes'

let g:localrc_filename = '.local.vimrc'

let mapleader="\\"

" Show cursor line when in insert mode only
au InsertEnter * set cursorline
au InsertLeave * set nocursorline
" autocmd InsertEnter * hi Normal ctermbg=236
" autocmd InsertLeave * hi Normal ctermbg=0
au InsertLeave * :normal `^ " Prevent cursor from moving back one when exitting insert mode

" Set up ag and ack as a search tools
set grepprg=grep\ -nH\ $*
if executable('ag') 
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif

" Ack plugin: recursive search using current file type
nnoremap <leader>; :exec ":Ag! -f <cword>"<CR>
nnoremap <leader>g :exec ":Ack! --follow --type"  (&filetype == "c" ? "cc" : &filetype)  "<cword>"<CR>
nnoremap <leader>p :CtrlP<CR>
" let g:ctrlp_map = '<C-Q>'

let g:ctrlp_follow_symlinks=1

" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" For writing system files if you forget to sudo
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR> 

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" activate visual mode in normal mode
nmap <S-Up> V
nmap <S-Down> V
" " these are mapped in visual mode
vmap <S-Up> k
vmap <S-Down> j

" diffput short cut
nmap <leader>c :set cursorcolumn!<CR>
nmap <leader>i :IndentGuidesToggle<CR>

" Moving around splits (not working)
" map <c-j> <c-w>j
" map <c-k> <c-w>k
" map <c-l> <c-w>l
" map <c-h> <c-w>h
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" fixes annoying Ctrl-Arrow kills line behaviour in screen (NOT WORKING PROPERLY)
" nmap <esc>[5C <C-Right>
" nmap <esc>[5D <C-Left>

" Slime config - send stuff to screen
let g:slime_default_config = {"sessionname": $STY, "windowname": ""}
" let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
" xmap <c-c><c-c> <Plug>SlimeRegionSend
" nmap <c-c><c-c> <Plug>SlimeParagraphSend
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>s <Plug>SlimeParagraphSend
nmap <leader>ss <Plug>SlimeLineSend

" diffput short cut
nmap <leader>v :diffput<CR>

" DESC: Show diff between buffer and version on disk
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" For all text files set 'textwidth' to 78 characters.
	" autocmd FileType text setlocal textwidth=78
	autocmd FileType python setlocal tabstop=4|set shiftwidth=4|set expandtab|setlocal completeopt-=preview
	autocmd FileType cs setlocal tabstop=4|set shiftwidth=4|set expandtab
	autocmd FileType markdown setlocal tabstop=4|set shiftwidth=4|set expandtab
	autocmd FileType julia setlocal tabstop=4|set shiftwidth=4|set expandtab
	autocmd FileType scheme setlocal expandtab|set tabstop=2
	autocmd FileType ocaml setlocal tabstop=2|set shiftwidth=2|set expandtab
	autocmd FileType haskell setlocal tabstop=2|set shiftwidth=2|set expandtab
	autocmd FileType prolog setlocal tabstop=3|set shiftwidth=3|set expandtab
	autocmd FileType c setlocal tabstop=3|set shiftwidth=3|set expandtab
	autocmd FileType tex setlocal tabstop=2|set shiftwidth=2|set expandtab
	autocmd Syntax ocaml set commentstring=(*%s*)
	autocmd Syntax scheme set commentstring=;%s
	autocmd FileType matlab setlocal tabstop=2|set shiftwidth=2
	au Filetype supercollider nnoremap <buffer> <c-x> :SlimeSendCurrentLine<CR>
	au Filetype supercollider inoremap <buffer> <c-c><c-x> :SlimeSendCurrentLine<CR>a
	au Filetype supercollider nnoremap <buffer> <c-c> :SlimeSend0("thisProcess.hardStop()")<CR>

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif

endif " has("autocmd")

au BufWinEnter,BufNewFile,BufRead *.h set filetype=c
au BufWinEnter,BufNewFile,BufRead *.lytex set filetype=tex
" au BufWinEnter,BufNewFile,BufRead *.psm set filetype=prolog
au BufWinEnter,BufNewFile,BufRead *.{pl,psm,chr,yap} set filetype=prolog
" au BufWinEnter,BufNewFile,BufRead *.chr set filetype=prolog
" au BufWinEnter,BufNewFile,BufRead *.yap set filetype=prolog
au BufWinEnter,BufNewFile,BufRead *.chrism set filetype=prolog
au BufWinEnter,BufNewFile,BufRead *.curry set filetype=haskell
au BufWinEnter,BufNewFile,BufRead *.{kern,krn} set filetype=humdrum
" au BufWinEnter,BufNewFile,BufRead *.krn set filetype=humdrum
au BufWinEnter,BufNewFile,BufRead *.church set filetype=scheme
au BufWinEnter,BufNewFile,BufRead .ocamlinit set filetype=ocaml

colorscheme delek
" colorscheme default

" DESC: Remove trailing white space from all lines
fun! StripTrailingSpace()
	  let _s=@/
	  let cursor_pos = getpos('.')
	  silent! %s/\s\+$//
	  call setpos('.', cursor_pos)
	  let @/=_s
endfunction

" highlight trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Fix search highlighting colors and customise status bar and vertical split
hi clear Search
hi clear StatusLine
hi clear StatusLineNC
hi clear VertSplit

hi Search term=underline cterm=underline gui=NONE
hi StatusLine term=bold,underline cterm=underline,bold gui=bold guifg=blue guibg=white
hi StatusLineNC  term=underline cterm=underline guifg=white guibg=blue
hi VertSplit term=bold cterm=bold
hi MatchParen term=underline cterm=bold ctermbg=none  gui=underline

" Good colours for a dark background
hi DiffAdd    ctermbg=238
hi DiffDelete ctermbg=238
hi DiffChange ctermbg=238
hi DiffText   ctermbg=243

" Remove trailing white space on save
au BufWritePre *.pl :call StripTrailingSpace()
au BufWritePre *.tex :call StripTrailingSpace()

" source ~/.scvimrc " supercollider in vim
" source ~/.hsvimrc " haskell in vim

let g:Tex_AutoFolding=0
let g:tex_flavor='latex'
let g:Tex_SmartKeyQuote=0
let g:Imap_UsePlaceHolders=0
let g:Tex_Leader = '`tex'

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_python = 'python'
let g:pymode_rope = 1

" Documentation
" let g:pymode_doc = 1
" let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checkers = 'pyflakes,pep8,pylint'
let g:pymode_debug = 0
let g:pymode_lint_signs = 0
let g:pymode_lint_ignore = split("C0102,W0141,C0103,C0112,C0111,C0326,C0321,C0330,C0301,C1801,C0123,C0411,E124,E128,E131,E201,E202,E203,E221,E225,E228,E271,E231,E261,E272,E702,E301,E302,E305,E306,E501,E701,E731,E741,W1504,W503,W703,W0123,W391,W0110",",")
let g:pymode_lint_write = 1
let g:pymode_lint_minheight = 8

" Support virtualenv
let g:pymode_virtualenv = 0

" Enable breakpoints plugin
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
" let g:pymode_syntax = 1
" let g:pymode_syntax_all = 1
" let g:pymode_syntax_indent_errors = g:pymode_syntax_all
" let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0
" remove automatic line numbers and put everything else back
let g:pymode_options = 0
" setlocal complete+=t
" setlocal formatoptions-=t
" setlocal nowrap
" setlocal textwidth=79
" setlocal commentstring=#%s
" setlocal define=^\s*\\(def\\\\|class\\)

" Jedi configuration
" let g:jedi#popup_on_dot = 0
" " 1: in buffer, 2: in command line
" let g:jedi#show_call_signatures = "1"
" let g:jedi#completions_enabled = 1

" TODO
" nnoremap gr :grep! <cword> *<CR>
" learn about vimgrep
" fugitive git
" %{fugitive#statusline()}
let g:vim_isort_map = '<C-i>'
