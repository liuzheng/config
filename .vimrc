"http://xineohpanihc.iteye.com/blog/1146946
"--------------------------------------------------------------
"General
"--------------------------------------------------------------
set nocompatible    "vi 兼容模式
set cursorline		"突出显示当前行
set number			"显示行号
set expandtab		"插入tab符号以空格替换
set autoindent		"开启自动缩进
set tabstop=4		"设定tab长度
set smartindent		"开启新行时使用智能自动缩进
set smarttab		"开启新行时使用智能tab缩进
set shiftwidth=4	"设定<<和>>命令移动时的宽度为4
set backspace=indent,eol,start	"不设定载插入状态无法用退格键和Delete键删除回车符
set guioptions=t	"隐藏菜单栏、工具栏、滚动条
set ruler			"打开状态栏标尺
set incsearch		"输入搜索内容时就显示搜索结果
set hlsearch		"搜索时高亮显示被找到的文本
set ignorecase		"搜索时忽略大小写
set smartcase       " 有一个或以上大写字母时仍大小写敏感 
set enc=utf8	"文件默认编码
set fileencodings=utf-8,ucs-bom,cp936,gb2312,gbk,gb18030,big5,euc-jp,euc-kr,latin1 "检测编码顺序
language messages en_US" 设定菜单语言
set showmatch		"高亮匹配的括号
set matchtime=5		"匹配括号高亮的时间（单位时十分之一秒）
set softtabstop=4
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$	"输入:set list命令是应该显示些啥？
"set completeopt+=longest    " 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set shortmess=atI	" 启动的时候不显示那个援助索马里儿童的提示
"colorscheme desert	"配色方案
syntax enable       " 开启语法高亮
syntax on			"自动语法高亮
filetype on         " 检测文件类型
filetype indent on    " 允许插件
filetype plugin indent on " 启动自动补全
set ambiwidth=double    " 中文引号显示
set showcmd         " 显示输入的命令
behave mswin		" 鼠标使用微软习惯，支持右键菜单
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
set mouse=a         " 启用鼠标 
set history=1000    " history存储长度
"set paste           " 粘贴时保持格式
set nocompatible    " 非兼容vi模式。去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set autoread        " 文件修改之后自动载入
"set nobackup       " 取消自动备份
"set nowb           " 取消自动备份
"set noswapcile     " 取消自动备份
set ai              "Auto indent
set si              "Smart indent
set formatoptions+=m " 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=B " 合并两行中文时，不在中间加空格
"这个是我喜欢的，一旦一行的字符超出80个的话就把那些字符的背景设为红色
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
set guifont=Monaco:h15


