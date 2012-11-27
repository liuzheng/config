"
" Write this script for sue. 
"
" Usage:
"       Start game: type SudokuEasy/SudokuMedium/SudokuHard/SudokuVeryHard in
"       command line 
"       If you want create a customization Sudoku, type SudokuCustom <init
"       numbers count>, the count is between 20 and 80
"       use hjkl/HJKL to move around. use HJKL quick move to the number need
"       input
"       u:undo ctrl-r:redo
"       ?:show right answer under cursor
"
"       Welcome to email me! Enjoy yourself! 
"
"Attention:
"       ########Need python support! #########
"
"       Because I don't kown how to create random in vim srcipt.
"       I use lots of random numbers to create sudoku. If you know,
"       send email to me! Thanks!
"
"Email: 
"       wuhong40@163.com
if has("python")

let s:sudoku_matrix = []
let s:sudoku_user_matrix = []
let s:sudoku_curr_matrix = []

let s:sudoku_matrix_user = []
let s:curr_insert_line = 1
let s:start_pos = [7, 14]
let s:end_line = s:start_pos[0] + 11
let s:end_col = s:start_pos[1] + 26
let g:sudoku_token = "*"
let s:border_str ="_________________________________"
let s:border_head="          "
" record the history input, format: i,j,value,pre_value
let s:history_input_list = []
let s:history_index = 0
let s:left_number_cnt = 0
let s:level = 0
let s:is_init = 0

python << endpython
import vim
import random  #for generate random number
sudoku_matrix=[[0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0]]
sudoku_user_matrix =[[0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0],\
               [0,0,0,0,0,0,0,0,0]]

def create_sudoku(matrix, user_matrix, number_count):
    """create sudoku from matrix, leave number_count numbers"""
    i = 0
    while i< 9:
        j = 0
        while j < 9:
            matrix[i][j] = 0
            user_matrix[i][j] = 0
            j += 1
        i += 1

    do_create_matrix(matrix)
    #copy matrix
    i = 0
    while i < 9:
        j = 0
        while j < 9:
            user_matrix[i][j] =matrix[i][j]
            j += 1
        i += 1
    i = 81 - number_count
    while i > 0:
        index =  int(random.random()*81)
        row_id = index / 9
        col_id = index % 9
        if user_matrix[row_id][col_id] != 0:
            user_matrix[row_id][col_id] = 0
            i -= 1
        else:
            continue

def do_create_matrix(matrix):
    candidata_list = []
    #init 
    i = 0
    while i < 9:
        j = 0
        while j < 9:
            candidata_list.append([])
            j += 1
        i += 1

    #get the first place to fill
    index=0
    candidata_list[0] = get_candidate(matrix, 0 , 0)

    while True:
        if index == -1:
            return 0
        if len(candidata_list[index]) == 0:
            matrix[index/9][index%9] = 0
            index -= 1
            continue
        else:
            while True:
                #pop a random candidate
                candidate_index = int(random.random()*len(candidata_list[index]))
                data = candidata_list[index][candidate_index]
                candidata_list[index].pop(candidate_index)
                if check_number(matrix, index/9 , index%9, data) == 1:
                    matrix[index/9][index%9] =data 
                    index += 1
                    if index == 81: #it's the last one ,successful
                            return 1
                    else:
                        #get the next init value == 0
                        candidata_list[index] = get_candidate(matrix, index / 9, index % 9)
                        if len(candidata_list[index]) == 0: #no suit number for this , go back
                            matrix[index/9][index%9] = 0
                            index -= 1
                    break
                else:#didn't match get next candidate number
                    if len(candidata_list[index]) > 0:
                        continue #continue search the right number
                    else: #it's empty, go back
                        matrix[index/9][index%9] = 0
                        index -= 1
                        break

