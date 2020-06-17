function checkall_thch(filename)
    ## 读入文件为一个长字符串
    s0 = read(filename, String)
    ## 去掉标点、空格与换行
    s = replace(s0, r"[　，。 \n]" => s"")
    ##println(s)
    x = collect(s)
    if length(x) != 1000
        println("字数不等于1000！")
        return false
    end
    d = Dict()
    for xi in x
        if xi in keys(d)
            d[xi] += 1
        else 
            d[xi] = 1
        end 
    end
    ## 找到所以>1的值对应的键值
    for (k, v) in d
        if v>1
            println("“", k, "”出现", v, "次！")
        end 
    end 
    return length(d)==0
end 
checkall_thch("千字文繁体 TCC Traditional.txt")