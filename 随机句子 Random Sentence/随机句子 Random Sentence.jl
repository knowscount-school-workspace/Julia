## 使用前后单词的条件概率作马氏分析，
## 从而制作随机句子。
## 以一篇英文文本文档为素材。

module MarkovArticle

export make_sencence_sampler, random_sentences

const sentence_begin = "aaaaa"
const sentence_end = "zzzzz"

## 频数表程序，输入一维数组，输出每个不同值的频数，以字典形式返回
function histogram(x)
    d = Dict()
    for xi in x
        if xi ∉ keys(d)
            d[xi] = 1
        else
            d[xi] += 1
        end
    end
    d
end

## 切分句子的程序
## 读入一篇文章，切分句子为数组。
## 用句点空格，句点双撇号作为句子末尾标志。
function getsentences(filename; skiplines=0)
    ## 读入为一个长字符串，并删除开始若干行
    lines = readlines(filename)[(skiplines+1):end]
    s0 = join(lines, " ")
    ## 将常见的缩略词Mr., Mrs.的句点去掉
    s0 = replace(s0, r"(Mr|Mrs)[.]" => s"\1")
    ## 按照句点或叹号或问号，逗号，冒号加空格或双撇号作为分隔拆分句子
    x = split(s0, r"[.!?;,:][ \"]")
    ## 去掉标点符号
    for i in eachindex(x)
        x[i] = replace(x[i], r"[^a-zA-Z ]" => s"")
        x[i] = replace(x[i], r" +" => s" ")
        x[i] = lowercase(x[i])
    end
    return x
end
##getsentences("Pride and Prejudice by Jane Austen.txt", skiplines=30)

## 输入由句子组成的词组，
## 建立从前词组到后随词的映射的频数表。
## 前词组可以是一个词，二个词，三个词等，
## 后词是一个词。
## 每个映射是一个字典项，
## 以前词组作为键，
## 而值包括前词组的概率，
## 以及一个子概率表，子概率表为后词到期概率的映射。
## 所有的频数都有一个降序排列的索引数组。
## 首先是一个句子的处理程序。
## freqs: 频数统计结果；
## sentence: 字符串，一个句子;
## prewords: 前词组的单词个数，如1,2,3等
function anasentence!(freqs, sentence; prewords=2)
    # 每个sentence开头用aaaaa标志，结尾用zzzzz标志。
    x0 = split(sentence)
    x = vcat(sentence_begin, x0, sentence_end)
    n = length(x)
    if prewords >= n
        prewords = n-1
    end
    for i=prewords:(n-1)
        key = Tuple(x[(i-prewords+1):i])
        if key ∈ keys(freqs)
            freqs[key][1] += 1
            if x[i+1] ∈ keys(freqs[key][2])
                freqs[key][2][x[i+1]] += 1
            else
                freqs[key][2][x[i+1]] = 1
            end
        else
            freqs[key] = [1, Dict()]
            freqs[key][2][x[i+1]] = 1
        end
    end
    return nothing
end
## 多个句子的马氏概率分析
## x是以句子为元素的向量
function anasentences(x; prewords=2)
    freqs = Dict()
    for xi in x
        anasentence!(freqs, xi, prewords=prewords)
    end
    return freqs
end

## 输入一篇文章，得到马氏概率分析
function anatext(filename; skiplines=0, prewords=2)
    ## 读入句子为数组
    x = getsentences(filename, skiplines=skiplines)
    ## 以句子为样本，获得前词到后词的映射的频数表
    dict = anasentences(x, prewords=prewords)
    ## 将频数都转换成概率
    n = 0 # 总的前词组数
    for prefix in keys(dict)
        n += dict[prefix][1]
    end
    probpre = []
    for prefix in keys(dict)
        dict[prefix][1] /= n
        push!(probpre, dict[prefix][1])
    end
    ## 每个前词组确定后的后词的频数分布也转换成概率
    for prefix in keys(dict)
        nn = sum(values(dict[prefix][2]))
        for k in keys(dict[prefix][2])
            dict[prefix][2][k] /= nn
        end
    end
    ## 建立前词概率分布降序排列的索引
    #indpre = sortperm(probpre, rev=true)
    ## 建立前词概率降序排列后的累积百分比
    #cumpre = cumsum(probpre[indpre])

    #return (dict, indpre, cumpre)
    return dict
end
##anatext("Pride and Prejudice by Jane Austen.txt", skiplines=30)


## 从一个小规模的频数表按比例抽取的函数
## dict是键到概率的映射字典
function rdiscrete(dict)
    u = rand()
    cump = 0.0
    for (k, v) in dict
        cump += v
        if u <= cump
            return k
        end
    end
    return nothing
end

## 读入一篇文章，制作从此文章生成随机句子的抽样器
function make_sencence_sampler(filename; skiplines=0, prewords=2)
    dict = anatext(filename; skiplines=0, prewords=2)

    ## 建立句首的字典
    dicthead = Dict()
    freq0 = 0.0
    for (k, (freq, d2)) in dict
        if k[1] == sentence_begin
            dicthead[k] = freq
            freq0 += freq
        end
    end
    ## 将句首字典的频数归一化
    for k in keys(dicthead)
        dicthead[k] /= freq0
    end

    ## 抽取句首前词组的内嵌函数
    function random_head()
        return rdiscrete(dicthead)
    end

    ## 抽取后词的内嵌函数
    function random_follow(newprefix)
        if newprefix ∉ keys(dict)
            return nothing
        end
        ## 对newprefix为前词组的各个后词进行随机抽样，
        ## 先建立相应的子频数表
        dsub = dict[newprefix][2] # 这是后词的概率分布表字典
        return rdiscrete(dsub)
    end

    # 抽取整句的闭包作为函数发生器的输出
    function ()
        x = []
        # 抽取句首的前词组
        newpre = random_head()
        append!(x, newpre)

        ## 重复抽取后词，如果无对应的后词返回空集，
        ## 重复直到抽取到句子结尾为止
        while true
            ## 根据newpre抽取后词
            suf = random_follow(newpre)
            ## 如果前词组没有对应的后词，失败
            if suf == nothing
                return ""
            end
            ## 如果后词是句尾，返回抽取结果
            if suf == sentence_end
                return join(x[2:(end-1)], " ")
            end
            ## 将前词组的后半部分与抽取的后词组成新的前词组
            push!(x, suf)
            if length(newpre) < prewords
                newpre = (newpre..., suf)
            else
                newpre = (newpre[2:end]..., suf)
            end
        end
    end
end
## random_sentence = MarkovArticle.make_sencence_sampler("Pride and Prejudice by Jane Austen.txt"; skiplines=39, prewords=2)

## 输入一篇文章，建立抽样器，并输出多个随机句子的程序
function random_sentences(filename, n=1; skiplines=0, prewords=2)
    sampler = make_sencence_sampler(filename; skiplines=skiplines, prewords=prewords)
    x = Array{String,1}(undef, n)
    i = 0
    j = 0
    maxit = 10_000
    while i < n && j < maxit
        j += 1
        item = sampler()
        if item != ""
            i += 1
            x[i] = item
        end
    end
    return x
end
# y = MarkovArticle.random_sentences("Pride and Prejudice by Jane Austen.txt", 100; skiplines=39, prewords=1)

## 问题：必须遇到句尾标志才结束可能造成许多长句子，尤其是用句点作为句子结尾时
end # module MarkovArticle