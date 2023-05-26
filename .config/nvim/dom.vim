" inoremap <c-e> <col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

" lua require 'init'
imap jk <esc>
set scrolloff=0
set wrap

" leader key
let mapleader = " "

" pounce.nvim
" nmap <leader>/ <cmd>Pounce<cr>
" nmap <leader>n <cmd>PounceRepeat<cr>
" vmap <leader>/ <cmd>Pounce<cr>
" omap <leader>/ <cmd>Pounce<cr>

" telescope
" nnoremap <leader>y <cmd>Telescope find_files<cr>
" nnoremap <leader>i <cmd>Telescope live_grep<cr>
" nnoremap <leader>b <cmd>Telescope buffers<cr>
" nnoremap <leader>h <cmd>Telescope help_tags<cr>

" nvim-treesitter
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set nofoldenable

" colorscheme
" set printoptions=mber

" colorscheme ghdark
" colorscheme github_light
" colorscheme github_dark

" opts
" set expandtab softtabstop=4 shiftwidth=4
set number
set ignorecase smartcase
" set iskeyword-=_ iskeyword-=
" set iskeyword=a-z,48-57,192-255
" set iskeyword-=_
"

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" set foldmethod=marker foldcolumn=1
set clipboard=unnamed
" set display+=uhex
" set laststatus=0
" set noshowmode
" set cmdheight=0
set cmdwinheight=15

" keymaps
" keymaps-general
nnoremap <Esc> :noh<cr>:
" nnoremap q :q<CR>
nnoremap q :bnext<CR>
nnoremap Q :call g:FnCloseTab()<CR>
" nnoremap U <C-R>
" nnoremap <BS> :E<CR>

" nnoremap j j
nnoremap <down> g<down>
" vnoremap j gj
vnoremap <down> g<down>
" onoremap j gj
" nnoremap k gk
nnoremap <up> g<up>
" vnoremap k gk
vnoremap <up> g<up>
" onoremap k gk

inoremap <down> <C-O>gj
inoremap <up>   <C-O>gk

" keymaps-tabs
nnoremap <C-t> :tabnew<CR>
" nnoremap <C-w> :tabclose<CR>
" nnoremap J :bnext<CR>
" nnoremap T :bnext<CR>
" nnoremap K :bprevious<CR>
" nnoremap H :bprevious<CR>
nnoremap J :BufferLineCycleNext<CR>
nnoremap T :BufferLineCycleNext<CR>
nnoremap K :BufferLineCyclePrev<CR>
nnoremap H :BufferLineCyclePrev<CR>
nnoremap <c-1> :BufferLineGoToBuffer 1<CR>
nnoremap <c-2> :BufferLineGoToBuffer 2<CR>
nnoremap <c-3> :BufferLineGoToBuffer 3<CR>
nnoremap <c-4> :BufferLineGoToBuffer 4<CR>
nnoremap <c-5> :BufferLineGoToBuffer 5<CR>
nnoremap <c-6> :BufferLineGoToBuffer 6<CR>
nnoremap <c-7> :BufferLineGoToBuffer 7<CR>
nnoremap <c-8> :BufferLineGoToBuffer 8<CR>
nnoremap <c-9> :BufferLineGoToBuffer 9<CR>
nnoremap <c-0> :BufferLineGoToBuffer 10<CR>
" keymaps-navigation
nnoremap gg ggM
nnoremap M 50%
" nnoremap j <C-D>
" nnoremap j :lua Scroll('<C-u>', 1, 1)<CR>
" vnoremap j <C-D>
" nnoremap k <C-U>
" vnoremap k <C-U>

" nnoremap t :lua Scroll('<C-d>', 1, 1)<CR>
" nnoremap t <C-D>
" vnoremap t <C-D>
" nnoremap h <C-U>
" vnoremap h <C-U>

" nnoremap <C-c> 10j
" vnoremap <C-c> 10j
" nnoremap <C-v> 10k
" vnoremap <C-v> 10k
" nnoremap m b
" vnoremap m b

