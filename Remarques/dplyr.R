library(tidyverse)
library(dplyr)
library(MASS)#birthwt
#arrange()排列行
##arrange()函数工作原理和filter()相似，但它不是选择行，而是改变行的顺序。它使用一个数据框和一系列有序的列变量（或者更复杂的表达式）作为输入。如果你提供了超过一个列名，其他列对应着进行排序。
head(birthwt)
arrange(birthwt,age,lwt,race)
#使用desc()可以以逆序（降序）的方式排列：
arrange(birthwt,desc(age))
#select()选择列
##一般我们分析的原始数据集有非常多的变量（列），第一个我们要解决的问题就是缩小范围找到我们需要的数据（变量）。select()允许我们快速通过变量名对数据集取子集。
head(birthwt)
dplyr::select(birthwt, smoke, ui, bwt)
select=dplyr::select
select(birthwt,age:smoke)
select(birthwt,-(age:smoke))
select(birthwt,age,everything())

#mutate()添加新变量
##除了选择已存在的列，另一个常见的操作是添加新的列。这就是mutate()函数的工作了。mutate()函数通常将新增变量放在数据集的最后面。为了看到新生成的变量，我们使用一个小的数据集。
birthwt1 = select(birthwt, age:smoke)
mutate(birthwt1,year_bir=2008-age)
transmute(birthwt,year_bir=2008-age)

x<-1:10
lag(x)
lead(x)
cumsum(x)
cummean(x)

y<- c(1,2,2,NA,3,4)
min_rank(y)
min_rank(desc(y))
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

summarize(birthwt,delay=mean(age,na.rm = TRUE))
by_race=group_by(birthwt,race)
summarize(by_race,delay=mean(age,na.rm = TRUE))