def get_candidate( matrix, row_id, col_id):
    candidate = [1,2,3,4,5,6,7,8,9]

    #remove the number already in row and col
    i = 0
    while i < 9:
        if matrix[row_id][i] != 0 and  i != col_id:
            candidate[matrix[row_id][i] -1] = 0
        if matrix[i][col_id] != 0 and i != row_id:
            candidate[matrix[i][col_id] -1] = 0
        i += 1

    #remove the number already in 3*3 square
    square_row_id = row_id / 3
    square_col_id = col_id / 3
    i = 0
    while i < 3:
        j = 0
        while j < 3:
            data = matrix[square_row_id * 3 + i][square_col_id * 3 + j]
            if data != 0 and (square_row_id*3+i != row_id) and (square_col_id*3 + j != col_id):
                candidate[data - 1] = 0
            j += 1
        i += 1

    #remove the item which equal 0
    i = 8
    while i >= 0:
        if candidate[i] == 0:
            candidate.pop(i)
        i -= 1

    if matrix[row_id][col_id] != 0:
        candidate.append(matrix[row_id][col_id])
        
    return candidate

def check_matrix(matrix):
    """check sudoku matrix is right or error"""
    i = 0
    while i < 9:
        j = 0
        while j < 9:
            matrix[i][j] = int(matrix[i][j])
            j += 1
        i += 1

    #check row 
    i = 0
    while i<9:
        if check_row(matrix[i]) == 0:
            return 0
        i += 1

    #check col
    i = 0
    while i<9:
        row=[matrix[0][i],matrix[1][i],matrix[2][i],matrix[3][i],matrix[4][i],matrix[5][i],matrix[6][i],matrix[7][i],matrix[8][i]]
        if check_row(row) == 0:
            return 0
        i += 1

    #check 3*3
    square_i = 0
    square_j = 0
    while square_i < 3:
        while square_j < 3:
            i = 0
            square = [0,0,0,0,0,0,0,0,0]

            while i < 3:
                j = 0
                while j < 3:
                    square[i*3+j] = matrix[square_i * 3 + i][square_j * 3 + j] 
                    j = j + 1
                i = i + 1

            if check_row(square) == 0:
                return 0
            square_j = square_j + 1
        square_i = square_i + 1
    return 1

def check_number(matrix,row_id, col_id, data):
    """when you put a number which equal data, check it"""
    i = 0
    while i < 9:
        j = 0
        while j < 9:
            matrix[i][j] = int(matrix[i][j])
            j += 1
        i += 1
    #check row
    row = []
    for number in matrix[row_id]:
        row.append(number)
    row[col_id] = data
    if check_part_row(row)== 0:
        return 0
        
    #check col
    row=[matrix[0][col_id],matrix[1][col_id],matrix[2][col_id],matrix[3][col_id],matrix[4][col_id],matrix[5][col_id],matrix[6][col_id],matrix[7][col_id],matrix[8][col_id]]
    row[row_id] = data
    if check_part_row(row) == 0:
        return 0
    #check square
    square_row_id = row_id / 3
    square_col_id = col_id / 3
    i = 0
    row=[]
    while i < 3:
        j = 0
        while j < 3:
            temp = matrix[square_row_id * 3 + i][square_col_id * 3 + j]
            row.append(temp)
            j += 1
        i += 1
    row[row_id%3*3+col_id%3] =data
    if check_part_row(row) == 0:
        return 0
    return 1

def check_part_row(row):
    """check a row which didn't contain all number, like 1 2 3 0 0 3"""
    i = 0
    while i<9:
        j = i + 1
        while j < 9:
            if row[j] == row[i] and row[i] != 0:
                return 0
            j += 1
        i += 1
    return 1
    
def check_row(row):
    """check a row, a col or a 3*3 square"""
    i = 0
    while i<9:
        j = 0
        while j < 9:
            if row[j] == i+1:
                break
            j += 1
        if j == 9:
            return 0
        i += 1
    return 1

def print_matrix( matrix):
    """print sudoku matrix"""
    print "********Sudoku Start************************"
    for row in matrix:
        print_row(row)
    print "***********End************************"
    
def print_row(row):
    """print sudoku row"""
    str = ""
    for number in row:
        str_number = "%d" %(number)
        str += str_number + " "
    print str
endpython

function! s:check_number(i,j,number)
    let matrix =[]
    for row in s:sudoku_curr_matrix
        let row2 = []
        for number in row
            call add(row2, number[2])
        endfor
        call add(matrix, row2)
    endfor
    let is_right = 1
