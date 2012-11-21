" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
doc/winmanager.txt	[[[1
503
*winmanager*       Plugin for a classical Windows style IDE for Vim 6.0
                         For Vim version 6.0.
              Last Change: Sun Mar 31 11:00 PM 2002 PST

                            By Srinath Avadhanula
                            (srinath@fastmail.fm)

                                                         *winmanager-plugin*

winmanager.vim is a plugin which implements a classical windows type IDE in
Vim-6.0, where the directory and buffer browsers are displayed in 2 windows on
the left and the current editing is done on the right. When you open up a new
vim window, simply type in :WMToggle. This will start up winmanager.

Note This plugin is available only if 'compatible' is not set
     You can avoid loading this plugin by setting the "loaded_winmanager"
     variable >
        :let loaded_winmanager = 1

{Vi does not have any of this}
===========================================================================
OVERVIEW                                              *winmanager-overview*

|winmanager-installing|  Please follow these instructions for installing
                         winmanager. 

|winmanager-customizing| Describes ways of customizing the window layout, i.e
                         how to club various explorers into groups, how to
                         change their relative position, etc.

|winmanager-details|     details of using winmanager. keyboard shortcuts
                         and other usage details.

|winmanager-commands|    commands provided to the user. its useful to
                         set keyboard shortcuts to these commands.

|winmanager-settings|    settings (typically made in ~/.vimrc) which
                         affect the behavior of winmanager.

|winmanager-adding|      one of the most important new features of this
                         version is the creation of a framework whereby adding
                         other plugins like explorer.vim or bufexplorer.vim to
                         winmanager. This section describes briefly the
                         implementation of winmanager and then describes how
                         to add a new plugin to winmanager

|add-local-help|         how to use this text file as a vim help file.
|winmanager-bug|         bug reports are welcome.
|winmanager-thanks|      thanks to the many people who helped!

===========================================================================
UPDATES                                                *winmanager-updates*

The official releases can be found at: >
    http://vim.sourceforge.net/scripts/script.php?script_id=95
However, I will only update the vim.sf.net version of winmanager.zip in case
of a major bug or new feature. For small (and not so bothersome) bug-fixes, I
will put the latest version at: >
    http://robotics.eecs.berkeley.edu/~srinath/vim/winmanager-2.0.htm
and also announce it in vim@vim.org when an update occurs.
Therefore if you want to keep to be kept abreast of updates, you could
check occassionally at vim@vim.org. (you can also use your mail server's
filtering capability to effectively subscribe to the announcement).

============================================================================
INSTALLING                                          *winmanager-installing*

winmanager.vim should start working as soon as you restart vim after unzipping
the .zip file you got this from into ~/.vim (unix) or ~\vimfiles (dos)

winmanager only recognizes plugins whose name appears in the global variable >
    g:winManagerWindowLayout
<  
By default this global variable has the value >
    g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer'
<
(which is the value which winmanager uses if its not set in the user's .vimrc)

This global variable is responsible for making winmanager recognize the
existence of the explorers and simultaneously custome the window layout.  See
the next section for how to set this variable for various custom layouts of
winmanager.

============================================================================
CUSTOMIZING                                         *winmanager-customizing*

The layout of winmanager is controlled by changing the value of the
"g:winManagerWindowLayout" variable. The general form of this variable is
>
   g:winManagerWindowLayout =
   'Group1_Member1,Group1_Member2|Group2_Member_1,Group2_Member_2'
<
i.e, explorer "groups" are seperated by the '|' character. Within each group,
individual explorer plugin names are seperated by the comma (',') character.
What winmanager does is display only 1 member from each group in a window. The
user can go to a window and press <C-n> to display the next explorer belonging
to that group. This ability to "group" windows is valuable to preserve screen
real-estate by using them only as needed.

Thus for the default value of 'g:winManagerWindowLayout', winmanager will
split the vim window as follows:
        +-----------+-------------------+
        |           |                   |
        | File      |                   |
        | explorer  |    File being     |
        |           |     edited        |
        |           |                   |
        +-----------+                   |
        | Buffer    |                   |
        | explorer  |                   |
        |           |                   |
        +-----------+-------------------+

The user can go the [File List] window and press <C-n> to goto the
'TagsExplorer' view. 

Removing a plugin name from the 'g:winManagerWindowLayout' variable means
winmanager no longer sees that variable.

============================================================================
COMMANDS                                               *winmanager-commands*

:WMToggle                 :toggles the visibility of winmanager. This can
                           also be used to start winmanager for the first
                           time. A handy mapping is: >
            :map <c-w><c-t> :WMToggle<cr> 
<                          mnemonic: window-toggle : <c-W><c-T>

:FirstExplorerWindow      :directly takes you to the first explorer window
                           from the top left corner which is visible. >
            :map <c-w><c-f> :FirstExplorerWindow<cr>
<                          mnemonic: window-first  : <c-W><c-F>

:BottomExplorerWindow     :directly takes you to the last explorere window
                           from the top-left which is visible. >
            :map <c-w><c-b> :BottomExplorerWindow<cr>
<                          mnemonic: window-last   : <c-W><c-B>

NOTE: winmanager does not provide any mappings by default. These have to set
in the user's .vimrc if you want to use mappings.

============================================================================
SETTINGS                                               *winmanager-settings*

The values of the following global variables should be set in your .vimrc
file if you want a different value than the default:

g:persistentBehaviour: if set to 0, then as soon as you quit all the files
    and only the explorer windows are the ones left, vim will quit. the
    default is 1, which means that the explorer windows persist even if
    they are the only ones visible.

g:winManagerWidth: the width of the explorer areas. 
    (default 25)

g:defaultExplorer:  If you want winmanager to assume the functioning of the
    default explorer.vim which ships with vim, set this variable to 0.
    (default 1). If this variable is set to 1, then winmanager will behave as
    follows:
    . if the user starts off vim with a command such as
      ":vim some/dir/" then winmanager starts off the window layout with
      FileExplorer at the top left window. as of now it changes the
      g:windowLayout variable so that file explorer appears in the top left
      window.
    . if on the other hand the user does ":e some/dir/" while _inside_ vim,
      then the behavior is consistent with the original behavior of the
      explorer.vim plugin which ships with vim, i.e, the directory is opened
      in a buffer and the user can use that to open a file in that window.
    Note that the commands ":Explore" and ":Sexplore" are still available if
    you set this variable to 1.
    winfileexplorer.vim, the modification of explorer.vim which ships with
    this version is different from the standard explorer.vim in that it has
    display caching. i.e, the directory is read and sorted only the first
    time. From the second time on, the directory list is cached in a script
    variable so display is faster.

                                            *winmanager-fileexplorer-settings*
See |explorer| for details. 
NOTE: Some of the settings used in explorer.vim are not utlized in
winmanager.
                                            *winmanager-bufexplorer-settings*
g:bufExplorerMaxHeight: the buffer list window dynamicall rescales itself to
    occupy only the minimum space required to display all the windows. you
    can set a maximum number of lines for this window. (defualt 15)
See |bufexplorer| for details on additional options. 
NOTE: Some of the settings used in bufexplorer.vim are not utlized in
winmanager.

=============================================================================
DETAILED HELP                                            *winmanager-details*

When winmanager starts up, it divides up the whole vim window into 2
"regions". The region on the left is the "explorer area" where the various
explorer plugins are displayed. The region on the right is the "file editing
area", where the user works on his current editing session. 

        +--------+-------------------+
        |        |                   |
        |        |      2(i)         |
        | 1(i)   |                   |
        |        +-------------------+
        |        |                   |
        +--------+      2(ii)        |
        | 1(ii)  |                   |
        +--------+-------------------+

The explorer area (area 1) might contain multiple windows each of which might
contain multiple explorers. In the default configuration (for
g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer'), the first
window can be thought of as containing 2 explorers, the file explorer plugin
and the tags explorer plugin, while the bottom window contains bufexplorer by
itself.

When a window contains multiple explorers, then the user can cycle between
them by pressing <c-n> (mnemonic: next) or <c-p> (mnemonic: previous). 

This section describes the various keyboard shortcuts for the 3 plugins which
are used with winmanager by default.
NOTE: Other plugins might be distributed as add-ins to winmanager. In that
case, please refer to the help which ships with that plugin.
 
1. File Explorer plugin
This plugin displays the current directory. Its a modification of the standard
explorer.vim which ships with vim6.0. The following keyboard shortcuts are
available with this plugin:
<enter>          if on a directory, enters it and displays it in the same
                 area. If on a file, then opens it in the File Editing Area.
                 Attempts to open in the same window as the one visited
                 before, otherwise split open a new window horizontally. if
                 this sounds a bit confusing, it isnt. its the most intuitive
                 behaviour that one expects.
<2-leftmouse>   (doubleclick) the same as <enter>
<tab>            open the file or directory in a new window in the FileEditing
                 area. 
c                change the pwd to the directory currently displayed 
C                change the currently displayed directory to pwd (converse of
                 c) this helps in changing to different drives in windows.
                 i.e, if you are currently on the c: drive and you want to
                 change to the d: drive, you will have to do 
                 cd d:\
                 and then press 'C' in the file explorer area.
s                select sort field (size, date, name) 
r                reverse direction of sort 
f                add current directory to list of favorites.
R                rename file 
D                delete file (or range of files in visual mode)
-                move up one level
<F5>             refresh the file list

2. Buffer Explorer plugin
See |bufexplorer-usage| for details.
NOTE: In addition to those shortcuts, winmanager adds the following:
<tab>             Opens the buffer under the cursor in a split window even if
                  the current buffer is not modified.

This window is dynamically rescaled and re-displayed. i.e, when a new window
opens somehwere, the buffer list is automatically updated. also, it tries to
occupy the minimum possible space required to display the files. 

3. File Editing Area
The area where normal editing takes place. The commands in the File Explorer
and Buffer Explorer shouldnt affect the layout of the windows here. Some
mappings which I find useful (which should be placed in your .vimrc if you
plan on using WManager often) is 
>
    map <c-w><c-b> :BottomExplorerWindow<cr>
    map <c-w><c-f> :FirstExplorerWindow<cr>
    map <c-w><c-t> :WMToggle<cr>

Pressing CTRL-W-B should then take you directly to the last explorer window
Similarly pressing CTRL-W-F should take you to the first explorer window.
CTRL-W-T will toggle between the winmanager visible and invisible.

=============================================================================
ADDING NEW PLUGINS                                        *winmanager-adding*

This section is of interest only to people who might want to extend winmanager
by adding other plugins to it. The casual user can skip it.

One of the most important new features of winmanager2.x is the ability to let
other users add IDE type plugins to winmanager.vim with a minimum of effort.
The way winmanager ships, it usually contains the following plugins:
>
    (FileExplorer, TagsExplorer)
    (BufExplorer)

i.e, FileExplorer and TagsExplorer occupy one window as a single group, while
BufExplorer occupies another window. "Adding" a plugin means that you will be
able to add a seperate IDE plugin, (call it "YourPlugin" henceforth) either to
one of these groups or seperately by itself. This section describes how to
accomplish this. Although the section is somewhat lengthy, please rest assured
that its really quite simple to do. Have a look at |wintagexplorer|.vim for a
small plugin which accomplishes this.

To better understand the process, its helpful to give a short description of
the workings of winmanager. When a user wants to use your plugin, he
"registers" it with winmanager, i.e he adds the "name" of the plugin to the
variable g:winManagerWindowLayout in his .vimrc as:

    " this line goes in the user's .vimrc
    let g:winManagerWindowLayout = "FileExplorer,TagsExplorer|YourPlugin"

When winmanager starts up, it remembers the string "YourPlugin" internally as
the plugins "name". (The reason for making this a part of the user's .vimrc
is that that way, he can customize the window layout according to his
preferences).

In addition to registering, the plugin itself initializes a variable called
the "title" which starts with the name, such as: >

    " this line goes in your script file.
    let g:YourPlugin_title = "[My Plugin Title]"

<
NOTE: Just like the rest of the hooks provided by your plugin, this global
variable name is formed according the rule: g:<YourPluginName>_title.

When winmanager starts up, it performs the following 2 actions:
    1. It opens a new file with the "title" provided by the plugin. This
       automatically ensures that the same buffer is opened for multiple
       invokations of the plugin.
       NOTE: It is very important for this reason that the plugin's name be
       distinct so that there is a low (ideally zero) probability of a file
       with the same name existing on a user's system.
    2. It modifies the "name" string (in this case "YourPlugin") to form 
       "call YourPlugin_Start()" and then |exec|s this string. Thus winmanager
       communicates with your plugin by using a number of such "hooks" or
       global functions which all start with the string "YourPlugin" which are
       defined in the script file you create.

In order to enable the dynamic nature of winmanager, where you can have your
plugin change its display every time a |BufEnter| or |BufDelete| event occurs,
it is necessary to provide a few other hooks. Every time a BufEnter or
BufDelete event occurs, winmanager makes a loop over all the visible buffers.
Then it "refreshes" the display of that plugin if it is "invalid". The
following paragraphs describe the hooks that have to be provided to enable
this.

                                                           *winmanager-hooks*

The following is a list of hooks which should be provided. A few of them are
optional. Consider the case where you want to add a plugin which you have
named "YourPlugin". In the following discussion, a "hook" simply refers to a
globally visible function which is formed according to the rule that it start
with the string "YourPlugin_", where "YourPlugin" is the name of your plugin.

                                                       *winmanager-hook-start* 
YourPlugin_Start()       This function is called during initialization.  It
{Mandatory}              can be assumed (and _should_ be) that the focus is
                         already in the buffer where stuff needs to be
                         displayed. i.e, the plugin shouldnt open some other
                         buffer during this function. (i.e, commands such as
                         ":e", ":vsplit", ":wincmd h" etc in this stage are
                         bad. If however, you absolutely need to switch
                         buffers or something which will cause |BufEnter| or
                         |BufDelete| events, then you need to temporarily
                         switch winmanager off by using
                         |WinManagerSuspendAUs|)

                                                    *winmanager-hook-isvalid*
YourPlugin_IsValid()     winmanager is dynamic in the sense that it allows the
{Mandatory}              plugins to change their displays when a BufEnter event
                         occurs. At each BufEnter event, winmanager will cycle
                         through all the visible explorers asking them if
                         their display is "valid". If it isn't, then they will
                         be redrawn by calling the next function.

                         For plugins such as bufexplorer which change with
                         every BufEnter, it is sufficient to make this always
                         return 1. For plugins such as fileexplorer, the
                         display never changes with the BufEnter even. hence
                         in its case, it will always return 0.

                                                     *winmanager-hook-refresh*
YourPlugin_Refresh()      If the YourPlugin_IsValid() function returns 0, then
{Optional}                this function is called to update the display. if the
                          first function always returns 1, then this function
                          need not be defined.
                          NOTE: It is not clear at this time whether this
                          function is really necessary. It might be obsoleted
                          in the future. Future versions might call the
                          _Start() function instead.
                          NOTE: It has been obsoleted as of version 2.1

                                                      *winmanager-hook-resize*
YourPlugin_ReSize()       The plugins can also be dynamically resizable.  (the
{Optional}                current bufexplorer which ships with the winmanager
                          exhibits this behavior).  If a plugin creates such a
                          function, then it will be called after its Refresh()
                          function. The reason for not letting the plugin make
                          this a part of its Refresh() function is that
                          sometimes resizing is not allowed, such as in
                          instances where there is no window above or below the
                          plugin to take the slack of a resize.


In addition, the plugin should also initialize the following global variable

                                                       *winmanager-hook-title*
g:YourPlugin_title        This is the name of the buffer associated with
                          this plugin. The reason for a title in addition to a
                          name is that the name should be such that a global
                          function of that name can be defined.  However, the
                          title can be more descriptive and contain spaces
                          etc. For example, the present distribution of
                          FileExplorer has the title "[File List]". Also,
                          winmanager opens a file with this name (using an
                          equivalent of ":e g:YourPlugin_title"), which
                          automatically ensures that new buffers are not eaten
                          up in multiple invokations of winmanager, toggling
                          visibility of buffers, etc. 
                          NOTE: It is very important for this reason that the
                          plugin's name be distinct so that there is a low
                          (ideally zero) probability of a file with the same
                          name existing on a user's system. 

In addition to YourPlugin providing winmanager with hooks, winmanager also
provides the following hooks for use by YourPlugin:

                                                        *WinManagerFileEdit*
WinManagerFileEdit({filename}, {split})
                          This function _must_ be used when the plugin wants
                          to open a new file in the file editing area for
                          editing. Its not sufficient to do something like
                          ":wincmd p" and then ":e filename", because first of
                          all the ":wincmd p" command gets screwed
                          (unfortunately) in the presence of winmanager
                          because of the (sometimes) large movement winmanager
                          does over all visible windows to maintain the
                          dynamic nature. Secondly, doing a simple ":e
                          filename" will not preserve the @# and the @%
                          registers properly, causing handy commands such as
                          |CTRL-^| to totally mis-behave.

                          The first argument should be (preferably) the
                          (complete) name of the file to be opened (including
                          the full path to it if possible).  The second
                          argument decides whether winmanager should attempt
                          to open the file in the same window as the last
                          window or to split a new window to open the file.

                                                     *WinManagerSuspendAUs*
WinManagerSuspendAUs()    This makes winmanager stop responding to the
                          |BufEnter| or |BufDelete| autocommands like it
                          normally does. Please use this function with care.
                          You will need to use this when you are performing
                          some action which causes these events but you dont
                          want to have winmanager go through the whole
                          isvalid/refresh cycle. NOTE: Take care to definitely
                          reset the behavior by using the next function.

                                                     *WinManagerResumeAUs*
WinManagerResumeAUs()     This is the converse of |WinManagerSuspendAUs()|. It
                          makes winmanager start responding to events with the
                          usual isvalid/refresh cycle.

                                                   *WinManagerForceReSize* 
WinManagerForceReSize()   Normally, winmanager calls the YourPlugin_ReSize()
                          function after the YourPlugin_Refresh(). However,
                          this happens only every |BufEnter| event. When the
                          plugin performs some function which requires it to
                          resize even when there was no |BufEnter| or
                          |BufDelete| event, use this function. Please avoid
                          making a call to YourPlugin_ReSize() because a
                          number of safety checks have to be performed before
                          a resizing is "legal".
                          
Finally, if you do plan on making an addin to winmanager, feel free to contact
me for help/comments/suggestions. You might also want to take a look at: >
    http://robotics.eecs.berkeley.edu/~srinath/vim/explorerSample.vim
for a simple template of an add-in plugin.

=============================================================================
BUGS                                                         *winmanager-bug*

Please send any comments for improvements or bug-reports to >
    srinath@fastmail.fm
If the bug is repeatable, then it will be of great help if a short description
of the events leading to the bug are also given.

Note "I dont like winmanager" is not a bug report, only an opinion ;-)

=============================================================================
THANKS                                                    *winmanager-thanks*

I am really grateful to all those who emailed me with bug-reports and comments
for improvement. Most of all, a huge thanks to Xiangjiang Ma for his enormous
support and extremeley helpful QA. 

Other people who helped greatly:
   Madoka Machitani: fixed a couple of typos and gave some ideas for making
      things more robust.
   Colin Dearing: gave many useful suggestions for improvement which lead to
      the fast redraw capability of winmanager
   Jeff Lanzarotta: for agreeing to make changes to bufexplorer.vim so that
      bufexplorer.vim would be compatible with the latest version of
      winmanager.vim

   and finally all the great support I got from vim@vim.org and comp.editors
   helped a lot.


vim:tw=78:et:ts=4:ft=help:norl:
plugin/winfileexplorer.vim	[[[1
1543
"=============================================================================
" File: explorer.vim
" Author: M A Aziz Ahmed (aziz@acorn-networks.com)
" Last Change: 2007-05-22 16:52:26
" Version: 2.5
" Additions by Mark Waggoner (waggoner@aracnet.com) et al.
"-----------------------------------------------------------------------------
" This file implements a file explorer. Latest version available at:
" http://www.freespeech.org/aziz/vim/
" Updated version available at:
" http://www.aracnet.com/~waggoner
"-----------------------------------------------------------------------------
" Normally, this file will reside in the plugins directory and be
" automatically sourced.  If not, you must manually source this file
" using :source explorer.vim
"
" To use it, just edit a directory (vi dirname) or type :Explore to
" launch the file explorer in the current window, or :Sexplore to split
" the current window and launch explorer there.
"
" If the current buffer is modified, the window is always split.
"
" It is also possible to delete files and rename files within explorer.
" See :help file-explorer for more details
"
"-----------------------------------------------------------------------------
" Update history removed, it's not very interesting.
" Contributors were: Doug Potts, Bram Moolenaar, Thomas Köhler
"
" This is a modified version to be compatible with winmanager.vim. 
" Changes by Srinath Avadhanula
"=============================================================================

" Has this already been loaded?
if exists("loaded_winfileexplorer")
  finish
endif
let loaded_winfileexplorer=1

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

"---
" Default settings for global configuration variables

" Split vertically instead of horizontally?
if !exists("g:explVertical")
  let g:explVertical=0
endif

" How big to make the window? Set to "" to avoid resizing
if !exists("g:explWinSize")
  let g:explWinSize=15
endif

" When opening a new file/directory, split below current window (or
" above)?  1 = below, 0 = to above
if !exists("g:explSplitBelow")
  let g:explSplitBelow = &splitbelow
endif

" Split to right of current window (or to left)?
" 1 = to right, 0 = to left
if !exists("g:explSplitRight")
  let g:explSplitRight = &splitright
endif

" Start the first explorer window...
" Defaults to be the same as explSplitBelow
if !exists("g:explStartBelow")
  let g:explStartBelow = g:explSplitBelow
endif

" Start the first explorer window...
" Defaults to be the same as explSplitRight
if !exists("g:explStartRight")
  let g:explStartRight = g:explSplitRight
endif

" Show detailed help?
if !exists("g:explDetailedHelp")
  let g:explDetailedHelp=0
endif

" Show file size and dates?
if !exists("g:explDetailedList")
  let g:explDetailedList=0
endif

" Format for the date
if !exists("g:explDateFormat")
  let g:explDateFormat="%d %b %Y %H:%M"
endif

" Files to hide
if !exists("g:explHideFiles")
  let g:explHideFiles=''
endif

" Field to sort by
if !exists("g:explSortBy")
  let g:explSortBy='name'
endif

" Segregate directories? 1, 0, or -1
if !exists("g:explDirsFirst")
  let g:explDirsFirst=1
endif

" Segregate items in suffixes option? 1, 0, or -1
if !exists("g:explSuffixesLast")
  let g:explSuffixesLast=1
endif

" Include separator lines between directories, files, and suffixes?
if !exists("g:explUseSeparators")
  let g:explUseSeparators=0
endif

" whether or not to take over the functioning of the default file-explorer
" plugin
if !exists("g:defaultExplorer")
	let g:defaultExplorer = 1
end

" whether or not to show hidden files in the file-explorer plugin.
if !exists("g:explShowHiddenFiles")
	let g:explShowHiddenFiles = 0
end

if !exists('g:favDirs')
	if exists('$HOME')
		let s:favDirs = expand('$HOME').'/'
	end
else
	if exists('$HOME')
		let s:favDirs = g:favDirs."\/\n".expand('$HOME')
	end
end
let s:favDirs = substitute(s:favDirs, '\', '/', 'g')
let s:favDirs = substitute(s:favDirs, '\/\/', '\/', 'g')

" -- stuff used by winmanager
let g:FileExplorer_title = "[File List]"
function! FileExplorer_Start()
	let b:displayMode = "winmanager"
	if exists('s:lastDirectoryDisplayed')
		call s:EditDir(s:lastDirectoryDisplayed)
	else
		call s:EditDir(expand("%:p:h"))
	end
	if exists('s:lastCursorRow')
		exe s:lastCursorRow
		exe 'normal! '.s:lastCursorColumn.'|'
	end
endfunction

function! FileExplorer_IsValid()
	return 1
endfunction

function! FileExplorer_WrapUp()
	let s:lastCursorRow = line('.')
	let s:lastCursorColumn = virtcol('.')
	let s:lastDirectoryDisplayed = b:completePath
endfunction
" --- end winmanager specific stuff (for now)

"---
" script variables - these are the same across all
" explorer windows

" characters that must be escaped for a regular expression
let s:escregexp = '/*^$.~\'

" characters that must be escaped for filenames
if has("dos16") || has("dos32") || has("win16") || has("win32") || has("os2")
  let s:escfilename = ' %#'
else
  let s:escfilename = ' \%#'
endif


" A line to use for separating sections
let s:separator='"---------------------------------------------------'

"---
" Create commands
" commenting stuff for beta version release
" if !exists(':Explore')
"   command -n=? -complete=dir Explore :call s:StartExplorer(0, '<a>')
" endif
" if !exists(':Sexplore')
"   command -n=? -complete=dir Sexplore :call s:StartExplorer(1, '<a>')
" endif
" 
"---
" Start the explorer using the preferences from the global variables
"
function! s:StartExplorer(split, start_dir)
	let startcmd = "edit"
	if a:start_dir != ""
		let fname=a:start_dir
	else
		let fname = expand("%:p:h")
	endif
	if fname == ""
		let fname = getcwd()
	endif

	" Create a variable to use if splitting vertically
	let splitMode = ""
	if g:explVertical == 1
		let splitMode = "vertical"
	endif

	" Save the user's settings for splitbelow and splitright
	let savesplitbelow = &splitbelow
	let savesplitright = &splitright

	if a:split || &modified
		let startcmd = splitMode . " " . g:explWinSize . "new " . fname
		let &splitbelow = g:explStartBelow
		let &splitright = g:explStartRight
	else
		let startcmd = "edit " . fname
	endif
	silent execute startcmd
	let &splitbelow = savesplitbelow
	let &splitright = savesplitright
endfunction


"---
" This is the main entry for 'editing' a directory
"
function! s:EditDir(...)
	" depending on the number of arguments, this function has either been called
	" by winmanager or by doing "e dirname" or :Explore
	if a:0 == 0
		" Get out of here right away if this isn't a directory!
		let name = expand("%")
		if name == ""
			let name = expand("%:p")
		endif
	elseif a:0 >= 1
		let name = a:1
		set modifiable
		1,$d_
	end	
	if a:0 >= 2 
		let forceReDisplay = a:2
	else
		let forceReDisplay = 0
	end

	if !isdirectory(name)
		return
	endif

	" Turn off the swapfile, set the buffer type so that it won't get
	" written, and so that it will get deleted when it gets hidden.
	setlocal modifiable
	setlocal noswapfile
	setlocal buftype=nowrite
	setlocal bufhidden=delete
	" Don't wrap around long lines
	setlocal nowrap


	" Get the complete path to the directory to look at with a slash at
	" the end
	let b:completePath = s:Path(name)
	let s:lastDirectoryDisplayed = b:completePath

	" Save the directory we are currently in and chdir to the directory
	" we are editing so that we can get a real path to the directory,
	" eliminating things like ".."
	let origdir= s:Path(getcwd())
	exe "chdir" escape(b:completePath,s:escfilename)
	let b:completePath = s:Path(getcwd())
	exe "chdir" escape(origdir,s:escfilename)

	" Add a slash at the end
	if b:completePath !~ '/$'
		let b:completePath = b:completePath . '/'
	endif

	" escape special characters for exec commands
	let b:completePathEsc=escape(b:completePath,s:escfilename)
	let b:parentDirEsc=substitute(b:completePathEsc, '/[^/]*/$', '/', 'g')

	" Set filter for hiding files
	let b:filterFormula=substitute(g:explHideFiles, '\([^\\]\),', '\1\\|', 'g')
	if b:filterFormula != ''
		let b:filtering="\nNot showing: " . b:filterFormula
	else
		let b:filtering=""
	endif


	" added to allow directory caching
	" s:numFileBuffers is an array containing the names of the directories
	" visited.
	if !exists("s:numFileBuffers")
		let s:numFileBuffers = 0
	end

	let i = 1
	while i <= s:numFileBuffers
		exec 'let diri = s:dir_'.i
		if diri == b:completePath
			" if we are on a previously displayed directory which is being redrawn
			" forcibly, then skip the stage of pasting from memory ... 
			if !forceReDisplay
				let oldRep=&report
				let save_sc = &sc
				set report=10000 nosc
				1,$d _
				exec 'put=s:FileList_'.i
				0d
				0
				let b:maxFileLen = 0
				/^"=/+1,$g/^/call s:MarkDirs()
				call s:CleanUpHistory()
				call s:PrintFavDirs()
				0
				/^"=/+1
				call s:CleanUpHistory()
				let &report=oldRep
				let &sc = save_sc
			end
			" ... merely remember the variable number and break.
			let s:currentFileNumberDisplayed = i
			break
		endif
		let i = i+1	
	endwhile

	" No need for any insertmode abbreviations, since we don't allow
	" insertions anyway!
	iabc <buffer>

	" Long or short listing?  Use the global variable the first time
	" explorer is called, after that use the script variable as set by
	" the interactive user.
	if exists("s:longlist")
		let w:longlist = s:longlist
	else
		let w:longlist = g:explDetailedList
	endif

	" Show keyboard shortcuts?
	if exists("s:longhelp")
		let w:longhelp = s:longhelp
	else
		let w:longhelp = g:explDetailedHelp
	endif

	" Set the sort based on the global variables the first time.  If you
	" later change the sort order, it will be retained in the s:sortby
	" variable for the next time you open explorer
	let w:sortdirection=1
	let w:sortdirlabel = ""
	let w:sorttype = ""
	if exists("s:sortby")
		let sortby=s:sortby
	else
		let sortby=g:explSortBy
	endif
	if sortby =~ "reverse"
		let w:sortdirection=-1
		let w:sortdirlabel = "reverse "
	endif
	if sortby =~ "date"
		let w:sorttype = "date"
	elseif sortby =~ "size"
		let w:sorttype = "size"
	else
		let w:sorttype = "name"
	endif
	call s:SetSuffixesLast()

	" Set up syntax highlighting
	" Something wrong with the evaluation of the conditional though...
	if has("syntax") && exists("g:syntax_on") && !has("syntax_items")
		syn match browseSynopsis    "^\"[ -].*"
		syn match favoriteDirectory "^+ .*$"
		syn match browseDirectory   "[^\"+].*/ "
		syn match browseDirectory   "[^\"+].*/$"
		syn match browseCurDir      "^\"= .*$"
		syn match browseSortBy      "^\" Sorted by .*$"  contains=browseSuffixInfo
		syn match browseSuffixInfo  "(.*)$"  contained
		syn match browseFilter      "^\" Not Showing:.*$"
		syn match browseFiletime    "«\d\+$"
		exec('syn match browseSuffixes    "' . b:suffixesHighlight . '"')

		"hi def link browseSynopsis    PreProc
		hi def link browseSynopsis    Special
		hi def link browseDirectory   Directory
		hi def link browseCurDir      Statement
		hi def link favoriteDirectory Type
		hi def link browseSortBy      String
		hi def link browseSuffixInfo  Type
		hi def link browseFilter      String
		hi def link browseFiletime    Ignore
		hi def link browseSuffixes    Type
	endif
	" Set up mappings for this buffer
	let cpo_save = &cpo
	set cpo&vim

	if exists("b:displayMode") && b:displayMode == "winmanager"
		" when called in winmanager mode, the argument movefirst assumes the role
		" of whether or not to split a window.
		nnoremap <buffer> <cr> :call <SID>EditEntry(0,"winmanager")<cr>
		nnoremap <buffer> <tab> :call <SID>EditEntry(1,"winmanager")<cr>
		nnoremap <buffer> -    :call <SID>EditDir(b:parentDirEsc)<cr>
		nnoremap <buffer> <2-leftmouse> :call <SID>EditEntry(0,"winmanager")<cr>
		nnoremap <buffer> C    :call <SID>EditDir(getcwd(),1)<cr>:call <SID>RestoreFileDisplay()<cr>
		nnoremap <buffer> <F5> :call <SID>EditDir(b:completePath,1)<cr>:call <SID>RestoreFileDisplay()<cr>
		nnoremap <buffer> <C-^> <Nop>
		nnoremap <buffer> f :call <SID>AddToFavDir()<cr>
	else
		nnoremap <buffer> <cr> :call <SID>EditEntry("","edit")<cr>
		nnoremap <buffer> -    :exec ("silent e "  . b:parentDirEsc)<cr>
		nnoremap <buffer> o    :call <SID>OpenEntry()<cr>
		nnoremap <buffer> O    :call <SID>OpenEntryPrevWindow()<cr>
		nnoremap <buffer> <2-leftmouse> :call <SID>DoubleClick()<cr>
	endif
	nnoremap <buffer> p   :call <SID>EditEntry("","pedit")<cr>
	nnoremap <buffer> a   :call <SID>ShowAllFiles()<cr>:call <SID>RestoreFileDisplay()<cr>
	nnoremap <buffer> R   :call <SID>RenameFile()<cr>
	nnoremap <buffer> D   :. call <SID>DeleteFile()<cr>:call <SID>RestoreFileDisplay()<cr>
	vnoremap <buffer> D   :call <SID>DeleteFile()<cr>:call <SID>RestoreFileDisplay()<cr>
	nnoremap <buffer> i   :call <SID>ToggleLongList()<cr>:call <SID>RestoreFileDisplay()<cr>
	nnoremap <buffer> s   :call <SID>SortSelect()<cr>:call <SID>RestoreFileDisplay()<cr>
	nnoremap <buffer> r   :call <SID>SortReverse()<cr>:call <SID>RestoreFileDisplay()<cr>
	nnoremap <buffer> ?   :call <SID>ToggleHelp()<cr>
	nnoremap <buffer> a   :call <SID>ShowAllFiles()<cr>:call <SID>RestoreFileDisplay()<cr>
	nnoremap <buffer> R   :call <SID>RenameFile()<cr>
	nnoremap <buffer> c   :exec "cd ".b:completePathEsc<cr>:pwd<cr>
	nnoremap <buffer> S   :call <SID>ShellExecute()<cr>
	nnoremap <buffer> x   :call <SID>ToggleShowHiddenFiles()<cr>
	let &cpo = cpo_save

	" If directory is already loaded, don't open it again!
	if line('$') > 1
		setlocal nomodifiable
		return
	endif

	" Show the files
	call s:ShowDirectory()
	call s:PrintFavDirs()

	" prevent the buffer from being modified
	setlocal nomodifiable

	" remember the contents of this directory if its been displayed for the
	" first time for fast redraw later. if we have reached here bcause of a
	" forcible redraw, do not create a new s:dir_i variable.
	if !forceReDisplay
		let s:numFileBuffers = s:numFileBuffers + 1
		let s:currentFileNumberDisplayed = s:numFileBuffers
		exe 'let s:dir_'.s:currentFileNumberDisplayed.' = b:completePath'
	end
	0
	/^"=/+1
	call s:CleanUpHistory()
	call s:RestoreFileDisplay()
endfunction

"---
" If this is the only window, open file in a new window
" Otherwise, open file in the most recently visited window
"
function! s:OpenEntryPrevWindow()
	" Figure out if there are any other windows
	let n = winnr()
	wincmd p
	" No other window?  Then open a new one
	if n == winnr()
		call s:OpenEntry()
		" Other windows exist
	else
		" Check if the previous buffer is modified - ask if they want to
		" save!
		let bufname = bufname(winbufnr(winnr()))
		if &modified
			let action=confirm("Save Changes in " . bufname . "?","&Yes\n&No\n&Cancel")
			" Yes - try to save - if there is an error, cancel
			if action == 1
				let v:errmsg = ""
				silent w
				if v:errmsg != ""
					echoerr "Unable to write buffer!"
					wincmd p
					return
				endif
				" No, abandon changes
			elseif action == 2
				set nomodified
				echomsg "Warning, abandoning changes in " . bufname
				" Cancel (or any other result), don't do the open
			else
				wincmd p
				return
			endif
		endif
		wincmd p
		call s:EditEntry("wincmd p","edit")
	endif
endfunction

"
" save the contents of the currently displayed file listing into the current
" s:dir_i variable
"
function! s:RestoreFileDisplay()
	let oldRep=&report
	let save_sc = &sc
	set report=10000 nosc
	let presLine = line('.')

	let saverega = @a
	normal! ggVG"ay
	exec 'let s:FileList_'.s:currentFileNumberDisplayed.' = @a'
	let @a = saverega

	let &report=oldRep
	let &sc = save_sc
	exe presLine
endfunction

"---
" Open a file or directory in a new window.
" Use g:explSplitBelow and g:explSplitRight to decide where to put the
" split window, and resize the original explorer window if it is
" larger than g:explWinSize
"
function! s:OpenEntry()
  " Are we on a line with a file name?
  let l = getline(".")
  if l =~ '^"'
    return
  endif

  " Copy window settings to script settings
  let s:sortby=w:sortdirlabel . w:sorttype
  let s:longhelp = w:longhelp
  let s:longlist = w:longlist

  " Get the window number of the explorer window
  let n = winnr()

  " Save the user's settings for splitbelow and splitright
  let savesplitbelow=&splitbelow
  let savesplitright=&splitright

  " Figure out how to do the split based on the user's preferences.
  " We want to split to the (left,right,top,bottom) of the explorer
  " window, but we want to extract the screen real-estate from the
  " window next to the explorer if possible.
  "
  " 'there' will be set to a command to move from the split window
  " back to the explorer window
  "
  " 'back' will be set to a command to move from the explorer window
  " back to the newly split window
  "
  " 'right' and 'below' will be set to the settings needed for
  " splitbelow and splitright IF the explorer is the only window.
  "
  if g:explVertical
    if g:explSplitRight
      let there="wincmd h"
      let back ="wincmd l"
      let right=1
      let below=0
    else
      let there="wincmd l"
      let back ="wincmd h"
      let right=0
      let below=0
    endif
  else
    if g:explSplitBelow
      let there="wincmd k"
      let back ="wincmd j"
      let right=0
      let below=1
    else
      let there="wincmd j"
      let back ="wincmd k"
      let right=0
      let below=0
    endif
  endif

  " Get the file name
  let fn=s:GetFullFileName()

  " Attempt to go to adjacent window
  exec(back)
  " If no adjacent window, set splitright and splitbelow appropriately
  if n == winnr()
    let &splitright=right
    let &splitbelow=below
  else
    " found adjacent window - invert split direction
    let &splitright=!right
    let &splitbelow=!below
  endif

  " Create a variable to use if splitting vertically
  let splitMode = ""
  if g:explVertical == 1
    let splitMode = "vertical"
  endif

  " Is it a directory?  If so, get a real path to it instead of
  " relative path
  if isdirectory(fn)
    let origdir= s:Path(getcwd())
    exe "chdir" escape(fn,s:escfilename)
    let fn = s:Path(getcwd())
    exe "chdir" escape(origdir,s:escfilename)
  endif

  " Open the new window
  exec("silent " . splitMode." sp " . escape(fn,s:escfilename))

  " resize the explorer window if it is larger than the requested size
  exec(there)
  if g:explWinSize =~ '[0-9]\+' && winheight("") > g:explWinSize
    exec("silent ".splitMode." resize ".g:explWinSize)
  endif
  exec(back)

  " Restore splitmode settings
  let &splitbelow=savesplitbelow
  let &splitright=savesplitright

endfunction

"---
" Double click with the mouse
"
function s:DoubleClick()
	if expand("<cfile>") =~ '[\\/]$'
		call s:EditEntry("","edit")		" directory: open in this window
	else
		call s:OpenEntryPrevWindow()	" file: open in another window
	endif
endfun


"---
" Open file or directory with the corresponding application
" associated by the shell
"
function! s:ShellExecute()
  " Are we on a line with a file name?
  let l = getline(".")
  if l =~ '^"'
    return
  endif

  " Copy window settings to script settings
  let s:sortby=w:sortdirlabel . w:sorttype
  let s:longhelp = w:longhelp
  let s:longlist = w:longlist

  " Get the file name
  let fn=s:GetFullFileName()

  if (has("win32"))
    exec "silent ! start \"\" \"".substitute(fn, "/", "\\", "g")."\""
  else
	if (exists("g:netrw_browsex_viewer"))
		exec "silent !" . g:netrw_browsex_viewer . " \'".fn."\'"
	else
		exec "silent !start \'".fn."\'"
	endif
  endif
endfunction

"---
" Open file or directory in the same window as the explorer is
" currently in
"
function! s:EditEntry(movefirst,editcmd)
  " Are we on a line with a file name?
  let l = getline(".")
  if l =~ '^"'
    return
  endif

  " Copy window settings to script settings
  let s:sortby=w:sortdirlabel . w:sorttype
  let s:longhelp = w:longhelp
  let s:longlist = w:longlist

  " Get the file name
  let fn=s:GetFullFileName()
  if isdirectory(fn)
    let origdir= s:Path(getcwd())
    exe "chdir" escape(fn,s:escfilename)
    let fn = s:Path(getcwd())
    exe "chdir" escape(origdir,s:escfilename)
  endif

	" if its the original explorer using this function, then proceed as before.
	if !(exists("b:displayMode") && b:displayMode == "winmanager")
		" Move to desired window if needed
		exec(a:movefirst)
		" Edit the file/dir
		exec(a:editcmd . " " . escape(fn,s:escfilename))
	" otherwise if its winmanager which called it, then do things the winmanager
	" way, i.e, open directories in the same buffer and open files in the last
	" visited file editing area (splitting if necessary)
	else
		if isdirectory(fn)
			" callinng EditDir ensures that things are displayed in the same buffer.
			call s:EditDir(fn)
		else
			" this function is provided by winmanager. it takes focus to the last
			" visited buffer in the file editing area and then opens the new file in
			" its place, while taking into consideration whether that buffer was
			" modified, or whether the user wants to force a split each time, etc.
			call WinManagerFileEdit(fn, a:movefirst)
		end
	end
endfunction

"---
" Create a regular expression out of the suffixes option for sorting
" and set a string to indicate whether we are sorting with the
" suffixes at the end (or the beginning)
"
function! s:SetSuffixesLast()
	let b:suffixesRegexp = '\(' . substitute(escape(&suffixes,s:escregexp),',','\\|','g') . '\)$'
	let b:suffixesHighlight = '^[^"].*\(' . substitute(escape(&suffixes,s:escregexp),',','\\|','g') . '\)\( \|$\)'
	if has("fname_case")
		let b:suffixesRegexp = '\C' . b:suffixesRegexp
		let b:suffixesHighlight = '\C' . b:suffixesHighlight
	else
		let b:suffixesRegexp = '\c' . b:suffixesRegexp
		let b:suffixesHighlight = '\c' . b:suffixesHighlight
	endif
	if g:explSuffixesLast > 0 && &suffixes != ""
		let b:suffixeslast=" (" . &suffixes . " at end of list)"
	elseif g:explSuffixesLast < 0 && &suffixes != ""
		let b:suffixeslast=" (" . &suffixes . " at start of list)"
	else
		let b:suffixeslast=" ('suffixes' mixed with files)"
	endif
endfunction

"---
" Show the header and contents of the directory
"
function! s:ShowDirectory()
	" Prevent a report of our actions from showing up
	let oldRep=&report
	let save_sc = &sc
	set report=10000 nosc

	"Delete all lines
	1,$d _

	" Add the header
	call s:AddHeader()
	$d _

	" Display the files

	" Get a list of all the files
	let files = s:Path(glob(b:completePath."*"))
	if files != "" && files !~ '\n$'
		let files = files . "\n"
	endif

	if g:explShowHiddenFiles
		" Add the dot files now, making sure "." and ".." are not included!
		let files = files . substitute(s:Path(glob(b:completePath.".*"))."\n", "[^\n]*/..\\=/\\=\n", '' , 'g')
		if files != "" && files !~ '\n$'
			let files = files . "\n"
		endif
	endif

	" Append ".." is not at the root directory.
	if b:completePath != "/"
		let files = files . "..\n"
	endif

	" Are there any files left after filtering?
	if files != ""
		normal! mt
		put =files
		let b:maxFileLen = 0
		0
		/^"=/+1,$g/^/call s:MarkDirs()
		call s:CleanUpHistory()
		normal! `t
		call s:AddFileInfo()
	endif

	normal! zz

	" Move to first directory in the listing
	0
	/^"=/+1
	call s:CleanUpHistory()

	" Do the sort
	call s:SortListing("Loaded contents of ".b:completePath.". ")

	" Move to first directory in the listing
	0
	/^"=/+1
	call s:CleanUpHistory()

	let &report=oldRep
	let &sc = save_sc

endfunction

function! s:AddToFavDir()

	if s:favDirs !~ "\\(^\\|\n\\)".b:completePath."\\(\n\\|$\\)"
		let s:favDirs = s:favDirs."\n".b:completePath
	else
		return
	endif

	let pos = (line('.')+1).' | normal! '.virtcol('.').'|'
	call s:PrintFavDirs()
	exe pos
endfunction

"---
" Mark which items are directories - called once for each file name
" must be used only when size/date is not displayed
"
function! s:MarkDirs()
	let oldRep=&report
	set report=1000
	"Remove slashes if added
	s;/$;;e
	"Removes all the leading slashes and adds slashes at the end of directories
	s;^.*\\\([^\\]*\)$;\1;e
	s;^.*/\([^/]*\)$;\1;e
	"normal! ^
	let currLine=getline(".")
	if isdirectory(b:completePath . currLine)
		s;$;/;
		let fileLen=strlen(currLine)+1
	else
		let fileLen=strlen(currLine)
		if (b:filterFormula!="") && (currLine =~ b:filterFormula)
			" Don't show the file if it is to be filtered.
			d _
		endif
	endif
	if fileLen > b:maxFileLen
		let b:maxFileLen=fileLen
	endif
	let &report=oldRep
endfunction

"---
" Make sure a path has proper form
"
function! s:Path(p)
	if has("dos16") || has("dos32") || has("win16") || has("win32") || has("os2")
		return substitute(a:p,'\\','/','g')
	else
		return a:p
	endif
endfunction

"---
" Extract the file name from a line in several different forms
"
function! s:GetFullFileNameEsc()
    return s:EscapeFilename(s:GetFullFileName())
endfunction

function! s:GetFileNameEsc()
    return s:EscapeFilename(s:GetFileName())
endfunction

function! s:EscapeFilename(name)
    return escape(a:name,s:escfilename)
endfunction


function! s:GetFullFileName()
	if getline('.') =~ '+ '
		if match(getline('.'), '(.*)') > 0
			return matchstr(getline('.'), '(\zs.*\ze)')
		else
			return strpart(getline('.'), 2, 1000)
		endif
	endif
	return s:ExtractFullFileName(getline("."))
endfunction

function! s:GetFileName()
	return s:ExtractFileName(getline("."))
endfunction

function! s:ExtractFullFileName(line)
	let fn=s:ExtractFileName(a:line)
	if fn == '/'
		return b:completePath
	else
		return b:completePath . s:ExtractFileName(a:line)
	endif
endfunction

function! s:ExtractFileName(line)
	return substitute(strpart(a:line,0,b:maxFileLen),'\s\+$','','')
endfunction

"---
" Get the size of the file
function! s:ExtractFileSize(line)
	if (w:longlist==0)
		return getfsize(s:ExtractFileName(a:line))
	else
		return strpart(a:line,b:maxFileLen+2,b:maxFileSizeLen);
	endif
endfunction

"---
" Get the date of the file as a number
function! s:ExtractFileDate(line)
	if w:longlist==0
		return getftime(s:ExtractFileName(a:line))
	else
		return strpart(matchstr(strpart(a:line,b:maxFileLen+b:maxFileSizeLen+4),"«.*"),1) + 0
	endif
endfunction


"---
" Add the header with help information
"
function! s:AddHeader()
	let save_f=@f
	1
	if w:longhelp==1
		let @f="\" <enter> : open file or directory\n"
			\."\" S : open the file/folder with external program\n"
			\."\" o : open new window for file/directory\n"
			\."\" O : open file in previously visited window\n"
			\."\" p : preview the file\n"
			\."\" i : toggle size/date listing\n"
			\."\" x : toggle show hidden files/directories\n"
			\."\" s : select sort field    r : reverse sort\n"
			\."\" - : go up one level      c : cd to this dir\n"
			\."\" R : rename file          D : delete file\n"
			\."\" f : add current directory to favourites\n"
			\."\" :help file-explorer for detailed help\n"
	else
		let @f="\" Press ? for keyboard shortcuts\n"
	endif
	let @f=@f."\" Sorted by ".w:sortdirlabel.w:sorttype.b:suffixeslast.b:filtering."\n"
	let @f=@f."\"= ".b:completePath."\n"
	put! f
	let @f=save_f
endfunction

function! s:PrintFavDirs()
	if !exists('s:favDirs')
		return
	end
	setlocal modifiable
	0
	if search('^"=')
		exe  'silent! 1,'.line('.').' g/^+ .*$/d _'
	else
		call s:CleanUpHistory()
		setlocal nomodifiable nomodified
		return
	endif
	call s:CleanUpHistory()
	let favDirs = s:favDirs
	let favDirs = substitute(favDirs, "\\(^\\|\n\\)", '\1+ ', 'g')
	let favDirs = substitute(favDirs, '$', "\n", '')
	0
	call search('^"=')
	silent! put!=favDirs
	silent! g/^+ /s/\v^\+ (.*)\/([^\/]+\/=)$/+ \2 (\1\/\2)
	call s:CleanUpHistory()
	call s:CleanUpHistory()
	setlocal nomodifiable nomodified
endfunction

"---
" Show the size and date for each file
"
function! s:AddFileInfo()
	let save_sc = &sc
	set nosc

	" Mark our starting point
	normal! mt

	call s:RemoveSeparators()

	" Remove all info
	0
	/^"=/+1,$g/^/call setline(line("."),s:GetFileName())
	call s:CleanUpHistory()

	" Add info if requested
	if w:longlist==1
		" Add file size and calculate maximum length of file size field
		let b:maxFileSizeLen = 0
		0
		/^"=/+1,$g/^/let fn=s:GetFullFileName() |
			\let fileSize=getfsize(fn) |
			\let fileSizeLen=strlen(fileSize) |
			\if fileSizeLen > b:maxFileSizeLen |
			\   let b:maxFileSizeLen = fileSizeLen |
			\endif |
			\exec "normal! ".(b:maxFileLen-strlen(getline("."))+2)."A \<esc>" |
			\exec 's/$/'.fileSize.'/'
		call s:CleanUpHistory()

		" Right justify the file sizes and
		" add file modification date
		0
		/^"=/+1,$g/^/let fn=s:GetFullFileName() |
			\exec "normal! A \<esc>$b".(b:maxFileLen+b:maxFileSizeLen-strlen(getline("."))+3)."i \<esc>\"_x" |
			\exec 's/$/ '.escape(s:FileModDate(fn), '/').'/'
		call s:CleanUpHistory()
		setlocal nomodified
	endif

	call s:AddSeparators()

	" return to start
	normal! `t

	let &sc = save_sc
endfunction


"----
" Get the modification time for a file
"
function! s:FileModDate(name)
	let filetime=getftime(a:name)
	if filetime > 0
		return strftime(g:explDateFormat,filetime) . " «" . filetime
	else
		return ""
	endif
endfunction

"---
" Delete a file or files
"
function! s:DeleteFile() range
	let oldRep = &report
	let &report = 1000

	let filesDeleted = 0
	let stopDel = 0
	let delAll = 0
	let currLine = a:firstline
	let lastLine = a:lastline
	setlocal modifiable

	while ((currLine <= lastLine) && (stopDel==0))
		exec(currLine)
		let fileName=s:GetFullFileName()
		if isdirectory(fileName)
			echo fileName." : Directory deletion not supported yet"
			let currLine = currLine + 1
		else
			if delAll == 0
				let sure=input("Delete ".fileName." (y/n/a/q)? ")
				if sure=="a"
					let delAll = 1
				endif
			endif
			if (sure=="y") || (sure=="a")
				let success=delete(fileName)
				if success!=0
					exec (" ")
					echo "\nCannot delete ".fileName
					let currLine = currLine + 1
				else
					d _
					let filesDeleted = filesDeleted + 1
					let lastLine = lastLine - 1
				endif
			elseif sure=="q"
				let stopDel = 1
			elseif sure=="n"
				let currLine = currLine + 1
			endif
		endif
	endwhile
	echo "\n".filesDeleted." files deleted"
	let &report = oldRep
	setlocal nomodified
	setlocal nomodifiable
endfunction

"---
" Rename a file
"
function! s:RenameFile()
	let fileName=s:GetFullFileName()
	setlocal modifiable
	if isdirectory(fileName)
		echo "Directory renaming not supported yet"
	elseif filereadable(fileName)
		let altName=input("Rename ".fileName." to : ")
		echo " "
		if altName==""
			setlocal nomodifiable
			return
		endif
		let success=rename(fileName, b:completePath.altName)
		if success!=0
			echo "Cannot rename ".fileName. " to ".altName
		else
			echo "Renamed ".fileName." to ".altName
			let oldRep=&report
			set report=1000
			" e!
			" instead of generating a bufEnter event if we use e!, use EditDir. It
			" doesnt matter that EditDir() is called with more than 0 arguments
			" whether or not winmanager is active because at this location, we have
			" a buffer open anyway.
			call s:EditDir(b:completePath, 1)
			let &report=oldRep
		endif
	endif
	setlocal nomodified
	setlocal nomodifiable
	call s:RestoreFileDisplay()
endfunction

"---
" Toggle between short and long help
"
function! s:ToggleHelp()
	if exists("w:longhelp") && w:longhelp==0
		let w:longhelp=1
		let s:longhelp=1
	else
		let w:longhelp=0
		let s:longhelp=0
	endif
	" Allow modification
	setlocal modifiable
	call s:UpdateHeader()
	" Disallow modification
	setlocal nomodifiable
endfunction

"---
" Update the header
"
function! s:UpdateHeader()
	let oldRep=&report
	set report=10000
	" Save position
	normal! mt
	" Remove old header
	0
	1,/^"=/ d _
	call s:CleanUpHistory()
	" Add new header
	call s:AddHeader()
	" Go back where we came from if possible
	0
	if line("'t") != 0
		normal! `t
	endif

	let &report=oldRep
	setlocal nomodified
endfunction

"---
" Toggle long vs. short listing
"
function! s:ToggleLongList()
	setlocal modifiable
	if exists("w:longlist") && w:longlist==1
		let w:longlist=0
		let s:longlist=0
	else
		let w:longlist=1
		let s:longlist=1
	endif
	call s:AddFileInfo()
	setlocal nomodifiable
endfunction

"---
" Show all files - remove filtering
"
function! s:ShowAllFiles()
	setlocal modifiable
	let b:filterFormula=""
	let b:filtering=""
	call s:ShowDirectory()
	setlocal nomodifiable
endfunction

"---
" Figure out what section we are in
"
function! s:GetSection()
	let fn=s:GetFileName()
	let section="file"
	if fn =~ '/$'
		let section="directory"
	elseif fn =~ b:suffixesRegexp
		let section="suffixes"
	endif
	return section
endfunction

"---
" Remove section separators
"
function! s:RemoveSeparators()
  if !g:explUseSeparators
    return
  endif
  0
  silent! exec '/^"=/+1,$g/^' . s:separator . "/d _"
  call s:CleanUpHistory()
endfunction

"---
" Add section separators
"   between directories and files if they are separated
"   between files and 'suffixes' files if they are separated
function! s:AddSeparators()
  if !g:explUseSeparators
    return
  endif
  0
  /^"=/+1
  call s:CleanUpHistory()
  let lastsec=s:GetSection()
  +1
  .,$g/^/let sec=s:GetSection() |
               \if g:explDirsFirst != 0 && sec != lastsec &&
               \   (lastsec == "directory" || sec == "directory") |
               \  exec "normal! I" . s:separator . "\n\<esc>" |
               \elseif g:explSuffixesLast != 0 && sec != lastsec &&
               \   (lastsec == "suffixes" || sec == "suffixes") |
               \  exec "normal! I" . s:separator . "\n\<esc>" |
               \endif |
               \let lastsec=sec
endfunction

"---
" General string comparison function
"
function! s:StrCmp(line1, line2, direction)
	if a:line1 < a:line2
		return -a:direction
	elseif a:line1 > a:line2
		return a:direction
	else
		return 0
	endif
endfunction

"---
" Function for use with Sort(), to compare the file names
" Default sort is to put in alphabetical order, but with all directory
" names before all file names
"
function! s:FileNameCmp(line1, line2, direction)
	let f1=s:ExtractFileName(a:line1)
	let f2=s:ExtractFileName(a:line2)

	" Put directory names before file names
	if (g:explDirsFirst != 0) && (f1 =~ '\/$') && (f2 !~ '\/$')
		return -g:explDirsFirst
	elseif (g:explDirsFirst != 0) && (f1 !~ '\/$') && (f2 =~ '\/$')
		return g:explDirsFirst
	elseif (g:explSuffixesLast != 0) && (f1 =~ b:suffixesRegexp) && (f2 !~ b:suffixesRegexp)
		return g:explSuffixesLast
	elseif (g:explSuffixesLast != 0) && (f1 !~ b:suffixesRegexp) && (f2 =~ b:suffixesRegexp)
		return -g:explSuffixesLast
	else
		return s:StrCmp(f1,f2,a:direction)
	endif

endfunction

"---
" Function for use with Sort(), to compare the file modification dates
" Default sort is to put NEWEST files first.  Reverse will put oldest
" files first
"
function! s:FileDateCmp(line1, line2, direction)
	let f1=s:ExtractFileName(a:line1)
	let f2=s:ExtractFileName(a:line2)
	let t1=s:ExtractFileDate(a:line1)
	let t2=s:ExtractFileDate(a:line2)

	" Put directory names before file names
	if (g:explDirsFirst != 0) && (f1 =~ '\/$') && (f2 !~ '\/$')
		return -g:explDirsFirst
	elseif (g:explDirsFirst != 0) && (f1 !~ '\/$') && (f2 =~ '\/$')
		return g:explDirsFirst
	elseif (g:explSuffixesLast != 0) && (f1 =~ b:suffixesRegexp) && (f2 !~ b:suffixesRegexp)
		return g:explSuffixesLast
	elseif (g:explSuffixesLast != 0) && (f1 !~ b:suffixesRegexp) && (f2 =~ b:suffixesRegexp)
		return -g:explSuffixesLast
	elseif t1 > t2
		return -a:direction
	elseif t1 < t2
		return a:direction
	else
		return s:StrCmp(f1,f2,1)
	endif
endfunction

"---
" Function for use with Sort(), to compare the file sizes
" Default sort is to put largest files first.  Reverse will put
" smallest files first
"
function! s:FileSizeCmp(line1, line2, direction)
	let f1=s:ExtractFileName(a:line1)
	let f2=s:ExtractFileName(a:line2)
	let s1=s:ExtractFileSize(a:line1)
	let s2=s:ExtractFileSize(a:line2)

	if (g:explDirsFirst != 0) && (f1 =~ '\/$') && (f2 !~ '\/$')
		return -g:explDirsFirst
	elseif (g:explDirsFirst != 0) && (f1 !~ '\/$') && (f2 =~ '\/$')
		return g:explDirsFirst
	elseif (g:explSuffixesLast != 0) && (f1 =~ b:suffixesRegexp) && (f2 !~ b:suffixesRegexp)
		return g:explSuffixesLast
	elseif (g:explSuffixesLast != 0) && (f1 !~ b:suffixesRegexp) && (f2 =~ b:suffixesRegexp)
		return -g:explSuffixesLast
	elseif s1 > s2
		return -a:direction
	elseif s1 < s2
		return a:direction
	else
		return s:StrCmp(f1,f2,1)
	endif
endfunction

"---
" Sort lines.  SortR() is called recursively.
"
function! s:SortR(start, end, cmp, direction)

  " Bottom of the recursion if start reaches end
  if a:start >= a:end
    return
  endif
  "
  let partition = a:start - 1
  let middle = partition
  let partStr = getline((a:start + a:end) / 2)
  let i = a:start
  while (i <= a:end)
    let str = getline(i)
    exec "let result = " . a:cmp . "(str, partStr, " . a:direction . ")"
    if result <= 0
      " Need to put it before the partition.  Swap lines i and partition.
      let partition = partition + 1
      if result == 0
        let middle = partition
      endif
      if i != partition
        let str2 = getline(partition)
        call setline(i, str2)
        call setline(partition, str)
      endif
    endif
    let i = i + 1
  endwhile

  " Now we have a pointer to the "middle" element, as far as partitioning
  " goes, which could be anywhere before the partition.  Make sure it is at
  " the end of the partition.
  if middle != partition
	  let str = getline(middle)
	  let str2 = getline(partition)
	  call setline(middle, str2)
	  call setline(partition, str)
  endif
  call s:SortR(a:start, partition - 1, a:cmp,a:direction)
  call s:SortR(partition + 1, a:end, a:cmp,a:direction)
endfunction

"---
" To Sort a range of lines, pass the range to Sort() along with the name of a
" function that will compare two lines.
"
function! s:Sort(cmp,direction) range
	call s:SortR(a:firstline, a:lastline, a:cmp, a:direction)
endfunction

"---
" Reverse the current sort order
"
function! s:SortReverse()
	if exists("w:sortdirection") && w:sortdirection == -1
		let w:sortdirection = 1
		let w:sortdirlabel  = ""
	else
		let w:sortdirection = -1
		let w:sortdirlabel  = "reverse "
	endif
	let s:sortby=w:sortdirlabel . w:sorttype
	call s:SortListing("")
endfunction

"---
" Toggle through the different sort orders
"
function! s:SortSelect()
	" Select the next sort option
	if !exists("w:sorttype")
		let w:sorttype="name"
	elseif w:sorttype == "name"
		let w:sorttype="size"
	elseif w:sorttype == "size"
		let w:sorttype="date"
	else
		let w:sorttype="name"
	endif
	let s:sortby=w:sortdirlabel . w:sorttype
	call s:SortListing("")
endfunction

"---
" Sort the file listing
"
function! s:SortListing(msg)
    " Save the line we start on so we can go back there when done
    " sorting
    let startline = getline(".")
    let col=col(".")
    let lin=line(".")

    " Allow modification
    setlocal modifiable

    " Send a message about what we're doing
    " Don't really need this - it can cause hit return prompts
"   echo a:msg . "Sorting by" . w:sortdirlabel . w:sorttype

    " Create a regular expression out of the suffixes option in case
    " we need it.
    call s:SetSuffixesLast()

    " Remove section separators
    call s:RemoveSeparators()

    " Do the sort
    0
    if w:sorttype == "size"
      /^"=/+1,$call s:Sort("s:FileSizeCmp",w:sortdirection)
    elseif w:sorttype == "date"
      /^"=/+1,$call s:Sort("s:FileDateCmp",w:sortdirection)
    else
      /^"=/+1,$call s:Sort("s:FileNameCmp",w:sortdirection)
    endif
  	call s:CleanUpHistory()

    " Replace the header with updated information
    call s:UpdateHeader()

    " Restore section separators
    call s:AddSeparators()

    " Return to the position we started on
    0
    if search('\m^'.escape(startline,s:escregexp),'W') <= 0
      execute lin
    endif
    execute "normal!" col . "|"

    " Disallow modification
    setlocal nomodified
    setlocal nomodifiable

endfunction

if !g:defaultExplorer
	let loaded_explorer = 1
	"---
	" Create commands
	if !exists(':Explore')
		command -n=? -complete=dir Explore :call s:StartExplorer(0, '<a>')
	endif
	if !exists(':Sexplore')
		command -n=? -complete=dir Sexplore :call s:StartExplorer(1, '<a>')
	endif
	" NOTE: This is a special command NOT to be used by users. Its here for
	" communication between winmanager and explorer.vim. This command only works
	" if you are currently 'editing' a directory, in which case, you dont need
	" this anyway. USE AT YOUR OWN RISK.
	if !exists(':ExploreInCurrentWindow')
		command -n=? -complete=dir ExploreInCurrentWindow :call <SID>EditDir()
	endif
end

" CleanUpHistory
function! <SID>CleanUpHistory()
  call histdel("/", -1)
  let @/ = histget("/", -1)
endfunction

function! <SID>ToggleShowHiddenFiles()
  let g:explShowHiddenFiles = !g:explShowHiddenFiles
  call <SID>EditDir(b:completePath,1)
  call <SID>RestoreFileDisplay()
endfunction

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save


" vim: ts=4:noet:sw=4
plugin/winmanager.vim	[[[1
1470
"=============================================================================
"        File: winmanager.vim
"      Author: Srinath Avadhanula (srinath@eecs.berkeley.edu)
" Last Change: 2006-02-26 20:11:19
"        Help: winmanager.vim is a plugin which implements a classical windows
"              type IDE in Vim-6.0.  When you open up a new file, simply type
"              in :WMToggle. This will start up the file explorer.
"
"
" NOTE:  Starting from winmanager-2.x you can add new plugins to winmanager
" and also customize the window layout in your .vimrc
"
" See ":help winmanager" for additional details.
" ============================================================================

" quit if the user doesnt want us or if we are already loaded.
if exists("loaded_winmanager")
	finish
end
let loaded_winmanager = 1

" width of the explorer windows 
if !exists("g:winManagerWidth")
	let g:winManagerWidth = 25
end

" whether to close winmanager if only explorer windows are visible.
if !exists("g:persistentBehaviour")
	let g:persistentBehaviour = 1
end

" default window layout
if !exists("g:winManagerWindowLayout")
	let g:winManagerWindowLayout = "FileExplorer,TagsExplorer|BufExplorer"
end

" default window align
if !exists("g:winManagerOnRightSide")
	let g:winManagerOnRightSide = 0
end

" auto open winmanager
if !exists("g:winManagerAutoOpen")
	let g:winManagerAutoOpen = 0
end

" use default explorer plugin which ships with vim.
if !exists("g:defaultExplorer")
	let g:defaultExplorer = 1
end

" commands
" toggling between the windows manager open or closed. this can also be used
" to start win manager.
if !exists(':WMToggle')
	command -nargs=0 WMToggle :silent call <SID>ToggleWindowsManager()
end

" WManager and WMclose still exist for backward compatibility, but their use
" is deprecated because WMToggle has the functionality of both of them.
if !exists(':WManager')
	command -nargs=0 WManager :silent call <SID>StartWindowsManager()
end
if !exists(':WMClose')
	command -nargs=0 WMClose :silent call <SID>CloseWindowsManager()
end
if !exists(':WMReset')
	command -nargs=0 WMReset :silent call <SID>WinManagerReset()
end
" command to go to either the first explorer window visible
if !exists(':FirstExplorerWindow')
	command -nargs=0 FirstExplorerWindow :silent call <SID>GotoExplorerWindow('1')
end
" command to go to either the last explorer window visible
if !exists(':BottomExplorerWindow')
	command -nargs=0 BottomExplorerWindow :silent call <SID>GotoExplorerWindow('$')
end

" this command is used internally by winmanager. shouldnt be of concern to the
" user.
if !exists(':WinManagerGotoNextInGroup')
	command -nargs=1 WinManagerGotoNextInGroup :silent call <SID>GotoNextExplorerInGroup(<args>)
end	
if !exists(':WinManagerGotoPrevInGroup')
	command -nargs=1 WinManagerGotoPrevInGroup :silent call <SID>GotoNextExplorerInGroup(<args>,-1)
end	

" nifty command for debugging. SVarValueWinManager 'MRUList' will echo the
" value of 's:MRUList' for instance. to be used for debugging winmanager.
" shouldn't be of interest to the user.
if !exists(':SVarValueWinManager')
	command -nargs=* SVarValueWinManager :call <SID>ShowVariableValue(<args>)
end

" characters that must be escaped for filenames
if has("dos16") || has("dos32") || has("win16") || has("win32") || has("os2")
	let s:escfilename = ' %#'
else
	let s:escfilename = ' \%#'
endif

" a quick way to "uncomment" all the debug print statements.
let g:debugWinManager = 1
let g:numRefs = 0

" initialization.
let s:numExplorerGroups = 0
let s:numExplorers = 0
let s:commandRunning = 0

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

" Automatically open the WinManager
if g:winManagerAutoOpen
	autocmd VimEnter * nested call s:StartWindowsManager()|1wincmd w
endif

"---
" this function creates a variable 
" s:explorerGroup_i
" for the i^th time it is called. This variable will be of the form
" s:explorerGroup_i = ",member1,member2,member3,"
"
" this provides a way to "group" various explorers into common groups, so that
" one of them will be visible at a time.
"
function! <SID>RegisterExplorerGroup()
	" g:winManagerWindowLayout is of the form
	" 'FileExplorer,TagsExplorer|BufExplorer'
	
	" begin extracting groups from the layout variable.
	let groupNum = 1
	while 1
		" if no more groups then break.	
		let curGroup = s:Strntok(g:winManagerWindowLayout, '|', groupNum)
		if curGroup == ''
			break
		end
		
		" otherwise extract the explorers belonging to this group and the
		" explorer ID's etc. also protect against the same explorer being put
		" in 2 groups.
		let grplist = ','
		let numlist = ','
		let curgn = s:numExplorerGroups + 1

		let i = 1
		while 1
			let name = s:Strntok(curGroup, ',', i)
			if name == ''
				break
			end
			" refuse to register an explorer twice, or if the explorer's title
			" doesnt exist.
			if exists('s:'.name.'_numberID') || !exists('g:'.name.'_title')
				if  !exists('g:'.name.'_title')
					if has('gui_running')
						call confirm(name." is registered as a plugin, but I cannot seem to find it anywhere.\n"
							\.'Make sure you have downloaded the relevant plugin or change the g:winManagerWindowLayout variable',
							\"&ok", 1, 'Warning')
					else
						echohl Error
						echomsg name." is registered as a plugin, but I cannot seem to find it anywhere."
							\.'Please make sure you have downloaded the relevant plugin'
						echohl None
					endif
				endif
				let i = i + 1
				continue
			end

			let s:numExplorers = s:numExplorers + 1
			let num = s:numExplorers

			exe 'let s:explorerName_'.num.' = name'

			let grplist = grplist.name.","
			let numlist = numlist.''.num.','

			" create variables of the form ExplorerName_<group/member/number>ID
			" which contains which group the explorer belongs to and its member
			" number within that group and also its number
			" this will create a variable of the form
			exe 'let s:'.name.'_groupID  = "'.curgn.'"'
			exe 'let s:'.name.'_memberID = "'.i.'"'
			exe 'let s:'.name.'_numberID = "'.num.'"'

			let i = i + 1
		endwhile
		if grplist == ','
			return
		end

		let s:numExplorerGroups = s:numExplorerGroups + 1

		exe 'let s:explorerGroup_'.curgn.' = grplist'
		exe 'let s:explorerGroupNums_'.curgn.' = numlist'
		exe 'let s:numMembers_'.curgn.' = a:0'

		let groupNum = groupNum + 1
	endwhile

endfunction


"---
" initializes the window manager. sets the initial layout. as of now, the
" layout of the explorer windows (i.e, which plugin appears above or below the
" other) depends on the order in which the plugins are sourced. 
" TODO: make this easily user customizable later.
"       Done! See comments about registration.
"
" this function opens each "registered" plugin in its appropriate position. it
" also starts off the autocommand which makes dynamic updating of buffers
" possible.
"
function! <SID>StartWindowsManager()
	call WM_ERRORMSG('+StartWindowsManager')
	" for the first few versions of winmanager, if no registration is done,
	" assume the following default configuration of the windows:
	"    (FileExplorer, TagsExplorer)
	"    (BufExplorer)
	" This allows for an "easy" distribution. i.e, the installation will not
	" break if the user is careless with his .vimrc
	let oldRep=&report
	let save_sc = &sc
	set report=10000 nosc
	if s:numExplorers == 0
		call s:RegisterExplorerGroup()
	end
	let nothingShown = 1
	call WinManagerSuspendAUs()

	if !exists("s:MRUList")
		call s:InitializeMRUList()
	end
	let currentWindowNumber = winnr()

	if !exists("s:gotExplorerTitles")
		let s:gotExplorerTitles = 1
		let i = 1
		while i <= s:numExplorers
			exe 'let name = s:explorerName_'.i
			exe 'let s:explorerTitle_'.i.' = g:'.name.'_title'
			let i = i + 1
		endwhile
	endif

	" focus on the first visible explorer window.
	let gotvisible = 0
	let i = 1
	while i <= s:numExplorerGroups
		" check if the ith explorer is visible.
		let windownum = s:IsExplorerGroupVisible(i)
		if windownum != -1
			call s:GotoWindow(windownum)
			let gotvisible = 1
			" cen is the "current explorer number". used while restoring the
			" layout.
			let cen = i
			let nothingShown = 0
			break
		end
		let i = i + 1
	endwhile

	" split the current window or vsplit a new window for the explorers if
	" none of the explorers is visible.
	if !gotvisible
		if exists('s:lastMemberDisplayed_1')
			let lastmem = s:lastMemberDisplayed_1
		else
			let lastmem = 1
		end
		let somethingDisplayed = s:EditNextVisibleExplorer(1, lastmem-1, 1, 'vsplit')
		" if nothing was displayed this time, there is a possiblity it could
		" happen later during one of the refresh cycles. remember this for
		" then.
		if !somethingDisplayed
			let s:tryGroupAgain_1 = 1
			q
		else
			let s:tryGroupAgain_1 = 0
			let nothingShown = 0
			let currentWindowNumber = currentWindowNumber + 1
		end
		let cen = 1
		if g:winManagerOnRightSide
			wincmd L
		else
			wincmd H
		end
		" set up the correct width
		exe g:winManagerWidth.'wincmd |'
	end

	" now we are on one of the explorers. time to redo the original layout.
	let _split = &splitbelow
	let i = 1
	while i <= s:numExplorerGroups
		" for each group, see if any member of it is visible.
		let windownum = s:IsExplorerGroupVisible(i)
		
		" if this explorer group is not visible, then open the first plugin
		" belonging to this group
		if windownum == -1

			" if this explorer group is "before" the cen, then split above, else
			" below. except for the first time when this could possibly be
			" true, it always evaluates to the else.
			if i < cen
				set nosplitbelow
			else
				set splitbelow
			end
			" find the last plugin belonging to this "group" which was
			" displayed.
			if exists('s:lastMemberDisplayed_'.i)
				exe 'let lastmem = s:lastMemberDisplayed_'.i
			else
				let lastmem = 1
			end
			" try to display either that plugin or the one after it.
			let somethingDisplayed = s:EditNextVisibleExplorer(i, lastmem-1,1,"split")
			if !somethingDisplayed
				exe 'let s:tryGroupAgain_'.i.' = 1'
				q
			else
				exe 'let s:tryGroupAgain_'.i.' = 0'
				" if this is the first explorer shown, need to push it to the
				" right.
				if nothingShown
					if g:winManagerOnRightSide
						wincmd L
					else
						wincmd H
					end
					" set up the correct width
					exe g:winManagerWidth.'wincmd |'
				end
				let nothingShown = 0
				let currentWindowNumber = currentWindowNumber + 1
			end
			let cen = i

		" the group is visible, go to it so we can split the one after that
		" from it.
		else
			call s:GotoWindow(windownum)
		endif

		let i = i + 1
		" cen: current explorer (group) number which was visited.
		let cen = i
	endwhile
	
	" now make the run for resizing. 
	let i = 1
	while i <= s:numExplorerGroups
		" find if its visible and the explorer of this group which is
		" currently displayed.
		let windownum = s:IsExplorerGroupVisible(i)
		" need to check because some of the explorer groups might not have
		" been displayed, if all their members were unable to display
		" anything.
		if windownum == -1
			let i = i + 1
			continue
		end
		let numexp = s:WhichMemberVisible(i)
		
		" visible, goto that window. 
		call s:GotoWindow(windownum)
		exe 'let name = s:explorerName_'.numexp
		" if this is not occupying the entire height of the window, then call
		" its ReSize() function (if it exists).
		if exists('*'.name.'_ReSize') && !s:IsOnlyVertical()
			exe 'call '.name.'_ReSize()'
		end
		let i = i + 1
	endwhile
	call WM_ERRORMSG('~StartWindowsManager: done starting explorers and resizing')

	let &splitbelow = _split

	augroup WinManagerRefresh
		au!
		" Thomas Regner <regner.dievision.de> suggested i use the following
		" autocmds instead, to automatically skip refreshing on [No Files] and
		" such...
		" au BufEnter ^[^\[]* call <SID>RefreshWinManager()
        " au BufDelete ^[^\[]* call <SID>RefreshWinManager("BufDelete")
		au BufEnter * call <SID>RefreshWinManager()
		au BufDelete * call <SID>RefreshWinManager("BufDelete")
	augroup END
	call WM_ERRORMSG('~StartWindowsManager: done setting up ACs')

	call WinManagerSuspendAUs()
	call s:GotoWindow(currentWindowNumber)
	call WinManagerResumeAUs()

	" RepairAltRegister needs to be called here as well, because 
	" 1. when winmanager is re-started, we need to restore the @# register to
	"    what it was.
	" 2. if winmanager is started for the first time, then we need to ensure
	"    that @# is at least not one of the explorer windows.
	call WM_ERRORMSG('~StartWindowsManager: calling RepairAltRegister')
	if buflisted(bufnr('%'))
		call s:RepairAltRegister()
	end
	call WinManagerResumeAUs()
	let &report=oldRep
	let &sc = save_sc
	if nothingShown
		echomsg "[ no valid explorers available. winmanager will start when next possible ]"
	end
	call WM_ERRORMSG('-StartWindowsManager')
endfunction

"---
" if this window occupies the entire height of the screen, return 1, else
" return 0. i.e return 1 if there is no window above or below this window.
"
function! <SID>IsOnlyVertical()
	let _eventignore = &eventignore
	set eventignore+=WinEnter,WinLeave
	let curwin = winnr()
	wincmd k
	let onlyVertical = 1
	if curwin != winnr()
		wincmd j
		let onlyVertical = 0
	else
		wincmd j
		if winnr() != curwin
			wincmd k
			let onlyVertical = 0
		end
	end
	let &eventignore = _eventignore
	return onlyVertical
endfunction

"---
" this function first takes focus to the last listed file being edited and
" then depending on the users action and modified, etc opens the file bufName
" either on it or splits a new window etc.
"
function! WinManagerFileEdit(bufName, split)
	" this function is usually _not_ triggered from an autocommand, so the
	" movement commands in this function will trigger RefreshWinManager().
	" make that do nothing with this flag.
	call WinManagerSuspendAUs()
	let oldRep=&report
	let save_sc = &sc
	set report=10000 nosc
	
	" if the file is already visible somewhere just go there.
	" a:bufName is a fully qualified filename of the form
	"    e:/path/to/file
	" now bufnr('e:/path/to/file') != -1 even in the case where a file called
	" e:/path/to/file/other/name is opened. (this is bufnr()'s behavior).
	" therefore make an additional check so were protected against false
	" matches.
	if ! type(a:bufName) " If number.
		let bufNr = a:bufName
		let bufName = expand('#'.bufNr.':p')
	else
		let bufNr = bufnr(a:bufName)
		let bufName = a:bufName
	endif
	if bufwinnr(bufNr) != -1 && bufName == expand('#'.bufNr.':p')

		call s:GotoWindow(bufwinnr(bufNr))
		" however, we still have to repair the @# register
		call s:RepairAltRegister()

	" otherwise goto the last listed buffer being edited.
	else 

		" if we had already opened this file, then use the #n notation instead
		" of opening by file name. this preserves cursor position.
		if bufNr != -1 && bufName == expand('#'.bufNr.':p')
			let bufcall = '#'.bufNr
		else
			let bufcall = bufName
		end

		let repairAltReg = 0
		let lastBufferNumber = s:MRUGet(1)
		" if the last accessed buffer is visible, then goto it.
		if bufwinnr(lastBufferNumber) != -1
			" the fact that we go to the last listed buffer and then open this
			" buffer automatically protects the @# register.
			call s:GotoWindow(bufwinnr(bufnr(lastBufferNumber)))
			" now split it or not depending on stuff.
			if (&modified && !&hidden) || a:split
				split
			endif
		else
			if s:GotoEditingArea()
				" otherwise goto _some_ file in the editing area.
				if (&modified && !&hidden) || a:split
					split
				end
				let repairAltReg = 1
			else
				" we cannot go to _any_ non-explorer window. 
				" means that the explorer buffers are the only windows visible.
				" this means that the layout has to be redone by v-splitting a new
				" window for this file.
				" first open the alternate file just to retain @# if its still
				" listed. 
				if buflisted(lastBufferNumber)
					exe 'silent! vsplit #'.lastBufferNumber
				else
					vsplit
				end
				" now push this to the very right
				if g:winManagerOnRightSide
					wincmd H
				else
					wincmd L
				end
				" calculate the width of this window and reset it.
				exe &columns-g:winManagerWidth.' wincmd |'
				let repairAltReg = 1
			endif
		end
		if bufName != ''
			exe 'silent! e '.escape(bufcall, " ")
		else
			exe 'silent! buffer '.bufNr
		endif
		if repairAltReg
			call s:RepairAltRegister()
		endif
	end

	call WinManagerResumeAUs()

	" call Refresh incase this fileopen made some displays invalid.
	call WM_ERRORMSG('~WinManagerFileEdit: calling RefreshWinManager')
	call s:RefreshWinManager()
	let &report=oldRep
	let &sc = save_sc
endfunction

"---
" function to repair the @# register.
"
" quickly edit the alternate buffer previously being edited in the
" FileExplorer area so that the % and # registers are not screwed with.
" This function must be called while focus is on a listed buffer which needs
" to be made @%.
"
function! <SID>RepairAltRegister()
	call WM_ERRORMSG('+RepairAltRegister')
	call WinManagerSuspendAUs()

	" setting hidden while going back and forth is very wise because sometimes
	" this function is used from within an autocommand. in such cases,
	" switching back and forth between buffers makes the syntax highlighting
	" dissapear.
	let _hidden = &l:bufhidden
	setlocal bufhidden=hide
	let oldRep=&report
	let save_sc = &sc
	set report=10000 nosc

	let currentBufferNumber = bufnr('%')
	let currentBufferName = expand('%:p')
	let alternateBufferNumber = s:MRUGet(2)

	" if the required alternatebuffer exists, then first edit it to preserve @#
 	if alternateBufferNumber != bufnr("#") 
		\ && alternateBufferNumber != -1
		\ && buflisted(alternateBufferNumber)
 		exec 'silent! b! '.alternateBufferNumber
	elseif alternateBufferNumber == -1
		" if the alternate buffer doesnt exist, then ensure that @# = -1.
		" ideally vim would have made the @# writable, but since it isn't we
		" need to resort to the hack of editing a temporary file and wiping it
		" out.
		" reuse the temp file so that buffer numbers are not generally eaten
		" up each time this needs to be done.
		if !exists('s:tempFileName')
			let s:tempFileName = tempname()
		endif
		exe "silent! e ".s:tempFileName
		setlocal nobuflisted
		setlocal nomodifiable
		setlocal bufhidden=delete
		setlocal buftype=nofile
		let tmpBufNum = bufnr('%')
		exe 'silent! b! '.currentBufferNumber
		exe 'silent! bwipeout '.tmpBufNum
		let &l:bufhidden = _hidden
		call WinManagerResumeAUs()

		let &l:bufhidden = _hidden
		let &report=oldRep
		let &sc = save_sc

		return
	end

 	" now edit the current file (to preserve @% :-) )
	" it seems that using ":b !" is _very_ important to preserve syntax
	" highlighting. if ":e #" or ":b " is used, then syntax highlighting is
	" lost and the ugly hack thing keeps getting called everytime. 
	" still dont know exactly why this is. it has something to do with
	" abandoned buffers being kept and also nested autocommands, but its not
	" very clear to me what it is.
	exec('silent! b! '.currentBufferNumber)

	" a totally ugly hack to restore syntax highlighting... i have NO idea why
	" this has to be here... somehow mixing opening files with autocommands
	" has always been very very problematic.
	" NOTE: the problem seems to have gone away now... see above comment.
	if has("syntax") && exists("g:syntax_on") && !has("syntax_items")
		call WM_ERRORMSG('needing to reset syntax!')
		do syntax
	end
	" end fugly hack.

	let &l:bufhidden = _hidden
	let &report=oldRep
	let &sc = save_sc

	call WinManagerResumeAUs()
	call WM_ERRORMSG('-RepairAltRegister')
endfunction

" GotoEditingArea: goes to the first visible non-explorer window {{{
" Description: 
function! <SID>GotoEditingArea()
	let i = 1
	while 1
		if winbufnr(i) < 0
			return 0
		endif
		if !s:IsExplorerBuffer(winbufnr(i))
			call s:GotoWindow(i)
			return 1
		endif
		let i = i + 1
	endwhile
endfunction " }}}

"---
" the main function. this is responsible for updating plugins dynamically.
" this function is triggered on the BufEnter and BufDelete events. every time
" it is called, it makes a pass through all visible plugins and if their
" display is not valid, it calls their Start() function.
"
" if this function is called with no arguments, it is assumed to be triggered
" from a BufEnter even or due to a forcible refresh. If it is called with one
" argument called "BufDelete", then it is assumed that it is triggered from
" the BufDelete event.
"
function! <SID>RefreshWinManager(...)
	" refreshes the window layout and the displayes of windows which trigger
	" on autocommands.
	
	if a:0 > 0 && a:1 == "Bufdelete"
		call WM_ERRORMSG('+RefreshWinManager: Bufdelete due to '.bufname(expand('<abuf>')).' ('.expand('<abuf>').')')
	else
		call WM_ERRORMSG('+RefreshWinManager: BufEnter due to '.bufname(bufnr('%')).' ('.bufnr('%').')')
	end

	" make a note of whether this refresh was triggered by the BufDelete event
	" or not.
	let _split = &splitbelow
	if a:0 > 0 && a:1 == "BufDelete"
		let BufDelete = 1
	else
		let BufDelete = 0
	end
	" do the push pop thing irrespective of whether we do the rest of the
	" stuff or not.
	if BufDelete
		call s:MRUPop()
	else
		call s:MRUPush()
	end
	" if this autocommand was triggered because of internal movements/commands
	" due to other winmanager commands, then quit.
	if WinManagerAUSuspended()
		return
	end
	" check if only explorer windows are visible and if so quit if we dont
	" want persistent behavior.
	if !g:persistentBehaviour && s:OnlyExplorerWindowsOpen()
		qa
	end
	
	" this magic statement is curing the syntax losing problem. WHY?
	call WinManagerSuspendAUs()
	let g:numRefs = g:numRefs + 1

	" remember this window number because we will return to it after
	" refreshing the buffer listing.
	let currentWindowNumber = winnr()
	let curBufListed = buflisted(bufnr('%'))
	let cfn = s:Path(expand("%:p"))

	" now cycle through all the visible explorers and and for each "invalid"ly
	" displayed explorer call its corresponding refresh and resize functions.
	let i = 1
	while i <= s:numExplorerGroups  && curBufListed
		" find if its visible and the explorer of this group which is
		" currently displayed.
		let windownum = s:IsExplorerGroupVisible(i)
		" if this explorer is visible, then call its _IsValid() function, etc.
		if windownum == -1
			let i = i + 1
			continue
		end
		let numexp = s:WhichMemberVisible(i)
		" visible, goto that window.
		call s:GotoWindow(windownum)
		exe 'let name = s:explorerName_'.numexp

		exe 'let explorerName = s:explorerName_'.numexp
		exe 'let isvalid = '.explorerName.'_IsValid()'
		" ... and if it isnt then update it.
		if !isvalid
			call <SID>GotoWindow(windownum)
			exe 'call '.explorerName.'_Start()'
			if exists('*'.explorerName.'_ReSize') && !s:IsOnlyVertical()
				exe 'call '.explorerName.'_ReSize()'
			end
		end
		let i = i + 1
	endwhile

	" this while loop handles the case where a group of explorers are was not
	" valid at some point and therefore didnt occupy a window, but became
	" valid after some point and therefore need to obtain a seperate window.
	let i = 1
	while i <= s:numExplorerGroups && curBufListed
		exe 'let retry = s:tryGroupAgain_'.i
		" only do this if we need to retry opening this buffer. we should not
		" keep opening a group which the user has closed using a ":quit"
		" command.
		if retry
			" find the 'nearest' group which is open.
			let nearestGroup = 'inf'
			let nearestWindow = 'inf'
			" TODO: possible bug: what if there are more than a million
			" plugins being used? :-)
			let nearestGroupDist = 1000000
			let j = 1
			while j <= s:numExplorerGroups
				
				let windownum = s:IsExplorerGroupVisible(j)
				if windownum != -1
					let dist = ( (j-i) < 0 ? (i-j) : (j-i) )
					if dist < nearestGroupDist
						let nearestGroupDist = dist
						let nearestGroup = j
						let nearestWindow = windownum
					end
				end
				let j = j + 1
			endwhile

			" if nearestWindow is 'inf', it means no other explorer plugins
			" are open. which means that this thing needs to go the very
			" right.
			if nearestWindow == 'inf'
				let ecmd = 'vsplit'
			else
				let ecmd = 'split'
				if nearestGroup > i
					setlocal nosplitbelow
				else
					setlocal splitbelow
				end
			end
			let somethingDisplayed = s:EditNextVisibleExplorer(i, 0, 1, ecmd)
			" if nothing was displayed this time, there is a possiblity it could
			" happen later during one of the refresh cycles. remember this for
			" then.
			if !somethingDisplayed
				exe 'let s:tryGroupAgain_'.i.' = 1'
				q
			else
				exe 'let s:tryGroupAgain_'.i.' = 0'
				let currentWindowNumber = currentWindowNumber + 1
				exe 'let name = s:explorerName_'.somethingDisplayed
				if exists('*'.name.'_ReSize') && !s:IsOnlyVertical()
					exe 'call '.name.'_ReSize()'
				end
				if nearestWindow == 'inf'
					if g:winManagerOnRightSide
						wincmd L
					else
						wincmd H
					end
					" set up the correct width
					" set width only if we are creating a new window...
					exe g:winManagerWidth.'wincmd |'
				end
			end
		end
		let i = i + 1
	endwhile

	call s:ResizeAllExplorers()

	" refreshing done, now return back to where we were originally.
	call <SID>GotoWindow(currentWindowNumber)
	
	" however, we still have to "repair" the actual @% and @# registers, in
	" case we are returning to a listed buffer.  also should do this only for
	" a BufEnter event. For a BufDelete event, the do this only if the current
	" buffer is not the buffer being deleted.
	if buflisted(bufnr("%")) && !isdirectory(bufname("%")) && 
	\	( !BufDelete || ( bufnr('%') != expand('<abuf>') ) )
		call <SID>RepairAltRegister()
	end

	call WinManagerResumeAUs()
	let &splitbelow = _split
endfunction

function! <SID>ResizeAllExplorers()
	let i = 1
	while i <= s:numExplorers
		let explorerWinNum = s:IsExplorerVisible(i)
		if explorerWinNum != -1
			exe 'let explorerName = s:explorerName_'.i
			if exists('*'.explorerName.'_ReSize') && !s:IsOnlyVertical()
			" if a resize() function exists for this explorer and there
			" is some window above and/or below this window, then call its
			" resize function. this allows for dynamic resizing.
				call s:GotoWindow(explorerWinNum)
				exe 'call '.explorerName.'_ReSize()'
			end
		end
		let i = i + 1
	endwhile
endfunction

"---
" Make sure a path has proper form. 
" this function forces every path to take the following form
" dir1/dir2/file    OR
" dir1/dir2/dir/ 
" i.e, it replaces \ with / and stuff.
"
function! <SID>Path(p)
	let _p = a:p
	if a:p =~ '//$'
		return ""
	end
	if isdirectory(_p)
		let origdir= getcwd()
		exe "chdir" _p
		let _p = getcwd()
		exe "chdir" origdir
	end
	if has("dos16") || has("dos32") || has("win16") || has("win32") || has("os2")
		let _p = substitute(_p,'\\','/','g')
	endif
	if _p !~ '/$' && isdirectory(_p)
		let _p = _p.'/'
	endif
	return _p
endfunction

" goto the reqdWinNum^th window. returns 0 on failure otherwise 1.
function! <SID>GotoWindow(reqdWinNum)
	let startWinNum = winnr()
	if startWinNum == a:reqdWinNum
		return 1
	end
	if winbufnr(a:reqdWinNum) == -1
		return 0
	else
		exe a:reqdWinNum.' wincmd w'
		return 1
	end

endfunction

" returns the window number of the ith explorer if its visible, else -1
function! <SID>IsExplorerVisible(i)
	if exists('s:explorerBufNum_'.a:i)
		exe 'let explorerBufNum = s:explorerBufNum_'.a:i
	else
		let explorerBufNum = -1
	end
	return bufwinnr(explorerBufNum)
endfunction

" returns the window number of the first explorer of the ith explorer group if
" its visible, else -1
"
" if called with 2 arguments with the second being 'member', then returns the
" member number which is visible instead of its window number
"
function! <SID>IsExplorerGroupVisible(i, ...)
	" numList : the list of explorer numbers belonging to this group
	exe 'let numList = s:explorerGroupNums_'.a:i
	" ncl : next comma location
	" pcl : previous comma location
	let pcl = 0
	let ncl	= match(numList, ',', pcl + 1)
	while ncl != -1
		exe 'let num = '.strpart(numList, pcl + 1, ncl - pcl - 1)
		if s:IsExplorerVisible(num) != -1
			if a:0 == 1 && a:1 == 'mem'
				return num
			else
				return s:IsExplorerVisible(num)
			end
		end
		let pcl = ncl
		let ncl	= match(numList, ',', pcl + 1)
	endwhile
	return -1
endfunction

" returns the member number of the first explorer of the ith explorer group if
" its visible, else -1
function! <SID>WhichMemberVisible(i)
	return s:IsExplorerGroupVisible(a:i, 'mem')
endfunction

" a handy little function for debugging.
function! WM_ERRORMSG(eline)
	if !g:debugWinManager
		return
	end
	if !exists("g:WM_ERROR")
		let g:WM_ERROR = ""
	end
	let g:WM_ERROR = g:WM_ERROR . "\n" . a:eline
endfunction

"---
" find the memn^th member's explorer number of the groupn^th explorer group
" i.e, if s:explorerGroup_2 = ",3,4,5,"
" then FindExplorerInGroup(2,3) = 5
" 
" returs -1 if its not possible.
"
function! <SID>FindExplorerInGroup(groupn, memn)
	" numList : the list of explorer numbers belonging to this group
	exe 'let numList = s:explorerGroupNums_'.a:groupn

	let num = s:Strntok2(numList, ',', a:memn)
	if num == ''
		return -1
	end
	exe 'return '.num
endfunction

"---
" goto the next explorer in the group which this one belongs to.
" if called with 2 arguments, goto the previous explorer.
"
function! <SID>GotoNextExplorerInGroup(name, ...)
	call WinManagerSuspendAUs()
	" go forward or back?
	if a:0 > 1
		let dir = -1
	else
		let dir = 1
	end

	" first extract the ID variable from the name
	exe 'let grpn = s:'.a:name.'_groupID'
	exe 'let memn = s:'.a:name.'_memberID'
	exe 'let numn = s:'.a:name.'_numberID'

	" find the number of members of this group.
	exe 'let nummems = s:numMembers_'.grpn
	if nummems == 1
		call WinManagerResumeAUs()
		return 0
	end

	if exists('*'.a:name.'_WrapUp')
		exe 'call '.a:name.'_WrapUp()'
	end

	let curbufnum = bufnr('%')
	let somethingDisplayed = s:EditNextVisibleExplorer(grpn, memn, dir, 'e')
	if !somethingDisplayed && curbufnum != bufnr('%')
	   	" now start the next explorer using its title
	   	exe 'let title = s:explorerTitle_'.numn
	   	exe 'silent! e '.title
		setlocal nobuflisted
		setlocal bufhidden=delete
		setlocal buftype=nofile
		setlocal noswapfile

		" call the Start() function for the next explorer ...
		exe 'call '.a:name.'_Start()'
		exe 'nnoremap <buffer> <C-n> :WinManagerGotoNextInGroup "'.a:name.'"<cr>'
		exe 'nnoremap <buffer> <C-p> :WinManagerGotoPrevInGroup "'.a:name.'"<cr>'
		setlocal nomodifiable
		call WinManagerForceReSize(a:name)
	end

	call WinManagerResumeAUs()
endfunction

" edit the first possible explorer after memn belonging to groun. use editcmd
" to form the new window.
function! <SID>EditNextVisibleExplorer(grpn, memn, dir, editcmd)
	
	" then try to find the number of the next member.
	let startmn = (a:memn ? a:memn : 1)
	let nextmn = a:memn + a:dir
	let editcmd = a:editcmd

	let somethingDisplayed = 0

	let once = 0
	" enter this loop at least once
	while nextmn != startmn || !once
	" cycle through the next explorers in this group finding out the next
	" explorer which says its able to display anything at all.
		let once = 1
	
		let nextEN = s:FindExplorerInGroup(a:grpn, nextmn)
		" if the next member doesnt exist wrap around.
		if nextEN == -1 
			if a:dir == 1
				let nextEN = s:FindExplorerInGroup(a:grpn, 1)
				let nextmn = 1
				continue
			else
				let nextEN = s:FindExplorerInGroup(a:grpn, nummems)
				let nextmn = nummems
				continue
			end
		end

		" if we have come back to the same explorer with every other group
		" member not able to display anything, then return.

		exe 'let name = s:explorerName_'.nextEN
		" if the _IsPossible() function doesn't exist, assume its always
		" possible to display stuff.
		let isposs = 1
		if exists('*'.name.'_IsPossible')
			exe 'let isposs = '.name.'_IsPossible()'
		end
		if isposs
			" now start the next explorer using its title
			exe 'let title = s:explorerTitle_'.nextEN
			exe 'let name = s:explorerName_'.nextEN
			" Temporarily modify isfname to avoid treating the name as a
			" pattern.
			let _isf = &isfname
			set isfname-=\
			set isfname-=[
			exe 'silent! '.editcmd.' '.escape(title, '[ ')
			let &isfname = _isf
			" use vsplitting etc only the first time things are opened.
			if editcmd != 'e'
				let editcmd = 'e'
			end
			" these are a few setting which most well-made explorers
			" already set, but just to be on the safe side.
			" TODO: rely on the explorers themselves to do this. "Explorers"
			"       such as project.vim open real files, so that these
			"       settings don't work.
			setlocal nobuflisted
			setlocal bufhidden=delete
			setlocal buftype=nofile
			setlocal noswapfile

			" call the Start() function for the next explorer ...
			exe 'call '.name.'_Start()'
			" TODO: It might not be such a good idea to set nomodifiable. If I
			"       want to get project.vim as an explorer, the following will
			"       make it not work.
			setlocal nomodifiable

			" Some explorers (such as todoexplorer.vim) might have changed the
			" MRU list by opening new windows etc. This causes the MRUList to
			" get disturbed. Restore the MRUList each time just to make sure
			" explorers such as bufexplorer which depend on the MRUList
			" critically don't display faulty information.
			let g:MRUList = s:MRUList

			" and remember its buffer number for later.
			exe 'let s:explorerBufNum_'.nextEN.' = bufnr("%")'
			" also remember that this was the last explorer of this group which was
			" displayed.
			exe 'let s:lastMemberDisplayed_'.a:grpn.' = nextmn'

			" if this explorer has actually not put anything in the buffer
			" then quit and forget.
			if search('.') " line('$') > 0 && getline('$') != ''
				let somethingDisplayed = nextEN
				break
			end
		end
		" goto the next explorer of the group.
		let nextmn = nextmn + a:dir
	endwhile

	if somethingDisplayed
		" and then add this mapping to switch to the next/previous
		" explorer in this group
		exe 'nnoremap <buffer> <C-n> :WinManagerGotoNextInGroup "'.name.'"<cr>'
		exe 'nnoremap <buffer> <C-p> :WinManagerGotoPrevInGroup "'.name.'"<cr>'
	end
	return somethingDisplayed
endfunction


" goes to either the first explorer window or the last explorer window
" visible.
function! <SID>GotoExplorerWindow(which)
	call WinManagerSuspendAUs()
	" first go to either the top left or the bottom right window.
	if a:which == '1'
		" goto to the top left and move in the bottom/right direction.
		wincmd t
		let winmovecmd = 'wincmd w'
	else
		wincmd b
		let winmovecmd = 'wincmd W'
	end
	" remember the window we started from.
	let startWin = winnr()
	let firstTime = 1
	" then begin cycling through all the windows either going in the
	" bottom/right direction or the top/left direction.
	while 1
		" if we are on an explorer window quit.
		if s:IsExplorerBuffer(bufnr('%'))
			call WinManagerResumeAUs()
			return
		end
		" if we have cycled through one complete time without hitting pay
		" dirt, quit.
		if winnr() == startWin && !firstTime
			" TODO: this will screw the @% and @# register.
			break
		end
		let firstTime = 0
		exe winmovecmd
	endwhile
	call WinManagerResumeAUs()
endfunction

" returns the explorer number if an explorer plugin exists with the specified
" buffer number
function! <SID>IsExplorerBuffer(num)
	let i = 1
	while i <= s:numExplorers
		if exists('s:explorerBufNum_'.i)
			exe 'let bufnum = s:explorerBufNum_'.i
			if bufnum == a:num
				return i
			end
		end
		let i = i + 1
	endwhile
	return 0
endfunction

" toggle showing the explorer plugins.
function! <SID>ToggleWindowsManager()
	if IsWinManagerVisible()
		call s:CloseWindowsManager()
	else
		call s:StartWindowsManager()
	end
endfunction

" exported function. returns the buffer number of the last file being edited
" in the file editing area.
function! WinManagerGetLastEditedFile(...)
	if a:0 == 0
		return s:MRUGet(1)
	else
		let ret = s:MRUGet(a:1)
		if ret == ''
			" Return as type() == 0 (for number)
			return matchstr(s:MRUList, ',\zs[0-9]\+\ze,$') + 0
		else
			return ret
		end
endfunction


" exported function. returns 1 if any of the explorer windows are open,
" otherwise returns 0.
function! IsWinManagerVisible()
	let i = 1
	while i <= s:numExplorers
		if s:IsExplorerVisible(i) != -1
			return 1
		end
		let i = i + 1
	endwhile
	return 0
endfunction


" close all the visible explorer windows.
function! <SID>CloseWindowsManager()
	call WinManagerSuspendAUs()

	let i = 1
	while i <= bufnr('$')
		let explNum = s:IsExplorerBuffer(i)
		if explNum > 0 && bufwinnr(i) != -1
			exe 'bd '.i
		end
		let i = i + 1
	endwhile

	call WinManagerResumeAUs()
endfunction

" provides a way to examine script local variables from outside the script.
" very handy for debugging.
function! <SID>ShowVariableValue(...)
	let i = 1
	while i <= a:0
		exe 'let arg = a:'.i
		if exists('s:'.arg) ||
		\  exists('*s:'.arg)
			exe 'let val = s:'.arg
			echomsg 's:'.arg.' = '.val
		end
		let i = i + 1
	endwhile
endfunction

" the following functions are hooks provided by winmanager to external plugins
" as a way to get winmanager to stop getting triggered on AUs. This is useful
" when an explorer plugin triggers a BufEnter or BufDelete *internally*. For
" example, bufexplorer.vim's "delete buffer" function triggers a BufDelete
" function.
"
function! WinManagerSuspendAUs()
	let s:commandRunning = s:commandRunning + 1
endfunction
function! WinManagerResumeAUs()
	let s:commandRunning = s:commandRunning - 1
endfunction
function! WinManagerAUSuspended()
	return s:commandRunning > 0
endfunction

" Another hook provided by winmanager. Normally winmanager will call the
" plugins resize function every time the BufEnter or BufDelete event is
" triggered. However, sometimes a plugin might change the number of lines
" *internally*. In this case, the plugin could make a call to this function
" which will make a safety check and then call its resize function.
"
function! WinManagerForceReSize(explName)
	if !exists('s:'.a:explName.'_numberID') || !exists('*'.a:explName.'_ReSize')
		return
	end
	exe 'let explNum = s:'.a:explName.'_numberID'
	call WinManagerSuspendAUs()
	let windowNum = s:IsExplorerVisible(explNum)
	if windowNum == -1
		call WinManagerResumeAUs()
		return
	end
	call s:GotoWindow(windowNum)
	if s:IsOnlyVertical()
		call WinManagerResumeAUs()
		return
	end
	if exists('*'.a:explName.'_ReSize()')
		exe 'call '.a:explName.'_ReSize()'
	endif
	call WinManagerResumeAUs()
endfunction

" returns 1 if the only visible windows are explorer windows.
function! <SID>OnlyExplorerWindowsOpen()
	let i = 1
	" loop over all open windows
	while 1
		" if we have checked all open windows and not returned yet, then it
		" means only explorers are visible.
		if winbufnr(i) == -1
			return 1
		end
		" if this is a non-explorer window then return 0
		if !s:IsExplorerBuffer(winbufnr(i))
			return 0
		end
		let i = i + 1
	endwhile
endfunction

" MRUPush
function! <SID>MRUPush()
	if buflisted(bufnr("%")) && !isdirectory(bufname("%"))
		let _bufNbr = bufnr('%')
		let _list = substitute(s:MRUList, ','._bufNbr.',', ',', '')
		let s:MRUList = ','._bufNbr._list
		unlet _bufNbr _list
	end
endfunction

" MRUPop
function! <SID>MRUPop()
	let _bufNbr = expand('<abuf>')
	let s:MRUList = substitute(s:MRUList, ''._bufNbr.',', '', '')
	unlet _bufNbr
endfunction

" MRUGet
function! <SID>MRUGet(slot)
	let ret = s:Strntok2(s:MRUList, ',', a:slot)
	if ret == ''
		return -1
	end
	" This automatically returns the value as type() == 0 (for number)
	exe 'return '.ret
endfunction

" Strntok:
" extract the n^th token from s seperated by tok. 
" example: Strntok('1,23,3', ',', 2) = 23
fun! <SID>Strntok(s, tok, n)
	return matchstr( a:s.a:tok[0], '\v(\zs([^'.a:tok.']*)\ze['.a:tok.']){'.a:n.'}')
endfun

" Strntok2
" same as Strntok except that s is delimited by the tok character at the
" beginning and end.
" example: Strntok2(',1,23,3,', ',', 2) = 23
fun! <SID>Strntok2(s, tok, n)
	return matchstr( a:s, '\v((['.a:tok.']\zs[^'.a:tok.']*)\ze){'.a:n.'}')
endfun

" InitializeMRUList 
"
" initialize the MRU list. initially this will be just the buffers in the
" order of their buffer numbers with the @% and @# leading. The MRU list
" consists of a string of the following form: ",1,2,3,4,"
" NOTE: there are commas at the beginning and the end. this is to make
" identifying the position of buffers in the list easier even if they occur in
" the beginning or end and in situations where one buffer number is part of
" another. i.e the string "9" is part of the string "19"
" 
function! <SID>InitializeMRUList()
	let nBufs = bufnr('$')
	let _i = 1

	" put the % and the # numbers at the beginning if they are listed.
	let s:MRUList = ''
	if buflisted(bufnr("%"))
		let s:MRUList = ','.bufnr("%")
	end
	if buflisted(bufnr("#"))
		let s:MRUList = s:MRUList.','.bufnr("#")
	end
	let s:MRUList = s:MRUList.','
	
	" then proceed with the rest of the buffers
	while _i <= nBufs
		" dont keep unlisted buffers in the MRU list.
		if buflisted(_i) && bufnr("%") != _i && bufnr("#") != _i
			let s:MRUList = s:MRUList._i.','
		end
		let _i = _i + 1
	endwhile
	" Doing this makes bufexplorer.vim display the first two listed buffers as
	" @% and @# which they actually are when winmanager starts up after doing
	" something like:
	"    vim *.vim
	"    :WMtoggle
	let g:MRUList = s:MRUList
endfunction

if !g:defaultExplorer
	let loaded_explorer = 1
	"---
	" Set up the autocommand to allow directories to be edited
	"
	augroup fileExplorer
		au!
		au VimEnter * call s:EditDir("VimEnter")
		au BufEnter * call s:EditDir("BufEnter")
	augroup end
end

" handles editing a directory via winmanager.
function! <SID>EditDir(event)
	" return immediately if this isn't a directory.
	let name = expand("%")
	if name == ""
		let name = expand("%:p")
	endif
	if !isdirectory(name)
		return
	endif
	
	" if it is, then call the modified explorer.vim's Explore command.
	if a:event != "VimEnter"
 		if exists(":Explore")
 			ExploreInCurrentWindow
 		end
	end
	" if we have entered vim while editing a directory, then remove the
	" directory buffer, and start the window layout.
	" Note that we only start up winmanager in a VimEnter event because we
	" want commands such as ":e /some/dir/" within vim to have the same effect
	" as with the standard explorer.vim plugin which ships with vim.
	"
	" NOTE: if the user has chosen a layout where the FileExplorer is not at
	" the top-left, this will be unintuitive.
	if a:event == "VimEnter"
		silent! bwipeout
		
		call s:StartWindowsManager()
		call s:MRUPush()
		call s:GotoExplorerWindow('1')
 	end
endfunction

function! s:WinManagerReset()
	let groupNum = 1
	while 1
		" if no more groups then break.	
		let curGroup = s:Strntok(g:winManagerWindowLayout, '|', groupNum)
		if curGroup == ''
			break
		end
		
		" otherwise extract the explorers belonging to this group and the
		" explorer ID's etc. also protect against the same explorer being put
		" in 2 groups.
		let grplist = ','
		let numlist = ','
		let curgn = s:numExplorerGroups + 1

		let i = 1
		while 1
			let name = s:Strntok(curGroup, ',', i)
			if name == ''
				break
			end
			silent! exec 'unlet s:'.name.'_numberID'
			let i = i + 1
		endwhile
		let groupNum = groupNum + 1
	endwhile
	let s:numExplorers = 0
	let s:numExplorerGroups = 0
	silent! exec "unlet s:gotExplorerTitles"
endfunction

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save
" vim:ts=4:noet:sw=4
plugin/wintagexplorer.vim	[[[1
511
"=============================================================================
"        File: wintagexplorer.vim
"      Author: Srinath Avadhanula (srinath@eecs.berkeley.edu)
" Last Change: 2006-08-02 13:41:29
"        Help: This file provides a simple interface to a tags file. The tags
"              are grouped according to the file they belong to and the user can
"              press <enter> while on a tag to open the tag in an adjacent
"              window.
"
"              This file shows the implementation of an explorer plugin add-in
"              to winmanager.vim. As explained in |winmanager-adding|, this
"              function basically has to expose various functions which
"              winmanager calls during its refresh-diplay cycle. In turn, it
"              uses the function WinManagerRileEdit() supplied by
"              winmanager.vim.

" See ":help winmanager" for additional details.
" ============================================================================


" "TagsExplorer" is the "name" under which this plugin "registers" itself.
" Registration means including a line like:
"    RegisterExplorers "TagsExplorer"
" in the .vimrc. Registration provides a way to let the user customize the
" layout of the various windows. When a explorer is released, the user needs
" to know this "name" to register the plugin. 
"
" The first thing this plugin does is decide upon a "title" for itself. This is
" the name of the buffer which winmanager will open for displaying the
" contents of this plugin. Note that this variable has to be of the form:
"    g:<ExplorerName>_title
" where <ExplorerName> = "TagsExplorer" for this plugin.
let g:TagsExplorer_title = "[Tag List]"

" variables to remember the last position of the user within the file.
let s:savedCursorRow = 1
let s:savedCursorCol = 1

" skip display the error message if no tags file in current directory.
if !exists('g:TagsExplorerSkipError')
	let g:TagsExplorerSkipError = 0
end
if !exists('g:saveTagsDisplay')
	let g:saveTagsDisplay = 1
end

function! TagsExplorer_IsPossible()
	if glob('tags') == '' && g:TagsExplorerSkipError && !exists('s:tagsDisplay')
		return 0
	end
	return 1
endfunction

" This is the function which winmanager calls the first time this plugin is
" displayed. Again, the rule for the name of this function is:
" <ExplorerName>_Start()
"
function! TagsExplorer_Start()
	let _showcmd = &showcmd

	setlocal bufhidden=delete
	setlocal buftype=nofile
	setlocal modifiable
	setlocal noswapfile
	setlocal nowrap
	setlocal nobuflisted

	set noshowcmd

	" set up some _really_ elementary syntax highlighting.
	if has("syntax") && !has("syntax_items") && exists("g:syntax_on")
		syn match TagsExplorerFileName	'^\S*$'   
		syn match TagsExplorerTagName	'^  \S*' 
		syn match TagsExplorerError   '^"\s\+Error:'
		syn match TagsExplorerVariable 'g:TagsExplorerSkipError'
		syn match TagsExplorerIgnore '"$'

		hi def link TagsExplorerFileName Special
		hi def link TagsExplorerTagName String
		hi def link TagsExplorerError Error
		hi def link TagsExplorerVariable Comment
		hi def link TagsExplorerIgnore Ignore
	end

	" set up the maps.
	nnoremap <buffer> <silent> <c-]> :call <SID>OpenTag(0)<cr>
	nnoremap <buffer> <silent> <cr> :call <SID>OpenTag(0)<cr>
	nnoremap <buffer> <silent> <tab> :call <SID>OpenTag(1)<cr>
  	nnoremap <buffer> <silent> <2-leftmouse> :call <SID>OpenTag(0)<cr>
	nnoremap <buffer> <silent> <space> za
	nnoremap <buffer> <silent> <c-^> <Nop>
	nnoremap <buffer> <silent> <F5> :call <SID>DisplayTagsFile()<cr>

	call <SID>StartTagsFileDisplay()
	
	" clean up.
	setlocal nomodified
	let &showcmd = _showcmd
	unlet! _showcmd
endfunction

function! <SID>StartTagsFileDisplay()

	" if the tags were previously displayed, then they would have been saved
	" in this script variable. Therefore, just paste the contents of that
	" variable and quit.
	" instead of using just one variable, create a hash from the complete path
	" of the tags file so that tag files from multiple directories can be
	" displayed and there is caching for each of them.
	let presHash = substitute(fnamemodify('tags', ':p'), '[^a-zA-Z0-9]', '_', 'g')
	let taghash = ''
	if exists('s:tagHash_'.presHash)
		let taghash = 's:tagHash_'.presHash
		let dirhash = 's:dirHash_'.presHash
		let viewhash = 's:viewHash_'.presHash

		let s:lastHash = presHash
	elseif glob('tags') == '' && exists('s:lastHash')
		let taghash = 's:tagHash_'.s:lastHash
		let dirhash = 's:dirHash_'.s:lastHash
		let viewhash = 's:viewHash_'.s:lastHash
	end

	if taghash != ''

		setlocal modifiable
		1,$d_
		exe 'put='.taghash
		1d_
		setlocal nomodified
		setlocal nomodifiable

		" revert to the last saved view.
		exe 'call s:LoadView('.viewhash.')'
		exe 'let s:TagsDirectory = '.dirhash
		
		let s:lastHash = presHash
		return

	end

	if glob('.vimtagsdisplay') != '' && g:saveTagsDisplay


		let presHash = substitute(getcwd().'\tags', '[^a-zA-Z0-9]', '_', 'g')
		let taghash = 's:tagHash_'.presHash
		let dirhash = 's:dirHash_'.presHash
		let viewhash = 's:viewHash_'.presHash

		setlocal modifiable
		1,$ d_
		read .vimtagsdisplay
		let _a = @a
		0
		call search('^\S')
		1,.-1 d_
		normal! ggVG"ay
		exe 'let '.taghash.' = @a'
		let @a = _a
		call s:FoldTags()
		0
		setlocal nomodified
		setlocal nomodifiable

		exe 'let s:TagsDirectory = getcwd()'
		exe 'let '.dirhash.' = getcwd()'	
		exe 'let '.viewhash.' = s:MkViewNoNestedFolds()'
		let s:lastHash = presHash

		return

	elseif glob('tags') != ''


		let s:lastHash = substitute(fnamemodify('tags', ':p'), '[^a-zA-Z0-9]', '_', 'g')
		
		call <SID>DisplayTagsFile()

	else

	   call <SID>DisplayError()
	   " setting this variable results in the next invokations of
	   " TagsExplorer_IsPossible() to return 0. this makes
	   " EditNextVisibleExplorer() skip displaying the tags file the next time
	   " <C-n> is pressed.
	   let g:TagsExplorerSkipError = 1
	   return
	
	end

endfunction


function! <SID>DisplayTagsFile()

	let _showcmd = &showcmd
	let _report = &report
	set noshowcmd
	set report=10000
	setlocal modifiable

	if glob('tags') == ''
		return
	end

	1,$ d_
	silent! read tags

	" remove the leading comment lines.
	silent! % g/^!_/de
	" delete the first blank line which happens because of read
	0 d
	" if this is an empty tags file, then quit.
	if line('$') < 1 || getline(1) =~ '^\s*$'
		return
	end

	let startTime = localtime()
	% call s:GroupTags()
	let sortEndTime = localtime()
	
	call s:FoldTags()
	0
	let foldEndTime = localtime()

	let presHash = substitute(fnamemodify('tags', ':p'), '[^a-zA-Z0-9]', '_', 'g')
	let taghash = 's:tagHash_'.presHash
	let dirhash = 's:dirHash_'.presHash
	let viewhash = 's:viewHash_'.presHash

	" for fast redraw if this plugin is closed and reopened...
	let _a = @a
	normal! ggVG"ay
	exe 'let '.taghash.' = @a'
	let s:tagsDisplay = @a

	if g:saveTagsDisplay
		if glob('.vimtagsdisplay') != ''
			silent! redir! > .vimtagsdisplay
		else
			silent! redir > .vimtagsdisplay
		end
		silent! echo @a
		redir END
	end
		
	let @a = _a

	" store the directory of the current tags file location.
	exe 'let '.dirhash.' = getcwd()'
	exe 'let s:TagsDirectory = '.dirhash
	exe 'let '.viewhash.' = s:MkViewNoNestedFolds()'
	
	setlocal nomodified
	setlocal nomodifiable
	let &showcmd = _showcmd
	let &report = _report

endfunction

function! <SID>DisplayError()

	setlocal modifiable

	1,$ d_

    put='Error:'
    put=''
    put='No Tags File Found in the current directory. Try reopening WManager in a'
    put='directory which contains a tags file.'
    put=''
    put='An easy way to do this is to switch to the file explorer plugin (using <c-n>),'
    put='navigate to that directory, press \"c\" while there in order to set the pwd, and'
    put='then switch back to this view using <c-n>.'
    put=''
    put='This error message will not be shown for the remainder of this vim session.'
    put='To have it not appear at all, set g:TagsExplorerSkipError to 1 in your .vimrc'

	1d
	let _tw= &tw
	let &tw = g:winManagerWidth - 2
	normal! ggVGgq
	% s/$/"/g
	0

	let &tw = _tw

	setlocal nomodifiable
	setlocal nomodified

endfunction

function! TagsExplorer_WrapUp()
	if !exists('s:lastHash')
		return
	end
	
	let viewhash = 's:viewHash_'.s:lastHash
	exe 'let '.viewhash.' = s:MkViewNoNestedFolds()'
endfunction

function! TagsExplorer_IsValid()
	return 1
endfunction

function! <SID>OpenTag(split)
	let line = getline('.')
	" if ther is a quote at the end of the line, it means we are still
	" displaying the error message. 
	if match(line, '"$') != -1
		return
	end

	normal! 0
	" this is a tag, because it starts with a space.
	let tag = ''
	if line =~ '^\s'
		let tag = matchstr(getline('.'), '  \zs.*\ze')
		" go back and extract the file name
		let num = line('.')
		?^\S
		normal! 0
		let fname = getline('.')
		exe num
	else
		let fname = getline('.')
	end
	let _pwd = getcwd()
	exe 'cd '.s:TagsDirectory
	call WinManagerFileEdit(fnamemodify(fname, ':p'), a:split)
	exe 'cd '._pwd

	if tag != '' 
		exe 'silent! tag '.tag
	end
endfunction

" function to group tags according to which file they belong to...
" does not use the "% g" command. does the %g command introduce a O(n^2)
" nature into the algo?
function! <SID>GroupTags() range
	" get the first file
	let numfiles = 0
	
	let linenum = a:firstline

	while linenum <= a:lastline
		
		" extract the filename and the tag name from this line. this is
		" another potential speed killer.
		let tagname = matchstr(getline(linenum), '^[^\t]*\t\@=')
		let fname = matchstr(getline(linenum), '\t\zs[^\t]*\ze')

		" create a hash with this name.
		" this is the costliest operation in this loop. if the file names are
		" fully qualified and some 50 characters long, this might take very
		" long. however, every line _has_ to be processed and therefore
		" something has to be done with the filename. the only question is,
		" how clever can we get with that operation?
		let fhashname = substitute(fname, '[^a-zA-Z0-9_]', '_', 'g')

		if !exists('hash_'.fhashname)
			exe 'let hash_'.fhashname.' = ""'
			let numfiles = numfiles + 1
			exe 'let filehash_'.numfiles.' = fhashname'
			exe 'let filename_'.numfiles.' = fname'
		end
		" append this tag to the tag list corresponding to this file name.
		exe 'let hash_'.fhashname.' = hash_'.fhashname.'."  ".tagname."\n"'
		
		let linenum = linenum + 1
	endwhile
	0
	1,$ d_
	
	let i = 1
	while i <= numfiles
		$
		exe 'let hashname = filehash_'.i
		exe 'let tagsf = hash_'.hashname
		exe 'let filename = filename_'.i
		let disp = filename."\n".tagsf

		put=disp

		let i = i + 1
	endwhile
	0 d_
endfunction

function! <SID>FoldTags()
	
	setlocal foldmethod=manual
	1
	let lastLine = 1
	while 1
		if search('^\S', 'W')
			normal! k
			let presLine = line('.')
		else
			break
		end
		exe lastLine.','.presLine.' fold'
		normal! j
		let lastLine = line('.')
	endwhile
	exe lastLine.',$ fold'
endfunction

function! TE_ShowVariableValue(...)
	let i = 1
	while i <= a:0
		exe 'let arg = a:'.i
		if exists('s:'.arg) ||
		\  exists('*s:'.arg)
			exe 'let val = s:'.arg
			echomsg 's:'.arg.' = '.val
		end
		let i = i + 1
	endwhile
endfunction

" Synopsis: let foldInfo = s:MkViewNoNestedFolds()
" Description: returns the view information. This function is to be used when
"    it is known that there are no nested folds in the file (i.e folds with
"    depth > 1). when there are nested folds, this function silently ignores
"    them.
function! s:MkViewNoNestedFolds()
	let row = line('.')
	let col = virtcol('.')
	let viewInfo = row.'#'.col.'#'
	let openInfo = ''

	let i = 1
	while i <= line('$')
		if foldlevel(i) > 0
			let unfold = 0
			if foldclosedend(i) < 0
				exe i
				normal! zc
				let unfold = 1
				let openInfo = openInfo.0.','
			else
				let openInfo = openInfo.1.','
			end
			let j = foldclosedend(i)
			let viewInfo  = viewInfo.i.','.j.'|'
			if unfold
				exe i
				normal! zo
			end
			let i = j + 1
			continue
		end
		let i = i + 1
	endwhile
	
	let viewInfo = viewInfo.'#'.openInfo
	let viewInfo = substitute(viewInfo, '|#', '#', '')
	let viewInfo = substitute(viewInfo, ',$', '', '')

	exe row
	exe 'normal! '.col.'|'

	return viewInfo
endfunction

" Synopsis: call s:LoadView(foldInfo)
" Description: This function restores the view defined in the argument
"    foldInfo. See the description of MkView() for the format of this
"    argument. This function should only be used when the foldmethod of the
"    file is manual. There is no error-checking done in this function, so it
"    needs to be used responsibly.
function! s:LoadView(foldInfo)
	setlocal foldmethod=manual
	let row = s:Strntok(a:foldInfo, '#', 1)
	let col = s:Strntok(a:foldInfo, '#', 2)
	let folds = s:Strntok(a:foldInfo, '#', 3)
	let fclosedinfo = s:Strntok(a:foldInfo, '#', 4)
	
	normal! zE

	let i = 1
	let foldi = s:Strntok(folds, '|', i)
	let isclosed = s:Strntok(fclosedinfo, ',', i)

	while foldi != ''
		let n1 = s:Strntok(foldi, ',', 1)
		let n2 = s:Strntok(foldi, ',', 2)
		exe n1.','.n2.' fold'

		if !isclosed
			exe n1
			normal! zo
		end

		let i = i + 1
		let foldi = s:Strntok(folds, '|', i)
		let isclosed = s:Strntok(fclosedinfo, ',', i)
	endwhile

	exe row
	exe 'normal! '.col.'|'
endfunction

" Strntok:
" extract the n^th token from s seperated by tok. 
" example: Strntok('1,23,3', ',', 2) = 23
fun! <SID>Strntok(s, tok, n)
	return matchstr( a:s.a:tok[0], '\v(\zs([^'.a:tok.']*)\ze['.a:tok.']){'.a:n.'}')
endfun
