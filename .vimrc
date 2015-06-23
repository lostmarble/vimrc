"platform
function! MySys()
    return "linux"
endfunction

set autochdir "auto change the dir to the current dir

"--omnicppcomplete setting --
set nocp
"
"



"enable filetype plugin 
filetype plugin on
filetype indent on

"set auto read when a file is changed from the outside
set autoread

"with a map leader it's possible to do extra key combinations 
"like<leader>w saves the current file
let mapleader=";"
let g:mapleader=";"

" Fast saving
nmap <leader> w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

""""""""""""""""""""""""""""""""""""""""""""""""
"=> vim user interface
""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu "Turn on wildmenu
set ruler "always show current position
set hid "change buffer - without saving

" set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like in modern browsers
set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on. for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

"No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


set sm

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Colors and Fonts
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
if MySys() == "mac"
	set gfn=Menlo:h14
    "set shell=/bin/bash
elseif MySys() == "windows"
	set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
	set gfn=Monospace\ 10
	"set shell=/bin/shell
endif

set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>Files, backups and undo
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway....
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Text, tab and indent related
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => moving around, tabs and buffers
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" smart way to move btw windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Close the current buffer
map <leader>bd :Bclose<cr>

"use the arrows to something useful!
map <right> :bn<cr>
map <left> :bp<cr>


""""""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

""""""""""""""""""""""""""""""""
"=> General abbrevs
""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

let OmniCpp_DefaultNamespaces=["std"]
set completeopt=menu,menuone
let OmniCpp_MayCompleteDot=1"autocomplete with.
let OmniCpp_MayCompleteArrow=1"autocomplete with->
let OmniCpp_MayCompleteScope=1"autocomplete with->
let OmniCpp_SelectFirstItem =2"select first item(but don't insert)
let OmniCpp_NamespaceSearch=2"search namespace in this and included files
let OmniCpp_ShowPrototypeInAbbr=1"show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_DisplayMode=1
let OmniCpp_DefaultNamespaces=["std"]

set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set encoding=utf-8
set nu
set ai
"setl fdm=syntax
syntax on
set si
set ruler
set showmatch
set incsearch
filetype on

"taglist
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1 
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
"let Tlist_Auto_Open = 1
let Tlist_Close_On_Select = 1
"minibufexploer
let g:miniBufExplMapCTabSwitchBufs = 1

"let g:winManagerWindowLayout='FileExplorer|TagList'
nmap <F12> :WMToggle<cr>
nmap <F9> :TlistToggle<cr>
nmap <F5> :make<cr>


"neocomplcache-5.3
let g:neocomplcache_enable_at_startup=1
let g:SuperTabRetainCompletionType="contex"

"autocmd BufNewFile *.[ch],*.hpp,*.cpp exec ":call SetTitle()"
"add the header
func SetComment()
	call setline(1,"/*===============================================")
	call append(line("."),"* Copyright (C) ".strftime("%Y")." All rights reserved.")
	call append(line(".")+1,"* ")
	call append(line(".")+2,"* filename:".expand("%:t"))
	call append(line(".")+3,"* author: xzx")
	call append(line(".")+4,"* create date:".strftime("%Y.%m.%d"))
	call append(line(".")+5,"* description: ")
	call append(line(".")+6,"* ")
	call append(line(".")+7,"*===============================================*/")
endfunc

func SetTitle()
	call SetComment()
	if expand("%:e") == 'hpp'
		call append(line(".")+8,"#ifndef _".toupper(expand("%:t:r"))."_H")
		call append(line(".")+9,"#define _".toupper(expand("%:t:r"))."_H")
		call append(line(".")+10,"#ifdef __cplusplus")
		call append(line(".")+11,"#ifdef extern \"C\"")
		call append(line(".")+12,"{")
		call append(line(".")+13,"#endif")
		call append(line(".")+14,"")
		call append(line(".")+15,"#ifdef __cplusplus")
		call append(line(".")+16,"}")
		call append(line(".")+17,"#endif")
		call append(line(".")+18,"#endif //".toupper(expand("%:t:r"))."_H")
	elseif expand("%:e") == 'h'
		call append(line(".")+8,"#pragma once")
	elseif &filetype == 'c'
		call append(line(".")+8,"#include \"".expand("%:t:r").".h\"")
	elseif &filetype == 'cpp'
		call append(line(".")+8,"#include \"".expand("%:t:r").".h\"")
	endif
endfunc



	


" indent_guides_guide
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=1
let Tlist_Ctags_Cmd = '/usr/bin/ctags'

" DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre="@Synopsis   "
let g:DoxygenToolkit_paramTag_pre="@Param    "

let g:DoxygenToolkit_returnTag="@Returns   " 
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_authorName="xuzuoxin@ict.ac.cn" 
let s:licenseTag="Copyright(C)\<enter>"
let s:licenseTag=s:licenseTag."All right reserved\<enter>"
let g:DoxygenToolkit_licenseTag=s:licenseTag
let g:doxygen_enhanced_color=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>



"Comment color
hi Comment ctermfg = gray
