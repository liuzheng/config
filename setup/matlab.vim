" Ken Shan's Matlab mode vimrc file <ken@digitas.harvard.edu>
" $Id: matlab.vim,v 1.2 2003/01/21 03:52:42 mperrin Exp $

" Basic settings
set tabstop=8 textwidth=80
set formatoptions=crq2
set comments=b:%,b:%%
set nocindent noautoindent smartindent
set cinwords=if,else,elseif,for,while,case,otherwise
set noignorecase smarttab expandtab nolinebreak

" Do not outdent lines starting with #
inoremap # X<BS>#

" `- in visual, insert or normal mode: Create documentation block with
" function name under cursor or currently visually selected
imap `- <Esc>`-
nmap `- vw`-
if version >= 500
  nmap `- viw`-
endif
vnoremap `- yo%<C-R>"<Esc>VU0ly$o%   <C-R>"<CR><CR>$Id\$<Esc>3kA 

" `= in normal mode: Create documentation block and function declaration
" based on current file name
nmap `= Ofunction <C-R>%<BS><BS>`-<Esc>1G0
if version >= 500
  nmap `= Ofunction <C-R>=expand("%:t:r")<CR>`-<Esc>1G0
endif

" `/ in insert or normal mode: Move over to % comment at column 41
imap `/ <ESC>`/
nnoremap `/ :set nohlsearch<CR>:s@[ \\t]*\\(% \\=\\(.*\\)\\)\\=$@                                            % \\2@<CR>41\\|dt%A

" `/ in visual mode: Make visual selection into % comment block
vnoremap `/ :s/^\\(    \\\|\\t\\)*/&% /<CR>

" `\ in visual mode: Uncomment visually selected % comment block
vnoremap `\\ :s/^\\(\\(    \\\|\\t\\)*\\)% /\\1<CR>

" `a in insert or normal mode: Type "end" on next line,
" then open new line in between
imap `a <Esc>`a
nnoremap `a :set nosi ai<CR>oend<Esc>:set noai si<CR>O<Tab>

" `[ in insert mode: Outdent and type "else"
inoremap `[ <C-D>else

" `] in insert mode: Outdent and type "end"
inoremap `] <C-D>end

" `<CR> in insert mode: Outdent and type "end" followed by newline
inoremap `<CR> <C-D>end<CR>

" Ctrl-F in insert mode: reindent current line
inoremap <C-F> <ESC>==A

" Syntax highlighting
if has("syntax")
  syntax clear
  source $VIMRUNTIME/syntax/matlab.vim
  syntax keyword matlabLabel    otherwise
  syntax keyword matlabImplicit prod sum reshape
  syntax keyword matlabOperator ones rand
  highlight! link matlabArithmeticOperator matlabDelimiter
  highlight! link matlabRelationalOperator matlabDelimiter
  highlight! link matlabLogicalOperator    matlabDelimiter
  highlight! link matlabTransposeOperator  matlabDelimiter
  highlight! link matlabLineContinuation   Delimiter
endif

" Makefiles
if expand("%:p") =~ "\\(/[Mm]akefile\\|\\.mak$\\)"
  syntax match matlabMakeSpecTarget "^\.SUFFIXES"
  syntax match matlabMakeSpecTarget "^\.PHONY"
  syntax match matlabMakeSpecTarget "^\.DEFAULT"
  syntax match matlabMakeSpecTarget "^\.PRECIOUS"
  syntax match matlabMakeSpecTarget "^\.IGNORE"
  syntax match matlabMakeSpecTarget "^\.SILENT"
  syntax match matlabMakeSpecTarget "^\.EXPORT_ALL_VARIABLES"
  syntax match matlabMakeImplicit "^\.[A-Za-z0-9_]*\.[A-Za-z0-9_]*\s*:[^=]"me=e-2
  syntax match matlabMakeImplicit "^\.[A-Za-z0-9_]*\.[A-Za-z0-9_]*\s*:$"me=e-1
  syntax match matlabMakeTarget "^[A-Za-z0-9_][A-Za-z0-9_./\t ]*:[^=]"me=e-2
  syntax match matlabMakeTarget "^[A-Za-z0-9_][A-Za-z0-9_./\t ]*:$"me=e-1
  syntax match matlabMakeComment "#.*$"
  syntax match matlabMakeNextLine "\\$"
  syntax match matlabMakeInclude "^\s*include"
  syntax match matlabMakeEscapedChar "\\."
  syntax match matlabMakeIdent "\$([^)]*)"
  syntax match matlabMakeIdent "\$\$[A-Za-z0-9_]*"
  syntax match matlabMakeIdent "\$[^({]"
  syntax match matlabMakeIdent "\${[^}]*}"
  syntax match matlabMakeError "^        "
  highlight! link matlabMakeSpecTarget matlabMakeTarget
  highlight! link matlabMakeImplicit matlabMakeTarget
  highlight! link matlabMakeTarget Target
  highlight! link matlabMakeComment Comment
  highlight! link matlabMakeNextLine matlabLineContinuation
  highlight! link matlabMakeInclude Include
  highlight! link matlabMakeEscapedChar Special
  highlight! link matlabMakeIdent Special
  highlight! link matlabMakeError Error
  set noexpandtab
endif

" Clean up when leaving buffer
cnoremap _~DoBufLeave~ <C-U>iunmap `a<CR>:iunmap `-<CR>:nunmap `-<CR>:iunmap `/<CR>:nunmap `/<CR>:vunmap `/<CR>:vunmap `\\\\<CR>:vunmap `-<CR>:iunmap `]<CR>:iunmap \<C-F><CR>:cunmap <C-V>_~DoBufLeave~
