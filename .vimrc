set cursorline		"突出显示当前行
set number			"显示行号
set noexpandtab		"插入tab符号不以空格替换
set autoindent		"开启自动缩进
set tabstop=4		"设定tab长度
set smartindent		"开启新行时时哟功能智能自动缩进
set smarttab		"开启新行时使用智能tab缩进
set shiftwidth=4	"设定<<和>>命令移动时的宽度为4
set showmatch		"插入括号时，短暂地跳转到匹配第对应括号
set backspace=indent,eol,start	"不设定载插入状态无法用退格键和Delete键删除回车符
set guioptions=t	"隐藏菜单栏、工具栏、滚动条
set ruler			"打开状态栏标尺
set incsearch		"输入搜索内容时就显示搜索结果
set hlsearch		"搜索时高亮显示被找到的文本
set ignorecase		"搜索时忽略大小写
set fileencoding=utf-8	"文件默认编码
set fileencodings=utf-8,ucs-bom,cp936,gb2312,gbk,gb18030,big5,euc-jp,euc-kr,latin1 "检测编码顺序
set shortmess=atI	" 启动的时候不显示那个援助索马里儿童的提示
colorscheme desert	"配色方案
syntax on			"自动语法高亮
filetype  plugin indent on
behave mswin		" 鼠标使用微软习惯，支持右键菜单

"-----------------------------------------------------------------
" Omni Complete 自动补全
"-----------------------------------------------------------------
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby set omnifunc=rubycomplete#Completeruby
autocmd FileType sql set omnifunc=sqlcomplete#Completesql

au GUIEnter * simalt ~x

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

" 用空格键来开关折叠
set foldenable
set foldmethod=manual
nnoremap  @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')

"-----------------------------------------------------------------
" F2 工具栏和菜单栏交替切换
"-----------------------------------------------------------------
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
\set guioptions-=T <Bar>
\set guioptions-=m <bar>
\else <Bar>
\set guioptions+=T <Bar>
\set guioptions+=m <Bar>
\endif<CR>

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
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>

"-----------------------------------------------------------------
" plugin - zencoding.vim 快速生成 HTML代码
" CTRL+E 展开 zencoding 代码片段
"-----------------------------------------------------------------
let g:user_zen_expandabbr_key = '<c-e>'
let g:use_zen_complete_tag = 1

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


"-----------------LaTeX---------------------------------
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
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
"生成pdf而非dvi
let g:Tex_DefaultTargetFormat = 'pdf'
"使用xelatex编译，参数保证正反向搜索
let g:Tex_CompileRule_pdf = 'xelatex -src-specials -synctex=1 -interaction=nonstopmode $*'
 "设置反向搜索
 let g:Tex_ViewRule_pdf = 'acroread'
 let g:Tex_UseEditorSettingInDVIViewer = 1
 "useful?
 let g:Tex_UseMakefile = 0
