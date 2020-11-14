" Basic settings
set nocp
set laststatus=2
set ruler
set number
set ignorecase
set modeline
set nobackup
set wrap
set hidden
set backspace=indent,eol,start
set spelllang=en_gb
set spell
set incsearch
set wildmode=full
set wildmenu
set completeopt=longest,menuone
set termguicolors
set shortmess+=F

set listchars=tab:▏\ 
set list

let mapleader = ','

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
let g:indentLine_concealcursor = 'nc'
let g:indentLine_conceallevel = 2

set noshowmode
set showtabline=2

" Highlight search
set hlsearch
nnoremap <CR> :noh<CR><CR>

" Syntax highlighting
syntax enable
set encoding=utf-8

" Bracket completion
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
                return "\<Right>"
        else
                return a:char
        endif
endf

function CloseBracket()
        if match(getline(line('.') + 1), '\s*}') < 0
                return "\<CR>}"
        else
                return "\<Esc>j0f}a"
        endif
endf

function QuoteDelim(char)
        let line = getline('.')
        let col = col('.')
        if line[col - 2] == "\\"
                return a:char
        elseif line[col - 1] == a:char
                return "\<Right>"
        else
        return a:char.a:char."\<Esc>i"
        endif
endf

" Filetype
filetype plugin on

autocmd Filetype plaintex setlocal ft=tex
autocmd Filetype css,html,javascript,markdown,python,scala setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype perl setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab

autocmd FileType markdown setlocal nolist
autocmd FileType markdown syntax region markdownMath start=/\$\$/ end=/\$\$/
autocmd FileType markdown syntax match markdownMath '\$[^$].\{-}\$'

" OmniCompletion - <CTRL>X <CTRL>O
set ofu=syntaxcomplete#Complete

" Completion - <CTRL>X <CTRL>U
autocmd Filetype java setlocal completefunc=javacomplete#Complete
autocmd Filetype go setlocal completefunc=go#complete#Complete
autocmd Filetype html setlocal completefunc=htmlcomplete#CompleteTags

autocmd Filetype java setlocal omnifunc=javacomplete#Complete
autocmd Filetype html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd Filetype python setlocal omnifunc=pythoncomplete#Complete 


" Make
set makeprg=./%
autocmd Filetype java setlocal makeprg=javac\ %
autocmd Filetype cpp setlocal makeprg=c++\ %\ -o\ %:p:h/a.out
autocmd Filetype python setlocal makeprg=python3\ %
autocmd Filetype c setlocal makeprg=cc\ %\ -o\ %:p:h/a.out
autocmd Filetype html setlocal makeprg=w3m\ %

map ,. <Esc>:make<Return>

autocmd Filetype tex noremap ,. <Esc>:w<Return>:Latexmk<Return>
autocmd Filetype tex noremap <> <Esc>:LatexView<Return>

" MiniBufExplorer
let g:miniBufExplMapWindowNavVim    = 1
let g:miniBufExplMapWindowNavArrows = 1

" Colorscheme
let base16colorspace=256
colorscheme base16-tomorrow-night

" Spellchecking colors
highlight clear SpellBad
highlight SpellBad cterm=underline
nnoremap <leader>s a<C-X><C-S>

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

" JavaComplete
nmap <F3> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F3> <Plug>(JavaComplete-Imports-RemoveUnused)
nmap <F4> <Plug>(JavaComplete-Imports-AddMissing)
imap <F4> <Plug>(JavaComplete-Imports-AddMissing)

" Emmet
let g:user_emmet_leader_key=','

" Lightline
source ~/.vim/colors/tomorrow-night-lightline.vim
let g:lightline = {
\ 'colorscheme': 'tomorrow_night_lightline',
\ 'tabline': {
\       'left': [['buffers']],
\       'right': [[]]
\ },
\ 'active': {
\       'left': [
\                       ['mode', 'paste'],
\                       ['readonly', 'filename', 'modified']
\               ],
\       'right': [
\                       ['lineinfo'],
\                       ['percent'],
\                       ['fileformat', 'fileencoding', 'filetype']
\               ]
\ },
\ 'component_expand': {
\       'buffers': 'lightline#bufferline#buffers'
\ },
\ 'component_type': {
\       'buffers': 'tabsel'
\ }
\}

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:tex_conceal = ""

set guifont="Terminus (TTF)"
