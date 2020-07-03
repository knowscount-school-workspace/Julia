# 我先唠叨一下。讲下思路。
# 要用编程的方法解决，首先想到的是， 每个皇后有 64 个位置可选，穷举须要考虑 10^14，也就是百万亿级别的组合，计算量太大。
# 实际上，对于每一种可行的摆法，因为每一行有且仅有一个皇后， 穷举时所以只需要考虑每一行的皇后在那一列，有 8^8 种组合，即约一千万种组合。
# 这个组合数目虽然很大，但对于现代计算机来说可以很快地完成穷举。
# 先用 Python 实现。将一种可能的摆法存入一个长度为 8 的列表，每个元素代表对应的行的皇后位置。虽然可以写一个 8 重循环，
# 但是这样的程序过于繁琐。所以，采用八进制的想法，从 [0,0,0,0,0,0,0,0] 出发，每次给个位加1，遇到8就向下一位进1，直到循环 8^8 次。

## 检查一种摆法是否合法
## x是长度为8的数组，第i个元素是第i行的棋子所在的列序号
function is_solution(x)
    for i in 1:7
        for j in (i+1):8
            di = x[j] - x[i]
            if di==0 || di==j-i || di==i-j
                return false
            end
        end
    end
    return true
end
## 穷举进入下一个摆法
## 把长度为8的数组x看成是有8位数的8进制数，但数字都加1，
## 次序是从低位到高位
function next_board(x)
    x[1] += 1
    for i in 1:7
        if x[i]==9
            ## 进位
            x[i+1] += 1
            x[i] = 1
        end
    end

    return x
end

function queens_exaust()
    board = zeros(Int8, 8) .+ 1
    nmax = 8^8
    nbmax = 1000
    nb = 0
    boards = zeros(Int8, nbmax, 8)
    for i in 1:nmax
        if is_solution(board)
            nb += 1
            println(board)
            boards[nb,:] = board
        end

        board = next_board(board)
    end
    boards = boards[1:nb,:]
    return boards
end
@time queens_exaust()