python << endpython
matrix = vim.eval("matrix")
i = int(vim.eval("a:i"))
j = int(vim.eval("a:j"))
number = int(vim.eval("a:number"))
if check_number(matrix,i,j,number) == 1:
    vim.command("let is_right = 1")
else:
    vim.command("let is_right = 0")
endpython
    if is_right == 0
        setlocal modifiable
        call setline(5, "                 #Sorry, input error!#")
        setlocal nomodifiable
    endif
endfunction

function! s:check()
    if s:left_number_cnt > 0
        return
    endif

    let matrix =[]
    for row in s:sudoku_curr_matrix
        let row2 = []
        for number in row
            call add(row2, number[2])
        endfor
        call add(matrix, row2)
    endfor
    let is_right = 1
python << endpython
matrix = vim.eval("matrix")
if check_matrix(matrix) == 1:
    vim.command("let is_right = 1")
else:
    vim.command("let is_right = 0")
endpython
    setlocal modifiable
    if is_right == 1
        call setline(5, "           #congratulations! You finished!#")
    else 
        
        call setline(5, "               #Sorry, you failed!#")
    endif
    setlocal nomodifiable
endfunction

function! SudokuMain()
    call s:create_sudoku(80)
endfunction

function! SudokuEasy()
    let s:level = 0
    call s:create_sudoku(40)
endfunction
function! SudokuMedium()
    let s:level = 1
    call s:create_sudoku(36)
endfunction
function! SudokuHard()
    let s:level = 2
    call s:create_sudoku(32)
endfunction
function! SudokuVeryHard()
    let s:level = 3
    call s:create_sudoku(28)
endfunction
function! SudokuCustom(cnt)
    let s:level = 4
    if a:cnt>80 || a:cnt<20
        echo "Please input para between 20 and 81"
        return
    endif
    call s:create_sudoku(a:cnt)
endfunction

command -nargs=* -complete=file SudokuEasy silent! call SudokuEasy()
command -nargs=* -complete=file SudokuMedium silent! call SudokuMedium()
command -nargs=* -complete=file SudokuHard silent! call SudokuHard()
command -nargs=* -complete=file SudokuVeryHard silent! call SudokuVeryHard()
command -nargs=1 -complete=file SudokuCustom silent! call SudokuCustom(<q-args>)
function! s:init()
    hi Wall term=reverse ctermfg=DarkBlue ctermbg=DarkBlue guifg=DarkBlue guibg=DarkBlue
    hi Shape0 ctermfg=DarkGrey ctermbg=DarkGrey guifg=DarkGrey guibg=DarkGrey
    "hi Red ctermfg=LightRed ctermbg=LightRed guifg=LightRed guibg=LightRed
    hi Red ctermfg=LightRed guifg=LightRed 
    hi def link Inputed Type
    syn match Wall "_"
    syn match Inputed "\d\*"
    syn match Red  "#.*#"
    " digit mappings
    let i=0
    while i < 10
    exec "nnoremap <silent><buffer> ".i." :call SudokuInput(".i.")<CR>"
    let i=i+1
    endwhile
    exec "nnoremap <silent><buffer> j :call SudokuMoveRow(0)<CR>"
    exec "nnoremap <silent><buffer> k :call SudokuMoveRow(1)<CR>"
    exec "nnoremap <silent><buffer> J :call SudokuMoveInputRow(0)<CR>"
    exec "nnoremap <silent><buffer> K :call SudokuMoveInputRow(1)<CR>"
    exec "nnoremap <silent><buffer> h :call SudokuMoveCol(1)<CR>"
    exec "nnoremap <silent><buffer> l :call SudokuMoveCol(0)<CR>"
    exec "nnoremap <silent><buffer> H :call SudokuMoveInputCol(1)<CR>"
    exec "nnoremap <silent><buffer> L :call SudokuMoveInputCol(0)<CR>"
    exec "nnoremap <silent><buffer> u :call SudokuUndo()<CR>"
    exec "nnoremap <silent><buffer> <C-r> :call SudokuRedo()<CR>"
    exec "nnoremap <silent><buffer> ? :call SudokuHelp()<CR>"

    setlocal modifiable
    normal! e sudoku
    set noshowcmd
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nomodifiable
    let s:is_init = 1
