function check_thch(filename)
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
    for i in 2:length(x)
        if x[i] in x[1:(i-1)]
            println("第", i, "字符（", x[i], "）重复!")
            return false 
        end
    end
    return true
end 
check_thch("千字文简体 TCC Simplified.txt")