"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"|        Satvik Saha's         |
"|                              |
"|    .vimrc configuation       |
"|                              |
"|                              |
"|                              |
"+==============================+
execute pathogen#infect()



" The basic settings
set nocp
set laststatus=2
set ruler
set number
set relativenumber
set ignorecase
set modeline
set nobackup
set wrap
set hidden
set backspace=indent,eol,start
set incsearch
set spell spelllang=en_gb
set wildmode=full

set listchars=tab:⎸\ 
set list

" Indentation
set tabstop=8
set shiftwidth=8
set softtabstop=8
set expandtab
set autoindent

" IndentLine
let g:indentLine_color_term = 239
let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 1
let g:indentLine_char = '▏'
let g:indentLine_leadingSpaceChar = '·'

set noshowmode
set showtabline=2

" Highlight search
set hlsearch
nnoremap <CR> :noh<CR><CR>

" Syntax highlighting
syntax enable
set encoding=utf-8

" Bracket completion!
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
autocmd Syntax vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
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
                "Inserting a quoted quotation mark into the string
                return a:char
        elseif line[col - 1] == a:char
                "Escaping out of the string
                return "\<Right>"
        else
        "Starting a string
        return a:char.a:char."\<Esc>i"
        endif
endf

" Filetype
filetype plugin on

autocmd Filetype css,html,python,scala setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype perl setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab

" Set a nice Omnifunc - <CTRL>X <CTRL>O
set ofu=syntaxcomplete#Complete


" Set some nice java and gofunctions - <CTRL>X <CTRL>U
autocmd Filetype java set completefunc=javacomplete#Complete
autocmd Filetype go set completefunc=go#complete#Complete
autocmd Filetype html set completefunc=htmlcomplete#CompleteTags

autocmd Filetype java setlocal omnifunc=javacomplete#Complete
autocmd Filetype html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd Filetype python setlocal omnifunc=pythoncomplete#Complete 


" Make javac the build prog - :make
" You MUST start vim from the 'src/' folder. or javac wont work..

" This is the simplest possible make utility

set makeprg=./%
autocmd Filetype java set makeprg=javac\ %
autocmd Filetype cpp set makeprg=c++\ %\ -o\ %:p:h/a.out
autocmd Filetype python set makeprg=python\ %
autocmd Filetype c set makeprg=cc\ %\ -o\ %:p:h/a.out
autocmd Filetype html set makeprg=w3m\ %

map ,. <Esc>:make<Return>

autocmd Filetype plaintex set ft=tex
"autocmd Filetype tex :AcpLock
autocmd Filetype tex noremap ,. <Esc>:w<Return>:Latexmk<Return>
autocmd Filetype tex noremap <> <Esc>:LatexView<Return>

" set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#

" This is a good default one - works for projects without libs
" autocmd Filetype java set makeprg=javac\ -d\ ../build/\ %

" Mapped some FUNCTION keys to be more useful..

"map <F6> :cclose<Return>:!chmod +x % && cd %:p:h && ./%:t<Return>
"autocmd Filetype java map <F6> :cclose<Return>:!time java -cp %:p:h %:t:r %:r<Return>
"autocmd Filetype cpp map <F6> :cclose<Return>:!cd %:p:h && time ./a.out<Return>
"autocmd Filetype c map <F6> :cclose<Return>:!cd %:p:h && time ./a.out<Return>
"autocmd Filetype python map <F6> :cclose<Return>:!time python %<Return>
"autocmd Filetype html map <F6> :cclose<Return>:!w3m %<Return>

"map <F7> :w<Return>:make<Return>:copen<Return><Return>
"map <F8> :cprevious<Return>
"map <F9> :cnext<Return>

" These are useful when using MinBufExpl

let g:miniBufExplMapWindowNavVim    = 1
let g:miniBufExplMapWindowNavArrows = 1

" You can change colors easily in vim. 
" Just type <ESC>:colorscheme and then TAB complete through the options 
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_visibility="low"
let g:solarized_termtrans = 1
colorscheme solarized

" Set the color for the popup menu
highlight Pmenu ctermbg=blue ctermfg=white
highlight PmenuSel ctermbg=blue ctermfg=red
highlight PmenuSbar ctermbg=cyan ctermfg=green
highlight PmenuThumb ctermbg=white ctermfg=red

" DICTIONARY
" The dictionary can pop up a lot of words when you have Auto popup enabled. 
" You can disable auto popup, by removing the acp.vim from your ~/.vim/plugin/
" directory and enable the dictionary here - then use <CTRL>X <CTRL>K to bring
" up the dictionary options. Or just enable it.. :-)
" set dictionary+=~/system/etc/dict/words

" Make vim popup behave more like an IDE POPUP
set completeopt=longest,menuone

" Make enter finish the completion popup menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Auto start NERDTree on startup..
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <C-Up> :NERDTreeToggle<CR>

" TAGLIST setup
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 50

" Remapping keys for splits 

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remapping keys for buffers

nnoremap <C-Left> :bp<CR>
nnoremap <C-Right> :bn<CR>
nnoremap <C-Down> :bd<CR>

map <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q <Return><Return>
" tags
set tags=./tags;

if has("gui_running")
        "C-Space seems to work under gVim on both Linux and win32
        if (&ft == 'html')
                inoremap <C-Space> <C-x><C-o>
        else
                inoremap <C-Space> <C-x><C-u>
        endif
else    "no gui
        if has("unix")
                inoremap <Nul> <C-x><C-o>
        endif
endif

" Some JavaComplete settings

nmap <F3> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F3> <Plug>(JavaComplete-Imports-RemoveUnused)

nmap <F4> <Plug>(JavaComplete-Imports-AddMissing)
imap <F4> <Plug>(JavaComplete-Imports-AddMissing)

" Lightline
let g:lightline = {
\ 'colorscheme'      :    'solarized',
\}
let g:lightline.tabline            = {'left': [['buffers']], 'right': [[]]}
let g:lightline.component_expand   = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type     = {'buffers': 'tabsel'}

let g:tex_conceal = ""

" UntiSnipes
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

set guifont="Fantasque Sans Mono Regular Nerd Font Complete Mono"
