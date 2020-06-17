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