endfunction

function! s:create_sudoku(init_number_cnt)
    if s:is_init == 0
        call s:init()
    else
        setlocal modifiable
        normal! ggVGd
        let s:sudoku_curr_matrix = []
        let s:sudoku_matrix = []
        let s:sudoku_user_matrix = []
        setlocal nomodifiable
    endif
python << endpython
cnt = int(vim.eval("a:init_number_cnt"))
create_sudoku(sudoku_matrix, sudoku_user_matrix,cnt)
vim.command("let s:sudoku_matrix=%s" % sudoku_matrix)
#vim.command("let s:sudoku_curr_matrix=%s" % sudoku_user_matrix)
vim.command("let s:sudoku_user_matrix=%s" % sudoku_user_matrix)
endpython
    call s:insert_head()
    let s:left_number_cnt = s:get_left_cnt(s:sudoku_user_matrix)
    call s:input_info(s:level, s:left_number_cnt)
    call s:init_curr_matrix()
    call cursor(s:start_pos[0], s:start_pos[1])
endfunction

function! SudokuUndo()
    if s:history_index > 0
        let s:history_index = s:history_index - 1
        let input_record =s:history_input_list[s:history_index]
        let i = input_record[0]
        let j = input_record[1]
        let value = input_record[3]
        let old_value = s:sudoku_curr_matrix[i][j][2]
        call s:locate_row(i)
        call s:locate_col(j)
        if value !=0 
            if old_value == 0
                let s:left_number_cnt = s:left_number_cnt - 1
            endif
            call s:input_info(s:level, s:left_number_cnt)
            setlocal modifiable
            execute "normal! R".value."".g:sudoku_token
            setlocal nomodifiable
        else 
            if old_value != 0
                let s:left_number_cnt = s:left_number_cnt + 1
            endif
            call s:input_info(s:level, s:left_number_cnt)
            setlocal modifiable
            execute "normal! R".g:sudoku_token." "
            setlocal nomodifiable
        endif
        call cursor(line("."), col(".")-1)
        let s:sudoku_curr_matrix[i][j][2] = value
        call s:check()
    else
        echo "Already at oldest change"
    endif
endfunction

function! SudokuRedo()
    if s:history_index < len(s:history_input_list)
        let input_record =s:history_input_list[s:history_index]
        let i = input_record[0]
        let j = input_record[1]
        let value = input_record[2]
        let old_value = s:sudoku_curr_matrix[i][j][2]
        call s:locate_row(i)
        call s:locate_col(j)
        if value !=0 
            if old_value == 0
                let s:left_number_cnt = s:left_number_cnt - 1
                call s:input_info(s:level, s:left_number_cnt)
            endif
            setlocal modifiable
            execute "normal! R".value."".g:sudoku_token
            setlocal nomodifiable
        else 
            if old_value != 0
                let s:left_number_cnt = s:left_number_cnt + 1
                call s:input_info(s:level, s:left_number_cnt)
            endif
            setlocal modifiable
            execute "normal! R".g:sudoku_token." "
            setlocal nomodifiable
        endif
        call cursor(line("."), col(".")-1)
        let s:sudoku_curr_matrix[i][j][2] = value
        let s:history_index = s:history_index + 1
        call s:check()
    else 
        echo "Already at newest change"
    endif
endfunction

function! SudokuHelp()
    let i = s:get_cursor_row()
    let j = s:get_cursor_col()
    if i == -1 || j == -1
        return 
    endif
    call SudokuInput(s:sudoku_matrix[i][j])
endfunction

