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

let mapleader = ','

" Statusline and ruler
set ruler
set rulerformat=%42(%=%#Statusline#%<%t%r%m%#Normal#%14(%l/%L:%v%)%)

set laststatus=0
set statusline=%=%#Statusline#%<%t%r%m%#Normal#%14(%l/%L:%v%)

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
let g:indentLine_concealcursor=0
let g:indentLine_conceallevel = 1

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
        autocmd Filetype css,html,javascript,markdown,python,scala setlocal tabstop=4 softtabstop=4 shiftwidth=4
        autocmd Filetype java,c,cpp,go setlocal signcolumn=yes
        autocmd Filetype perl setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd FileType make setlocal noexpandtab

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
        autocmd Filetype html setlocal makeprg=w3m\ %
augroup END

map ,. <Esc>:make<Return>

augroup tex_commands
        autocmd!
        autocmd Filetype tex noremap ,. <Esc>:LatexView<Return>
        autocmd Filetype tex noremap <> :autocmd TextChanged,TextChangedI <buffer> silent write<Return>
augroup END

" Colorscheme
let base16colorspace=256
colorscheme base16-tomorrow-night

" Spellcheck
highlight clear SpellBad
highlight SpellBad cterm=underline gui=underline
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

" YouCompleteMe
let g:ycm_error_symbol = '!!'
let g:ycm_warning_symbol = '??'
let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'text': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'leaderf': 1,
      \ 'mail': 1,
      \ 'css': 1,
      \ 'html': 1
      \}
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_confirm_extra_conf=0
nnoremap <leader>r :YcmCompleter RefactorRename
nnoremap <leader>f :YcmCompleter FixIt<CR>

" Emmet
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Latex
let g:tex_conceal = ""
let g:LatexBox_viewer = "open -a Skim"
let g:LatexBox_latexmk_preview_continuously=1
let g:LatexBox_quickfix=2
