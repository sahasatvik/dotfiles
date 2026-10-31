" Basic settings
set nocp
set modeline
set cursorline
set nobackup
set nowrap
set hidden
set backspace=indent,eol,start
set completeopt=longest,menuone
set termguicolors
set shortmess+=F
set shortmess-=S

" Special characters
set listchars=tab:▏\ ,trail:•
set list
set conceallevel=0

" Leader
let mapleader = ','

" Mouse
set mouse=a

" Numbering
nnoremap <C-n> :set number!<Enter>

" Statusline, ruler, and title
set ruler
set rulerformat=%42(%=%<%t%r%m%14(%l/%L:%v%)%)

set laststatus=0
set statusline=%=%<%t%r%m%14(%l/%L:%v%)

set title
set titlestring=%F%(\ [%M]%)\ -\ vim

" Indentation
set tabstop=8
set shiftwidth=8
set softtabstop=8
set expandtab
set autoindent

" IndentLine
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#373b41'
let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 1
let g:indentLine_char = '▏'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_setConceal = 0

" Search
set ignorecase
set incsearch
set hlsearch
nnoremap <silent> <CR> :noh<CR>

" Syntax highlighting
syntax enable
set encoding=utf-8

" Filetype
filetype plugin on

augroup filetype_settings
        autocmd!
        autocmd Filetype plaintex setlocal ft=tex
        autocmd Filetype tex,css,scss,html,javascript,markdown,rmarkdown,python,scala setlocal tabstop=4 softtabstop=4 shiftwidth=4
        " autocmd Filetype java,c,cpp,go,rust setlocal signcolumn=yes
        autocmd Filetype perl setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd FileType make setlocal noexpandtab

        autocmd Filetype rust nnoremap <leader>, :%! rustfmt<CR>

        autocmd FileType markdown setlocal nolist
        autocmd FileType markdown syntax region markdownMath start=/\$\$/ end=/\$\$/
        autocmd FileType markdown syntax match markdownMath '\$[^$].\{-}\$'

        autocmd Filetype tex noremap <leader>. <Esc>:VimtexView<Return>
        autocmd Filetype tex setlocal conceallevel=0
augroup END

" OmniCompletion - <CTRL>X <CTRL>O
set ofu=syntaxcomplete#Complete

" Completion - <CTRL>X <CTRL>U
augroup complete_functions
        autocmd!
        autocmd Filetype java setlocal completefunc=javacomplete#Complete
        autocmd Filetype go setlocal completefunc=go#complete#Complete
        autocmd Filetype html setlocal completefunc=htmlcomplete#CompleteTags
        autocmd Filetype java setlocal omnifunc=javacomplete#Complete
        autocmd Filetype html setlocal omnifunc=htmlcomplete#CompleteTags
augroup END

" Run
map <leader>. <Esc>:!%:p<Return>

" Colorscheme
" let g:jellybeans_use_term_italics = 1
let base16colorspace=256
colorscheme base16-tomorrow-night

" Spellcheck
set spell
set spelllang=en_us
highlight clear SpellBad
highlight clear SpellRare
highlight clear SpellLocal
highlight SpellBad cterm=underline ctermbg=None gui=underline
highlight SpellRare cterm=italic gui=italic
highlight SpellLocal cterm=underline gui=underline
nnoremap <leader>s a<C-X><C-S>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u


" Enter to finish completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

if has("gui_running")
        if (&ft == 'html')
                inoremap <C-Space> <C-x><C-o>
        else
                inoremap <C-Space> <C-x><C-u>
        endif
else
        if has("unix")
                inoremap <Nul> <C-x><C-o>
        endif
endif


" Splits
set fillchars+=vert:│
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffers
nnoremap <C-Left> :bp<CR>
nnoremap <C-Right> :bn<CR>
" nnoremap <C-Down> :bd<CR>


" YouCompleteMe
let g:ycm_error_symbol = '!!'
let g:ycm_warning_symbol = '??'
let g:ycm_filetype_whitelist = {
      \ 'c': 1,
      \ 'cpp': 1,
      \ 'python': 1,
      \ 'java': 1,
      \ 'go': 1,
      \ 'rust': 1,
\}
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_confirm_extra_conf=0
nnoremap <leader>r :YcmCompleter RefactorRename
nnoremap <leader>f :YcmCompleter FixIt<CR>
nnoremap <leader>y :packadd youcompleteme<CR>

" Emmet
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss EmmetInstall

" UltiSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Latex
let g:tex_flavor = 'lualatex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
let g:tex_conceal = ''
