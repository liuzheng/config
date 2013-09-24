### Auto-Pair

1.补全对称的 {, [, ', "等符号

2.自动补空格，当输入{时，你会得到{|},这样的符号

3.中间的|代表光标所在位置(下同,|都代表光标所在位置，不再提醒).然后按空格的时候，会自动在光标两边各加入一个空格，结果就是{ | },而不是{ |}.

3.自动插入新行，输入{|}时，按回车，会自动插入新行，结果会是这样

{

|

}

新行是带正确缩进的。

4.输入时跳过',},]等符号，例如:

在{ | }这种情况下，你输入}的时候，会跳过后面的那个},而不是输入多一个}

5.定位},],例如在

{

|

}

或者 [ | ]这种情况下,输入}或],会跳到匹配的}或]符号后面。

6.快速包装一个单词，如果你已经输入了一个单词word，现在想在外面加入一层括号,就可以在word前先输入一个括号,结果是这样(|)word,然后按alt+e,那么结果就是(word).

### a.vim

A few of quick commands to swtich between source files and header files quickly. 

:A switches to the header file corresponding to the current file being edited (or vise versa) 

:AS splits and switches 

:AV vertical splits and switches 

:AT new tab and switches 

:AN cycles through matches 

:IH switches to file under cursor 

:IHS splits and switches 

:IHV vertical splits and switches 

:IHT new tab and switches 

:IHN cycles through matches 

<Leader>ih switches to file under cursor 

<Leader>is switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp) 

<Leader>ihn cycles through matches 

### calendar

:Calendar

（使用 :CalendarH 命令打开水平的日历窗口）。不过默认 Calendar 存放的文件路径是 ~/diary，可能对于 Windows 用户不适用。如果想更改，在 vimrc 中设置一下 即可：

let g:calendar_diary=<PATH>

建议绑定一个热键随时调出 Calendar，比如我就是这样做的：

map ca :Calendar<cr>

在 normal 模式下按 ca 即可调出 Calendar 

### clang_complete

补全效果非常好,非常准确.但是,也有可能会比较慢

使用之前需要安装clang，sudo apt-get install clang

### c.vim

我比效常用的的操作有(第一列为命令, 第二列为说明, 第三列为该命令所支持的模式(n:普通模式, v:可视模式, i:插入模式):

-- Help -----------------------------------------------

/hm       show manual for word under the cursor(n,i)

/hp       show plugin help                      (n,i)



-- Comments -------------------------------------------

/cl       end-of-line comment                 (n,v,i)

/cj       adjust end-of-line comment(s)      (n,v,i)

/cs       set end-of-line comment column      (n)

/c*       code -> comment /* */               (n,v)

/cc       code -> comment //                  (n,v)

/co       comment -> code                     (n,v)

/cfr      frame comment                       (n,i)

/cfu      function comment                    (n,i)

/cme      method description                  (n,i)

/ccl      class description                  (n,i)

/cd       date                                (n,v,i)

/ct       date /& time                        (n,v,i)



-- Statements ------------------------------------------

/sd       do { } while                        (n,v,i)

/sfo      for { }                            (n,v,i)

/sife     if { } else { }                    (n,v,i)

/se       else { }                            (n,v,i)

/swh      while { }                          (n,v,i)

/ss       switch                              (n,v,i)



-- Preprocessor -----------------------------------------

/p<       #include <>                        (n,i)

/p''      #include ""                        (n,i)

/pd       #define                            (n,i)

/pu       #undef                              (n,i)

/pie      #if  #else #endif                  (n,v,i)

/pid      #ifdef #else #endif                (n,v,i)

/pin      #ifndef #else #endif                (n,v,i)

/pind     #ifndef #def #endif                (n,v,i)

/pi0      #if 0 #endif                        (n,v,i)

/pr0      remove #if 0 #endif                (n,i)

/pe       #error                              (n,i)

/pl       #line                              (n,i)

/pp       #pragma                            (n,i)



-- Idioms ------------------------------------------------

/if       function                            (n,v,i)

/isf      static function                    (n,v,i)

/im       main()                              (n,v,i)

/i0       for( x=0; x<n; x+=1 )              (n,v,i)

/in       for( x=n-1; x>=0; x-=1 )            (n,v,i)

/ie       enum   + typedef                    (n,i)

/is       struct + typedef                    (n,i)

/iu       union  + typedef                    (n,i)

/ip       printf()                            (n,i)

/isc      scanf()                            (n,i)

/ica      p=calloc()                          (n,i)

/ima      p=malloc()                          (n,i)

/isi      sizeof()                            (n,v,i)

/ias      assert()                            (n,v)

/ii       open input file                    (n,i)

/io       open output file                    (n,i)



-- Snippets ------------------------------------------------

/nr       read code snippet                  (n,i)

/nw       write code snippet                  (n,v,i)

/ne       edit code snippet                  (n,i)

/np       pick up prototype                  (n,v,i)

/ni       insert prototype(s)                (n,i)

/nc       clear  prototype(s)                (n,i)

/ns       show   prototype(s)                (n,i)

/ntl      edit local templates                (n,i)

/ntg      edit global templates              (n,i)

/ntr      rebuild templates                  (n,i)



-- C++ ----------------------------------------------------

/+co      cout  <<  << endl;                  (n,i)

/+c       class                              (n,i)

/+cn      class (using new)                   (n,i)

/+ci      class implementation                (n,i)

/+cni     class (using new) implementation    (n,i)

/+mi      method implementation              (n,i)

/+ai      accessor implementation            (n,i)



/+tc      template class                      (n,i)

/+tcn     template class (using new)          (n,i)

/+tci     template class implementation      (n,i)

/+tcni    template class (using new) impl.    (n,i)

/+tmi     template method implementation      (n,i)

/+tai     template accessor implementation    (n,i)



/+tf      template function                  (n,i)

/+ec      error class                        (n,i)

/+tr      try ... catch                      (n,v,i)

/+ca      catch                              (n,v,i)

/+c.      catch(...)                          (n,v,i)



-- Run ---------------------------------------------------

/rc       save and compile                    (n,i)

/rl       link                                (n,i)

/rr       run                                (n,i)

/ra       set comand line arguments          (n,i)

/rm       run make                            (n,i)

/rg       cmd. line arg. for make            (n,i)

/rp       run splint                          (n,i)

/ri       cmd. line arg. for splint          (n,i)

/rk       run CodeCheck (TM)                  (n,i)

/re       cmd. line arg. for CodeCheck(TM)   (n,i)

/rd       run indent                          (n,v,i)

/rh       hardcopy buffer                    (n,v,i)

/rs       show plugin settings                (n,i)

/rx       set xterm size                      (n, only Linux/UNIX & GUI)

/ro       change output destination          (n,i)

      

关于此插件的更多功能和各种说明, 请查看帮助手册, help csupport.