" onoremap m b
" nnoremap b m
" vnoremap b m
" onoremap b m


" keymaps-dvorak
" vnoremap t j
" onoremap t j
" nnoremap h k
" vnoremap h k
" nnoremap t j
" onoremap h k

" nnoremap <C-t> t
" vnoremap <C-t> t
" onoremap <C-t> t
" vnoremap <C-S-t> T
" onoremap <C-S-t> T

" " skipping h (and H), just use arrow keys :-D

" nnoremap e d
" vnoremap e d
" onoremap e d
" nnoremap <C-e> e
" nnoremap <C-S-e> E
" nnoremap <C-S-t> T
" vnoremap <C-e> e
" vnoremap <C-S-e> E
" onoremap <C-e> e
" onoremap <C-S-e> E
" nnoremap g<C-e> ge
" nnoremap g<C-S-e> gE
" vnoremap g<C-e> ge
" vnoremap g<C-S-e> gE
" onoremap g<C-e> ge
" onoremap g<C-S-e> gE

" nnoremap <C-e> :echomsg('unshifted e')<CR>
" nnoremap <C-S-e> :echomsg('SHITED E')<CR>

" keymaps mac-terminal-isomorphism
" set <F5>=<C-[>[57344u
"
" inoremap <F35> <left><C-O>:call g:FnDeleteToStartOfLine()<CR>

" inoremap <F35><left><C-O>:call g:FnDeleteToStartOfLine()<CR>
" inoremap <F6> <C-O>d$
" inoremap <F7> <C-O>db
" inoremap <F8> <C-O>de

" ctrl+cmd+up
" ctrl+cmd+down
" from https://vim.fandom.com/wiki/Moving_lines_up_or_down#:~:text=Mappings%20to%20move%20lines,-The%20following%20mappings&text=After%20visually%20selecting%20a%20block,to%20move%20the%20block%20up.
nnoremap <F16> :m .+1<CR>==
nnoremap <F15> :m .-2<CR>==
inoremap <F16> <Esc>:m .+1<CR>==gi
inoremap <F15> <Esc>:m .-2<CR>==gi
vnoremap <F16> :m '>+1<CR>gv=gv
vnoremap <F15> :m '<-2<CR>gv=gv


" cmd+enter
nnoremap <F25> o
inoremap <F25> <C-O>o

" shift+cmd+enter
nnoremap <F26> O
inoremap <F26> <C-O>O

" cmd+z
nnoremap <F27> u
inoremap <F27> <C-O>u
cnoremap <F27> <C-F>ui

" cmd+left
noremap <F28> ^
inoremap <F28> <C-O>^
cnoremap <F28> <HOME>

" C-A
inoremap <c-a> <C-O>^
cnoremap <c-a> <HOME>
cnoremap <c-x> <c-a

" cmd+right
noremap <F29> $
inoremap <F29> <C-O>$
cnoremap <F29> <END>

" C-E
inoremap <c-e> <C-O>$
cnoremap <c-e> <END>

" cmd+backspace
nnoremap <F30> d^i
inoremap <F30> <C-O>:call g:FnGetColInInsert()<CR><esc>:call g:FnGetColInNormal()<CR>:call g:FnDeleteToStartOfLine()<CR>i
cnoremap <F30> <C-F>d^i

" cmd+delete
nnoremap <F31> d$i
inoremap <F31> <C-O>:call g:FnGetColInInsert()<CR><esc>:call g:FnGetColInNormal()<CR>:call g:FnDeleteToEndOfLine()<CR>a
cnoremap <F31> <C-F>d$i

" alt+left
noremap <F32> b
inoremap <F32> <C-O>b
cnoremap <F32> <c-left>

" alt+right
noremap <F33> e
inoremap <F33> <C-O>e<right>
cnoremap <F33> <c-right>

" alt+backspace
nnoremap <F34> dbi
inoremap <F34> <esc>:call g:FnGetColInInsert()<CR>:call g:FnGetColInNormal()<CR>:call g:FnDeleteToStartOfWord()<CR>
" cnoremap <F34> <C-F>dbi
cnoremap <F34> <C-W>

