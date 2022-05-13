" Basic settings
set nocp
set ignorecase
set modeline
set cursorline
set nobackup
set lazyredraw
set nowrap
set hidden
set backspace=indent,eol,start
set spelllang=en_gb
set spell
set incsearch
set completeopt=longest,menuone
set termguicolors
set shortmess+=F

set listchars=tab:▏\ 
set list
set conceallevel=1

let mapleader = ','

set mouse=a

" Statusline, ruler, and title
set ruler
set rulerformat=%42(%=%#Statusline#%<%t%r%m%#Normal#%14(%l/%L:%v%)%)

set laststatus=0
set statusline=%=%#Statusline#%<%t%r%m%#Normal#%14(%l/%L:%v%)

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

" Highlight search
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
        autocmd Filetype tex,css,scss,html,javascript,markdown,python,scala setlocal tabstop=4 softtabstop=4 shiftwidth=4
        autocmd Filetype java,c,cpp,go,rust setlocal signcolumn=yes
        autocmd Filetype perl setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd FileType make setlocal noexpandtab
        
        autocmd Filetype rust nnoremap <leader>, :%! rustfmt<CR>

        autocmd FileType markdown setlocal nolist
        autocmd FileType markdown syntax region markdownMath start=/\$\$/ end=/\$\$/
        autocmd FileType markdown syntax match markdownMath '\$[^$].\{-}\$'
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

" Make
set makeprg=./%
augroup make_programs
        autocmd!
        autocmd Filetype java setlocal makeprg=javac\ %
        autocmd Filetype cpp setlocal makeprg=c++\ %\ -o\ %:p:h/a.out
        autocmd Filetype python setlocal makeprg=python3\ %
        autocmd Filetype c setlocal makeprg=cc\ %\ -o\ %:p:h/a.out
        autocmd Filetype rust setlocal makeprg=cargo\ run
        autocmd Filetype html setlocal makeprg=w3m\ %
augroup END

map ,. <Esc>:make<Return>

augroup tex_commands
        autocmd!
        autocmd Filetype tex noremap ,. <Esc>:VimtexView<Return>
        autocmd Filetype tex setlocal textwidth=85 conceallevel=0
augroup END

" Colorscheme
let base16colorspace=256
colorscheme base16-tomorrow-night

" Spellcheck
highlight clear SpellBad
highlight SpellBad cterm=underline gui=underline
nnoremap <leader>s a<C-X><C-S>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Enter to finish completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" NERDTree
nnoremap <C-Up> :NERDTreeToggle<CR>
autocmd FileType nerdtree set norelativenumber

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
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Latex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal=''
