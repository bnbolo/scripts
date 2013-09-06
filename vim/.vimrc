set autoread

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>



set so=7
set wildmenu
set wildignore=*.o,*~,*.pyc
" set ruler
set cmdheight=2
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set fileformat=unix

set guifont=Menlo\ Regular:h14


syntax enable

colorscheme candy
set background=dark

set ffs=mac,unix,dos

set nobackup
set nowb
set noswapfile


set expandtab
set smarttab

set shiftwidth=4
set tabstop=4

set lbr
set tw=500

set ai "Auto indent"
set si "Smart indent"
set wrap "Wrap lines"

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

map j gj
map k gk


map <space> /
map <c-space> ?

map <silent> <leader><cr> :noh<cr>



map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>bd :Bclose<cr>
map <leader>ba :1,1000 bd!<cr>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove


map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

map <leader>cd :cd $:p:h<cr>:pwd<cr>



set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


map 0 ^

nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

set nu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
set mouse=a
"map <2-LeftMouse> *
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>
"imap <2-LeftMouse> <c-o>*


let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_Only_Window = 1

nmap <F2> :WMToggle<cr>
nmap <F3> :TlistToggle<cr>


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
let g:netrw_winsize=30






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
let g:Tlist_Ctags_Cmd = '/opt/local/bin/ctags'
set tags=tags;/



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if has('cscope')
    set csprg=/opt/local/bin/cscope
    set cscopetag cscopeverbose

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help

    command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src

    nmap <leader>css :cs find s <C-R>=expand("<cword>")<CR><CR>  
    nmap <leader>csg :cs find g <C-R>=expand("<cword>")<CR><CR>  
    nmap <leader>csc :cs find c <C-R>=expand("<cword>")<CR><CR>  
    nmap <leader>cst :cs find t <C-R>=expand("<cword>")<CR><CR>  
    nmap <leader>cse :cs find e <C-R>=expand("<cword>")<CR><CR>  
    nmap <leader>csf :cs find f <C-R>=expand("<cfile>")<CR><CR>  
    nmap <leader>csi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>csd :cs find d <C-R>=expand("<cword>")<CR><CR>

    nmap <leader>vcss :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>vcsg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>vcsc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>vcst :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>vcse :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>vcsf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>   
    nmap <leader>vcsi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR> 
    nmap <leader>vcsd :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif

function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " supress 'duplicate connection' error
        exe "cs add " . db 
        set cscopeverbose
    endif
endfunction

au BufEnter /* call LoadCscope()


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

let g:bufExplorerDefaultHelp = 0
let g:bufExplorerDetailedHelp = 0
let g:bufExplorerReverseSort = 1
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSortBy = 'number'
let g:bufExplorerSplitRight = 0
let g:bufExplorerVertSize = 30



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
"let g:winManagerWindowLayout = 'FileExplorer,taglist|bufexplorer'
let g:winManagerWindowLayout = 'FileExplorer,TagList|BufExplorer'
let g:persistentBehaviour = 0
let g:winManagerWidth = 30
let g:defaultExplorer = 1
let g:bufExplorerMaxHeight = 40

