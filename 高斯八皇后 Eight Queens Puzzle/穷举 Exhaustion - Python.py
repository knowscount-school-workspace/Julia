import time

## 检查一种摆法是否合法
## x是长度为8的列表，代表从低位到高位的8进制数字，
## 用每个数字代表一行的棋子所在的列。
def is_solution(x):
    for i in range(7):
        for j in range(i+1, 8):
            di = x[j] - x[i]
            if di==0 or di==j-i or di==i-j :
                return False
    return True

## 穷举进入下一个摆法
def next_board(x):
    x[0] += 1
    for i in range(7):
        if(x[i]==8):
            x[i+1] += 1
            x[i] = 0
    return x

def queens_exaust():
    board = [0]*8
    nmax = 8**8
    ## boards用来存放所有的摆法，
    ## 每种摆法表示为8个元素的列表
    boards = []
    nb = 0
    for i in range(nmax):
        if is_solution(board):
            print(str(nb) + ',' + ','.join(map(str, board)))
            boards.append(board.copy())
            nb += 1

        board = next_board(board)
    return boards


time_start=time.time()
res1 = queens_exaust()
time_end=time.time()
print('穷举法用时', time_end-time_start)
print('解的个数：', len(res1))
