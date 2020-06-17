## 递归算法
## 用长度为8的数组A表示一种摆法，
## 用cur表示当前要摆放的棋子序号，1 <= cur <= 8
function queens()
    nbmax = 1000
    nb = 0
    boards = zeros(Int8, nbmax, 8)

    function queens_rec(A, cur=1)
        if cur == 9
            ## 如果当前棋子序号为9，表示找到了一种摆法
            nb += 1
            boards[nb,:] = A
            ##println(join(string.(A), ","))
            return
        end # if cur

        ## 对当前要摆放的棋子遍历所有列位置试摆放
        for col in 1:8
            ## 将当前棋子cur摆放在col列，
            A[cur] = col
            ## 设置摆放是否合法的初值为真
            flag = true
            ## 判断cur号棋子摆放在col列，是否与1到cur-1号棋子有冲突
            ## row是1到cur-1号棋子的变量
            for row in 1:(cur-1)
                ## 以下判断摆放在第cur行、第col列的棋子，
                ## 是否与第row行、A[row]列的棋子冲突
                if A[row] == col || abs(col - A[row]) == cur - row
                    flag = false
                    break
                end
            end # for row

            ## 如果摆放第cur号棋子在第col列成功，
            ## 就考虑下一颗棋子（递归调用）；
            ## 如果摆放不成功，就摆放到col的下一列继续判断
            ## 这样会遍历每颗棋子与前面棋子的不冲突的位置
            if flag
                queens_rec(A, cur+1)
            end
        end # for col
    end # function queens_rec

    queens_rec(zeros(Int8, 8), 1)
    boards = boards[1:nb,:]
    println("找到解的个数：", nb)

    return boards
end # function queens
@time queens()