function! SudokuInput(number)
    let input_number = a:number

    let i = s:get_cursor_row()
    let j = s:get_cursor_col()
    if i == -1 || j == -1
        return 
    endif

    if s:sudoku_user_matrix[i][j] != 0
        return
    endif

    let old_value = s:sudoku_curr_matrix[i][j][2]
    if old_value == input_number
        return
    endif
    
    "input the number
    if input_number !=0 
        if old_value == 0
            let s:left_number_cnt = s:left_number_cnt - 1
        endif
        call s:input_info(s:level, s:left_number_cnt)
        setlocal modifiable
        execute "normal! R".input_number."".g:sudoku_token
        setlocal nomodifiable
        call s:check_number(i,j,input_number)
    else 
        if old_value != 0
            let s:left_number_cnt = s:left_number_cnt + 1
            call s:input_info(s:level, s:left_number_cnt)
        endif
        setlocal modifiable
        execute "normal! R".g:sudoku_token." "
        setlocal nomodifiable
    endif
    call cursor(line("."), col(".")-1)

    "pop the record after current record
    let length = len(s:history_input_list)
    if  length > s:history_index
        call remove(s:history_input_list, s:history_index , length - 1)
    endif
    "record cmd
    let input_record = [i,j, input_number, old_value]
    call insert(s:history_input_list, input_record, s:history_index)
    let s:history_index = s:history_index + 1

    let s:sudoku_curr_matrix[i][j][2] = input_number
    call s:check()
endfunction

function! s:init_curr_matrix()
    let s:sudoku_curr_matrix=[]
    let i = 0
    while i<9
        let j = 0
        let sudoku_row = []
        while j < 9
            "row, col , value
            let sudoku_number = [0,0,s:sudoku_user_matrix[i][j]]
            let sudoku_number[0] = s:start_pos[0] + i/3*4+i%3
            if j % 3 == 0
                let sudoku_number[1] = j/3*10 + 0 
            elseif j % 3 == 1
                let sudoku_number[1] = j/3*10 + 3
            elseif j % 3 == 2
                let sudoku_number[1] = j/3*10 + 6
            endif
            let sudoku_number[1] = sudoku_number[1] + s:start_pos[1]
            call add(sudoku_row, sudoku_number)
            let j = j + 1
        endwhile
        call add(s:sudoku_curr_matrix, sudoku_row)
        let i = i + 1
    endwhile
endfunction

"  nnoremap <buffer> +   :set nohlsearch<cr>
"  nnoremap <buffer> C   :call <SID>_akeGrid()<cr>
"command -nargs=* -complete=file Sudoku    call <SID>EstablishBuffer( "", <q-args>)
function! s:insert_head()
    setlocal modifiable

    call append(0, "              ?: show right answer under cursor")
    call append(0, "       u Ctrl-r: undo redo")
    call append(0, "        H,J,K,L: qucik move to the postion that need input")
    call append(0, "        h,j,k,l: move")
    call append(0, "    Usage: ")

    let token_init = " "
    let token_no_init = " "
    let token_input= " "
    
    let token_border = "__"
    let square_i = 0
    let square_j = 0
    let i = 8
    call append(0,s:border_head."".s:border_str)
    while i >= 0
        let str =s:border_head."".token_border
        let j = 0
        let square_i = i / 3
        let sudoku_row = []
        while j<9
            let square_j = j / 3
            let number = s:sudoku_user_matrix[i][j]
            let str = str . " "
            if number == 0
                let str = str .g:sudoku_token
            else
                let str = str .number
            endif
            let str = str . " "

            if j%3 == 2
                let str = str."_"
            endif
            if j == 8
                let str = str."_"
            endif

            let j = j + 1
        endwhile
        call append(0, str)
        if i%3 == 0
            call append(0,s:border_head."".s:border_str)
        endif
        let i = i - 1
    endwhile
    call append(0, "            Level: easy   Left: 60 ")
    call append(0, "*******************************************************")
    call append(0, "*       Version:1.0   E-mail:wuhong40@163.com         *")
    call append(0, "*                Welcome to Sudoku                    *")
    call append(0, "*******************************************************")
    set nomodifiable
endfunction

function! s:input_info(level, left)
    setlocal modifiable
    let str = "                Level: "
    if a:level == 0
        let str = str."easy"
    elseif a:level == 1
        let str = str."medium"
    elseif a:level == 2
        let str = str."hard"
    elseif a:level == 3
        let str = str."very hard"
    else 
        let str = str."custom"
    endif

    let str = str."  Left:".a:left
    call setline(5, str)
    setlocal nomodifiable
