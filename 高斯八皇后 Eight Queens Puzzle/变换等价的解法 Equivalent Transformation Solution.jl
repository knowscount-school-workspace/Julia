import DataFrames: DataFrame
import CSV

function board_equals(x, y)
    ## 棋盘的8元素存储到8x8的0-1矩阵存储
    function board_to_mat(z)
        mat = zeros(8,8)
        for i in 1:8
            mat[i,z[i]] = 1
        end # for i
        return mat
    end # board_to_mat

    xm = board_to_mat(x)
    ym = board_to_mat(y)

    # 反射变换矩阵
    mat_reflect = zeros(8,8)
    for i in 1:8
        mat_reflect[i,9-i] = 1
    end # for i

    # 左右反射
    function reflect_lr(z)
        return z * mat_reflect
    end # reflect_lr

    # 上下反射
    function reflect_ud(z)
        return mat_reflect * z
    end # reflect_ud

    # 逆时针旋转90度
    function rot090(z)
        return reflect_ud(z')
    end # rot090

    # 逆时针旋转180度
    function rot180(z)
        return reflect_ud(reflect_lr(z))
    end # rot180

    # 逆时针旋转270度
    function rot270(z)
        return reflect_lr(z')
    end # rot270

    funcs = [reflect_lr, reflect_ud, rot090, rot180, rot270]

    for i in 1:length(funcs)
        f = funcs[i]
        ynew = f(ym)
        if all(ynew .== xm)
            return true
        end # if
    end # for f

    return false
end # board_equals

## 标记通过变换可以得到的摆法
function group_boards(boards)
    b = copy(boards)
    nb = size(b, 1)
    g = zeros(Int, nb)
    ng = 1
    g[1] = 1

    for j in 2:nb
        newgroup = true
        for i in 1:(j-1)
            ## 判断第j种摆法是否与第i种摆法可转换，
            ## 如果可转换，将第j摆法标记为第i组
            if board_equals(b[i,:], b[j,:])
                g[j] = g[i]
                newgroup = false
                break
            end # if
        end # for i
        if newgroup
            ng += 1
            g[j] = ng
        end # if
    end # for j

    ## 保存为csv
    println("找到分组个数：", ng)
    grouped = [1:nb boards g]
    qn = ["solution"; "Q" .* string.(1:8); "group"]
    df = DataFrame(grouped, Symbol.(qn))
    sort!(df, :group)
    CSV.write("queens_group_julia.csv", df)
    
    return grouped
end # group_boards

boards = queens()
grouped = group_boards(boards);