" alt+delete
nnoremap <F35> dei
inoremap <F35> <C-O>:call g:FnGetColInInsert()<CR><esc>:call g:FnGetColInNormal()<CR>:call g:FnDeleteToEndOfWord()<CR>a
cnoremap <F35> <C-F>dei

inoremap <C-S-Y> <C-O>:call g:FnGetColInInsert()<CR><esc>:call g:FnGetColInNormal()<CR>:call g:FnInsertFromLineAbove()<CR>a
inoremap <C-S-E> <C-O>:call g:FnGetColInInsert()<CR><esc>:call g:FnGetColInNormal()<CR>:call g:FnInsertFromLineBelow()<CR>a

" cmd+ctrl+left/down
vmap <F26> <A-k>
vmap <F27> <A-j>
" nnoremap <C-[>[57344u j

" nnoremap <c-d> 
" nnoremap Q q
" nnoremap <BS> :e#<CR>
nmap <BS> <c-o>
nmap <del> <c-i>

" variables
" let g:help_in_tabs = 1

nmap s  <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S  <plug>(SubversiveSubstituteToEndOfLine)


" functions
function g:FnInsertFromLineAbove()
    if g:dom_cache_col_insert == 1
        \ && g:dom_cache_col_normal == 1
        \ && strlen(getline('.')) == 0
            norm! ky$jp
    else
        norm! kly$jp
    endif
endfunction

function g:FnInsertFromLineBelow()
    if g:dom_cache_col_insert == 1
        \ && g:dom_cache_col_normal == 1
        \ && strlen(getline('.')) == 0
            norm! jy$kp
    else
        norm! jly$kp
    endif
endfunction


" functions
function g:FnGetColInInsert()
    let g:dom_cache_col_insert = col('.')
endfunction

function g:FnGetColInNormal()
    let g:dom_cache_col_normal = col('.')
endfunction

function g:FnDeleteToStartOfLine()
    if g:dom_cache_col_insert == 1 && g:dom_cache_col_normal == 1
    else    
      " need to handle if line contains only spaces, delete entire line
        norm! dv^
    endif
endfunction

function g:FnDeleteToEndOfLine()
    if g:dom_cache_col_insert == 1 && g:dom_cache_col_normal == 1
    else    
        norm! ld$
    endif
endfunction

function g:FnDeleteToStartOfWord()
    if g:dom_cache_col_insert == 1 && g:dom_cache_col_normal == 1
    else
        if col('.') == strlen(getline("."))
            norm! dvb
            startinsert
            " norm! <right>
            call feedkeys("\<right>", 'n')
        else
            norm! dvb
            startinsert
        endif
    endif
endfunction

function g:FnDeleteToEndOfWord()
    if g:dom_cache_col_insert == 1 && g:dom_cache_col_normal == 1
    else    
        norm! ldellll
    endif
endfunction

" abc def

" function g:FnDeleteToStartOfWork

"Only apply to .txt files...
function g:FnWriteIfFileIsNamed()
    " the second one was fing up command line window
    " the third one was fing up `gd [commit] --tool nvimdiff`
    if @% == "" || &buftype != "" || &readonly
    else
            silent write
    endif
endfunction

function g:FnCloseTab()
    if tabpagenr() == 1
            qa
    else
            tabclose
    endif
endfunction

"Only apply to help files...
function! g:FnHelpInNewTab ()
if &filetype == 'help' && g:help_in_tabs
    "Convert the help window to a tab...
    "silent execute "normal \<C-w>T
    wincmd T
            "  normal! zz
            call timer_start(0, {-> feedkeys("zz", "n")})
            set number
endif
endfunction


function g:FnZzIfOnFirstLine()
    if line('w0') || line('.') == 1
        exe "normal! M"
    endif
endfunction

function g:FnNoSplit()
    exe "normal \<C-w>l"