endfunction

function! s:get_left_cnt(matrix)
    let left_cnt = 0
    for row in a:matrix
        for number in row
            if number == 0
                let left_cnt = left_cnt + 1
            endif
        endfor
    endfor
    return left_cnt
endfunction

function! SudokuMoveInputCol(direct)
    let curr_row = s:get_cursor_row()
    let curr_col = s:get_cursor_col()
    "in error postion, go back to start postion
    if curr_row == -1 || curr_col == -1
        call cursor(s:start_pos[0],s:start_pos[1])
    endif
    
    let temp_col = curr_col
    let i = 0
    while i < 9
        if a:direct == 1
            let temp_col = temp_col + 1
            if temp_col == 9
                let temp_col = 0
            endif
        else 
            let temp_col = temp_col - 1
            if temp_col == -1
                let temp_col = 8
            endif
        endif 
        "go back to the start number, do nothing
        if temp_col == curr_col
            return
        endif
        if s:sudoku_user_matrix[curr_row][temp_col] == 0
            call s:locate_col(temp_col)
        endif
        let i = i + 1
    endwhile
endfunction

function! SudokuMoveInputRow(direct)
    "get the next uninit number in current col
    let curr_row = s:get_cursor_row()
    let curr_col = s:get_cursor_col()
    "in error postion, go back to start postion
    if curr_row == -1 || curr_col == -1
        call cursor(s:start_pos[0],s:start_pos[1])
    endif

    let temp_row = curr_row
    let i = 0
    while i < 9
        if a:direct == 1
            let temp_row = temp_row + 1
            if temp_row == 9
                let temp_row = 0
            endif
        else 
            let temp_row = temp_row - 1
            if temp_row == -1
                let temp_row = 8
            endif
        endif 
        "go back to the start number, do nothing
        if temp_row == curr_row
            return
        endif
        if s:sudoku_user_matrix[temp_row][curr_col] == 0
            call s:locate_row(temp_row)
        endif
        let i = i + 1
    endwhile
endfunction

function! SudokuMoveCol(direct)
    let col_id = s:get_cursor_col()    
    "in error postion, go back to start postion
    if col_id == -1
        call cursor(s:start_pos[0],s:start_pos[1])
    endif

    if a:direct == 0
        "To the next col
        if col_id == 8
            let col_id = 0
        else 
            let col_id = col_id + 1
        endif
    else 
        if col_id == 0
            let col_id = 8
        else 
            let col_id = col_id - 1
        endif
    endif

    call s:locate_col(col_id)
endfunction

function! SudokuMoveRow(direct)
    let row_id = s:get_cursor_row()
    "in error postion, go back to start postion
    if row_id == -1
        call cursor(s:start_pos[0],s:start_pos[1])
    endif

    if a:direct == 0
        "To the next row
        if row_id == 8
            let row_id = 0
        else 
            let row_id = row_id + 1
        endif
    else 
        if row_id == 0
            let row_id = 8
        else 
            let row_id = row_id - 1
        endif
    endif

    "to the real next row
    call s:locate_row(row_id)
endfunction

function! s:locate_col(col_id)
    call cursor(line("."), s:sudoku_curr_matrix[0][a:col_id][1])
endfunction
function! s:locate_row(row_id)
    call cursor(s:sudoku_curr_matrix[a:row_id][0][0], col(".")) 
endfunction

"获取当前光标下的数字在数度数组中的列号
"if cursor not on matrix return -1
function! s:get_cursor_col()
    let i = 0
    let cursor_col = col(".")
    while i<9
        if cursor_col == s:sudoku_curr_matrix[0][i][1]
            return i
        endif
        let i = i + 1
    endwhile
    return -1
endfunction

"获取当前光标下的数字在数度数组中的行号
function! s:get_cursor_row()
    let i = 0
    let cursor_line = line(".")
    while i<9
        if cursor_line == s:sudoku_curr_matrix[i][0][0]
            return i
        endif
        let i = i + 1
    endwhile
    return -1
endfunction
endif "has python"

