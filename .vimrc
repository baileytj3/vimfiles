"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Current Key Mappings:
"	<Ctrl-J>	- Next Tab
"	<Ctrl-K>	- Previous Tab
"	\W			- Strips all trailing whitespace from the current file
"
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible	" This file is not compatible with vi
set nomodeline		" Don't allow overriding vimrc settings
set t_Co=256		" Set vim colors to 256

" Clear any existing autocommands
if has("autocmd")
	autocmd!
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                        "
" vim-plug Plugin Manager - github.com/junegunn/vim-plug "
"                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Status line plugin
Plug 'bling/vim-airline'
	" Set the separaters to empty string instead of the fancy filled in < >
	" that don't come in the default font set.
    let g:airline_left_sep = ""
    let g:airline_left_alt_sep = ""
    let g:airline_right_sep = ""
    let g:airline_right_alt_sep = ""

	" Enable the list of buffers
	let g:airline#extensions#tabline#enabled = 1

	" Show just the filename
	let g:airline#extensions#tabline#fnamemod = ':t'

" Git Gutter
Plug 'airblade/vim-gitgutter'
	" Quick Help
	" ]c - Jump to next hunk
	" [c - Jump to previous hunk
	" <leader>hs - Stage hunk
	" <leader>hr - Unstage hunk
	" <leader>hv - Preview hunk

" Syntax Checking
Plug 'scrooloose/syntastic'

" NERD Tree
Plug 'scrooloose/nerdtree'

" Display indentation levels with vertical lines
Plug 'Yggdroot/indentLine'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                        "
"                 Editor Visual Settings                 "
"                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn syntax highlighting on if vim supports it
if has('syntax') && (&t_Co > 2 || has('gui_running'))
	syntax on

	" Set up the gutter line at 80 char
	if exists('+colorcolumn')
		set colorcolumn=80
		highlight ColorColumn ctermbg=gray guibg=gray
	endif

	if has('extra_search')
		" Turn on search highlighting
		set hlsearch
	endif
endif

set nowrap			" Disable line wrapping
set number			" Enable line numbering
set showmatch		" Show matching brackets
set showmode		" Show the current vim mode
set visualbell		" Flash window instead of beeping

" Enable folding. Uses syntax folding. Does not start
" by default.
if has("folding")
	set foldmethod=syntax
	set foldnestmax=10       " Maximum number of nesting folds
	set foldenable           " Enables folding
	set foldcolumn=0         " Fold column initially 0
	set foldlevel=255        " Closes folds with higher level
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                        "
"                      Indentation                       "
"                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab		" When tab is pressed spaces are inserted
set shiftwidth=4	" Columns indented with reindent operations
set softtabstop=4	" Columns inserted instead of tab
set tabstop=4		" Columns existing tabs take up

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                        "
"                        General                         "
"                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autowrite		" Automatically save the buffer on buffer switch
set hidden			" Allow buffers to be hidden and not closed
set history=1000	" Lines of history to keep
set lazyredraw		" Don't redraw screen for untyped commands
set nostartofline	" Keep the cursor in the same column with C-U, C-D
set scrolloff=3		" Number of lines to keep above and below cursor
set tags=./tags;/	" Look in current directory and work up for tags file
set textwidth=80	" Sets how wide text should be
set title			" Terminal inherits its title from vim
set ttyfast			" Faster redraw, sends more characters to be redrawn at once
set whichwrap+=<,>,h,l,[,]	" Allow the cursor to wrap lines
set ignorecase		" Ignore charater case when searching
set smartcase		" Overrides ignore case if search term has capital
set autowrite

" Disable things that anger crontab (at least on MacOSX)
if $VIM_CRONTAB == "true"
	set nobackup
	set nowritebackup
endif

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<CR>:nohl<CR>

" Enable filetype detection
if has('eval')
	filetype on
	filetype indent on
	filetype plugin on
endif

" Set up informative status line
if has('statusline')
	if version >= 700
		set statusline=%-02.2n\ %t\ %y\ %m\ %r\ %L\ lines%=%lL,%cC\ \(%P\)
		" Enable status line
		set laststatus=2
	endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                        "
"                      Keybindings                       "
"                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set new leader
let mapleader = "\<Space>"

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Easy exit of INSERT mode
inoremap jk <esc>

" Remap PageUp and PageDown such that the keys act like Control-U and
" Control-D, respectively.
noremap <PageUp> <C-U>
noremap <PageDown> <C-D>
inoremap <PageUp> <C-O><C-U>
inoremap <PageDown> <C-O><C-D>

" Source .vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

" Edit .vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Don't have to press shift for commands like :w and :q
nnoremap ; :

" Format paragraph text from within visual or normal modes with same command
vnoremap Q gq
nnoremap Q gqap

" Clear search highlighting
nnoremap <leader>/ :nohlsearch<cr>

" Run the current file
nnoremap <leader>r :!%:p<cr>

"
" Buffer keys
"
" Open new empty buffer
nnoremap <leader>t :enew<cr>
" Move to the next buffer
nnoremap <leader>l :bnext<cr>
" Move to the previous buffer
nnoremap <leader>h :bprevious<cr>
" Close the current buffer and move to the previous one
nnoremap <leader>bq :bp <bar> bd #<cr>
" Show all open buffers and status
nnoremap <leader>bl :ls<cr>