"Format the statusline
"Nice statusbar
set laststatus=2
set statusline=
set statusline+=%0*%-3.3n\ " buffer number
set statusline+=%3*%f\ " file name
set statusline+=%h%2*%M%r%w " flag
set statusline+=%0*[
if v:version >= 600
    set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
    set statusline+=%{&encoding}, " encoding
endif
set statusline+=%{&fileformat}] " file format
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()} " vim buddy
endif
set statusline+=%2*\ %-16{strftime(\"%Y-%m-%d\ %H:%M\")}\ 
set statusline+=%0*%= " right align
"set statusline+=%2*0x%-8B\ " current char
set statusline+=0x%-8B\ " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset 
"--------------------------------------------------------------
" 配色
"--------------------------------------------------------------
"hi User1 ctermfg=black  ctermbg=white " guifg=black guimbg=white
"hi User2 ctermfg=red    "ctermbg=white " guifg=red   guimbg=white
"hi User3 ctermfg=green  "ctermbg=white " guifg=green guimbg=white
"hi User4 ctermfg=red    ctermbg=green " guifg=red   guimbg=green
"hi User5 ctermfg=red    ctermbg=green " guifg=red   guimbg=green
"hi User5 guifg=#002600  guibg=#67ab6e   gui=italic

if has('gui_running')
  set background=dark 
else
  set background=dark
endif
colorscheme solarized


"-----------------------------------------------------------------
" Omni Complete 自动补全
"-----------------------------------------------------------------
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType cl set omnifunc=ccomplete#Complete
autocmd FileType cu set omnifunc=ccomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby set omnifunc=rubycomplete#Completeruby
autocmd FileType sql set omnifunc=sqlcomplete#Completesql
autocmd FileType matlab     :source ~/config/setup/matlab.vim     "Matlab mode"     <CR>
"-----------------------------------------------------------------
" 自动载入样例文件
"-----------------------------------------------------------------
autocmd BufNewFile *.m      0r ~/config/simple/simple.m
autocmd BufNewFile *.py     0r ~/config/simple/simple.py
autocmd BufNewFile *.tex    0r ~/config/simple/simple.tex
autocmd BufNewFile *.cl    0r ~/config/simple/simple.cl
autocmd BufNewFile *.cu    0r ~/config/simple/simple.cu
autocmd BufNewFile *.sh    0r ~/config/simple/simple.sh
autocmd BufNewFile *.htm   0r ~/config/simple/simple.html
autocmd BufNewFile *.html   0r ~/config/simple/simple.html

au GUIEnter * simalt ~x

"-----------------powerful command complete---------------------------
set wildmenu                       " 命令行补全使用增强模式
set wildmode=list:longest          " 补全时显示样式为多行
set wildignore+=.hg,.git,.svn                    " 版本控制
set wildignore+=*.pyc                            " Python 字节码
set wildignore+=*.sw?                            " Vim 交换文件
set wildignore+=*.aux,*.out,*.toc                " LaTeX 文件
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " 二进制图像
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " 已编译的对象文件
set wildignore+=*.luac                           " Lua 字节码
set wildignore+=*.DS_Store                       " OSX 糟糕物
"-----------------powerful command complete end------------------------

" 用空格键来开关折叠 默认不折叠
set foldenable
set foldmethod=syntax
nnoremap  @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')
set foldlevel=99

"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
 
"上下左右键的行为
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" :"\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" :"\<PageUp>"
map <Esc>[A <Up>
map <Esc>[B <Down>
map <Esc>[C <Right>
map <Esc>[D <Left>

" 括号及引号自动补全
inoremap ) (  )<Esc>hi
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap } {<ESC>o}<ESC>i
inoremap [ []<Esc>i
inoremap ] []<Esc>i
inoremap < <><Esc>i
inoremap > </><Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i

"<C-A>全选，<C-C>复制，<C-X>剪切
map <C-c> y
map <C-X> d
map <C-A> <Esc>ggVG

cmap Q q!<CR>

" omnicomplete configure 
set completeopt=menu,longest,preview

" clang_complete
let g:clang_complete_copen=1
let g:clang_periodic_quickfix=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_use_library=1
let g:clang_user_options='-stdlib=libc++ -std=c++11 -IIncludePath'
let g:neocomplcache_enable_at_startup = 1

""calendar
let g:calendar_diary="~/.diary"
map ca :Calendar<CR>

"-----------------------------------------------------------------
" TagList
"-----------------------------------------------------------------
let Tlist_Auto_Highlight_Tag=1  
let Tlist_Auto_Open=1  
let Tlist_Auto_Update=1  
let Tlist_Display_Tag_Scope=1  
let Tlist_Exit_OnlyWindow=1  
let Tlist_Enable_Dold_Column=1  
let Tlist_File_Fold_Auto_Close=1  
let Tlist_Show_One_File=1  
let Tlist_Use_Right_Window=1  
let Tlist_Use_SingleClick=1 
nnoremap <silent> <F8> :TlistToggle<CR>

"-----------------------------------------------------------------
" F1....
"-----------------------------------------------------------------

"-----------------------------------------------------------------
" F2 工具栏和菜单栏交替切换
"-----------------------------------------------------------------
"map <silent> <F2> :if &guioptions =~# 'T' <Bar>
"\set guioptions-=T <Bar>
"\set guioptions-=m <bar>
"\else <Bar>
"\set guioptions+=T <Bar>
"\set guioptions+=m <Bar>
"\endif<CR>

"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" :NERDtree 打开NERD_tree         :NERDtreeClose    关闭NERD_tree
" o 打开关闭文件或者目录         t 在标签页中打开
" T 在后台标签页中打开           ! 执行此文件
" p 到上层目录                   P 到根目录
" K 到第一个节点                 J 到最后一个节点
" u 打开上层目录                 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录             R 递归刷新当前根目录
"-----------------------------------------------------------------
" F3 NERDTree 切换
"-----------------------------------------------------------------
map <F2> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>

"-----------------------------------------------------------------
" F4  管理代码折叠
"-----------------------------------------------------------------
map <F4> za

"-----------------------------------------------------------------
" F6 打开当前目录文件列表
"-----------------------------------------------------------------
map <F6> :e .<CR>


"-----------------------------------------------------------------
"Ctrl+Q 智能补全
"-----------------------------------------------------------------
inoremap <C-q> <C-x><C-o>
"
"
"-----------------------------------------------------------------
" F9 Ctags
"-----------------------------------------------------------------
map <C-F9> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 
"-----------------------------------------------------------------
" plugin - zencoding.vim 快速生成 HTML代码
" CTRL+E 展开 zencoding 代码片段
"-----------------------------------------------------------------
"let g:user_zen_expandabbr_key = '<c-e>'
"let g:use_zen_complete_tag = 1

"-----------------------------------------------------------------
" plugin - NERD_commenter.vim 注释代码用的
" [count],cc 光标以下count行逐行添加注释(7,cc)
" [count],cu 光标以下count行逐行取消注释(7,cu)
" [count],cm 光标以下count行尝试添加块注释(7,cm)
" ,cA 在行尾插入 /* */,并且进入插入模式。 这个命令方便写注释
" 注：count参数可选，无则默认为选中行或当前行
"-----------------------------------------------------------------
let NERDSpaceDelims=1       " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1   " 多行注释时样子更好看


"-------language en--------------------LaTeX---------------------------------
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

map <F8> :call RunTeX()<CR>
func! RunTeX()
    exec "w"
    exec "!xelatex %<"
endfunc


map <F9> :call Showpdf()<CR>
func! Showpdf()
    exec "!evince %:r.pdf &"
endfunc
"--------------------------LaTeX End-------------------------------------

"-------------------------pathogen--------------------------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
Helptags
" for windows update
set nocp
"-----------------------pathogen end------------------------------

"-----------------------powerline---------------------------------
"let g:Powerline_symbols = 'fancy'
" Because Im using Monaco font , so the fancy didnt suit for me 
"set fillchars+=stl: ,stlnc:
set nocompatible
set t_Co=256
let g:Powerline_cache_enabled = 1
let g:Powerline_cache_file='/Users/liuzheng/.vim/bundle/powerline/Powerline.cache'
set laststatus=2   " Always show the statusline 
"-----------------------powerline end-----------------------------

"------------------- The matlab Connection -----------------------
"nnoremap <F5> :call MatlabRun()<CR><CR>
"nnoremap <S-F6> :call RunMatlab()<CR><CR>

"function! MatlabRun()
"  execute "w"
"  execute "!matlab-ctrl.py \"". expand("%:r") . "\""
"endfunction

"function! RunMatlab()
"  execute "w"
"  call system("matlab-launch.sh \"" . expand("%:r") . "\"")
"endfunction
"------------------- End matlab Connection -----------------------


"------------------- JavaComplete --------------------------------
setlocal omnifunc=javacomplete#Complete
autocmd Filetype java set omnifunc=javacomplete#Complete
"autocmd Filetype java set completefunc=javacomplete#CompleteParamsInf
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P> 
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P> 
autocmd Filetype java,jsp inoremap .  .<C-X><C-O>

"-----------------JavaBrowser------------------------------------
let JavaBrowser_Ctags_Cmd = '/usr/bin/ctags'
let JavaBrowser_Inc_Winwidth = 0
map <F12> :JavaBrowser<CR>
imap <F12> <ESC><F12>

"-----------------Python-----------------------------------------
let g:pydiction_location='/home/liuzheng/.vim/bundle/Pydiction/complete-dict'
"let g:pydiction_menu_height = 20
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79

"-----------------Jedi-------------------------------------------
"let g:jedi#use_tabs_not_buffers = 0

"-----------------vim-tmux---------------------------------------
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previoust-Mapping} :TmuxNavigatePrevious<cr>


"-----------------vim-gundo---------------------------------------
map <F7> :GundoToggle<CR>

"highlight Normal ctermfg=black ctermbg=180