exe "normal \<C-w>c"
    set nosplitright
    set noscrollbind
endfunction

function! g:FnNetrwMapping()
noremap <buffer> t j
noremap <buffer> h k
endfunction

" commands
command Spaces2 set softtabstop=2 shiftwidth=2
command Spaces4 set softtabstop=4 shiftwidth=4
command SplitAndScrollBind call g:FnSplitAndScrollBind()
command NoSplit call g:FnNoSplit()
command CopyFilePath !echo %:p | c

command Dvorak set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,aa,os,ed,if,ug,dh,tj,hk,nl,s:,:z,qx,jc,kv,xb,mm,w\\,,v.,z\\/,\\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,AA,OS,ED,IF,UG,DH,TJ,HK,NL,S\\;,\\;Z,QX,JC,KV,XB,BN,MM,W<,V>,Z?

command DvorakMacKb set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,aa,os,ed,if,ug,dh,tj,hk,nl,s:,qy,jx,kc,xv,bn,mm,w\\,,v.,z\\/,\\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,AA,OS,ED,IF,UG,DH,TJ,HK,NL,S\\;,QY,JX,KC,XV,BN,MM,W<,V>,Z?

command NoDvorak set langmap=

command Ps PackerSync

" autocmds
" au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

autocmd TextChanged,TextChangedI * call g:FnWriteIfFileIsNamed()

augroup AuCenter
    autocmd!
    autocmd CursorMoved * normal! zz
augroup END

" augroup AuSplit
    " autocmd!
" autocmd BufReadPost * if &filetype != 'help' | call g:FnSplitAndScrollBind() | endif
" autocmd BufReadPost * if tabpagewinnr(tabpagenr(), '$') == 1 && winwidth('%') > 150  | call g:FnSplitAndScrollBind() | endif
" augroup END

augroup AuHelpInTabs
    autocmd!
    " autocmd CursorMoved *.txt call g:FnHelpInNewTab() 
augroup END

augroup AuNetrwMapping
    " https://vi.stackexchange.com/a/5532
    autocmd!
    autocmd filetype netrw call g:FnNetrwMapping()
augroup END

if has("persistent_undo")
    set undofile
endif

" init
" DvorakMacKb
" function g:FnInsertFromLineAbove()
"     if g:dom_cache_col_insert == 1
"         \ && g:dom_cache_col_normal == 1
"         \ && strlen(getline('.')) == 0
"             norm! ky$jp
"     else
"         norm! kly$jp
"     endif
" endfunctin

function g:FnSplitAndScrollBind()
    " echomsg "split and scroll bind"
    set nosplitright 
    set noscrollbind 
    " exe "normal! bs"
    " exe "normal! ggMzz"
    " echomsg "1" winnr()
    " echomsg "1" winnr('$')
    vspl 
    " echomsg "2" winnr()
    " echomsg "2" winnr('$')
    " exe "normal! zz"
    " setlocal scrollbind
    set scrollbind
    " exe "normal! \<C-w>lzz"
    wincmd w
    exe "normal! \<C-f>"
    set scrollbind
    " echomsg "3" winnr()
    " echomsg "3" winnr('$')
    " exe "normal! Lzz"
    " exe "normal! Lzz"
    " setlocal scrollbind 
    " echomsg "3.5" winnr()
    " echomsg "3.5" winnr('$')
    " exe "normal! \<C-w>hzz"
    wincmd w
    " exe "normal! zz"
    " echomsg "4" winnr() 
    " echomsg "4" winnr('$')
    " exe "normal! :silent `szz"
    " call timer_start(1000, {-> g:FnZzIfOnFirstLine()})
    " if line('w0') == 1
    "     exe "normal! Mzz"
    " endif
endfunction

function g:Split()
    echomsg(line('.'))
    " echomsg('only called')
    " print(vim.ob)
    " if vim.ob then
    "     local ft = vim.bo.filetype
    "     print(vim.ob.filetype)
    "     if ft ~= 'dashboard' and ft ~= 'telescope' then
    "         print('only if block')
    "         vim.cmd('only')
    "         local fn = 'g:FnSplitAndScrollBind'
    "         vim.cmd('call ' .. fn .. '()')
    "     end
    " end
    " local ft = &filetype
    " if ft ==# 'dashboard' && ft ==# 'telescope'
    " echomsg('buftype')
    " echomsg(&buftype)
    " echomsg('filetype')
    " echomsg(&filetype)
    " echomsg @%
    " echomsg winwidth('%')
    if @% != "" && &buftype == '' && winwidth('%') >= 100 && ( &filetype ==# 'python' ||  &filetype ==# 'zsh' || &filetype ==# 'vim' || &filetype ==# 'lua' || &filetype ==# 'solidity')
        if winnr('$') > 1 
            exe "only"
        endif
    endif
    if @% != "" && &buftype == '' && winwidth('%') >= 200 && ( &filetype ==# 'python' ||  &filetype ==# 'zsh' || &filetype ==# 'vim' || &filetype ==# 'lua' || &filetype ==# 'solidity')

        " echomsg('winnr')
        " echomsg(winnr('$'))

        " echomsg('only if block')
        if winnr('$') == 1
           call g:FnSplitAndScrollBind()
        endif
        " echomsg "5" winnr()
        " exe "normal! \<C-w>h"
        " wincmd h
        " call timer_start(1000, {-> feedkeys("<C-w>h")})
        " call timer_start(500, {-> g:FnEcho()})
        " echomsg "6" winnr()
        " call timer_start(0, {-> g:FnZzIfOnFirstLine()})
        vertical resize +10
        " call timer_start(0, {-> g:FnCall()})
    endif
endfunction


" vim.api.nvim_create_autocmd('BufWinEnter', { callback = Only })
"

function! s:Log(eventName) abort
  silent execute '!echo '.a:eventName.' >> log'
endfunction

" autocmd BufWinLeave * exe "only
"
function g:FnCall()
    wincmd h
endfunction

augroup AuSplit
    autocmd!
    " autocmd BufWinEnter * call g:Split()
    " Uncomment this for DomSpit
    " autocmd BufWinEnter * if !g:lock | call g:Split() | endif
    " autocmd BufWinEnter * if !g:lock | :SymbolsOutline<CR> | endif
    " autocmd BufWinEnter * SymbolsOutline
augroup END

" autocmd BufWinEnter * norm! M

let g:lock = 0

command Lock let g:lock = 1 | bufdo set noscrollbind | setglobal noscrollbind

command Unlock let g:lock = 0
" print('hello world')

" vnoremap J joko
" vnoremap K kojo

" nnoremap <leader>? gccyypgcc
" nnoremap <leader>? 
" lockmarks lua require('Comment.api').toggle.linewise.current()
nnoremap M :call cursor(0, len(getline('.'))/2)<CR>

nnoremap <M-b> w

" from https://github.com/svermeulen/vim-cutlass
nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D
" end from vim-cutlass

nnoremap M m
set norelativenumber
" colorscheme astrodark

" inoremap <C-Up> <C-O>10<C-Y>
" inoremap <C-Down> <C-O><C-E>
set runtimepath+=/Users/dteiml/.local/bin
lua vim.env.PATH = '/Users/dteiml/.local/bin:' .. vim.env.PATH

" see https://stackoverflow.com/questions/3806629/yank-a-region-in-vim-without-the-cursor-moving-to-the-top-of-the-block#comment10788861_3806683
:vmap y ygv<Esc>
nmap gC gccyypgcc
vmap gC ygvgcgv<esc>p
omap     <silent> n :<C-U>lua require('tsht').nodes()<CR>
" xunmap n
xnoremap <silent> n :lua require('tsht').nodes()<CR>
vunmap n
vnoremap <silent> n :lua require('tsht').nodes()<CR>
" :set formatoptions-=cro

" nmap <M-e> :lua print('hiii')
nmap <A-e> :
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

nmap M [m
nmap W ]m
