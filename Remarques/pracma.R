install.packages("pracma")
library(pracma)

#多项式差值与拟合
##pracma包是一个科学计算的包，有很多现成的函数可以使用。使用install.packages("parcma")可以安装。
#关键函数：
#* polyfit(x, y, n) 产生多项式系数,幂次由高到低, n < (length(x)-1)则自动拟合数据
#* polyfix(x, y, n, xfix, yfix) 同样是参数多项式系数，参数xfix，yfix表示参考点坐标，即保证拟合曲线一定过该点
#* polyval(p, x) 根据多项式系数向量P,产生多项式，然后根据该多项式计算x坐标的的值：


library(ggplot2)

set.seed(1)
x <- seq(0, pi, length.out = 25)
y <- sin(x) + 0.05 * runif(length(x), -2, 2)
p1 <- polyfit(x, y, 6)  # 拟合6阶多项式,返回长度为7的向量
p2 <- polyfix(x, y, 6, xfix = c(1, 3), yfix = c(0.75, 0.05))
p3 <- polyval(p1, x)

data1 <- data.frame(x = x, y = p3, y_fix = polyval(p2, x), y_point = y, stringsAsFactors = F)
g1 <- ggplot(data1) + geom_line(aes(x, y), color = "pink", size = 1) + geom_line(aes(x,                                                                                     y_fix), color = "blue", size = 1) + geom_point(aes(x, y_point), color = "grey", 
                                                                                                                                    size = 3)
g1


#线性拟合
#步骤： * 首先是数据预处理(包括剔除异常值，数据规范化：去除单位，减去最小值，除以最大值，使数据在(0, 1)区间内)
#* 然后是画散点图，根据点的分布，建立函数关系(不一定是线性函数)
#* 然后根据该函数关系，推导出线性函数关系
#* 根据该线性函数关系，进行线性拟合，解出相关系数，将解带入原函数，绘函数图像

#利用数据变换进行数据拟合
#因为线性拟合的步奏比较多，线性回归结果一样， 所以代码中直接使用线性回归代替，但数据变换过程才是关键，也是线性拟合可以拟合出曲线的关键。

set.seed(11)
black <- function(x) {
  2 * x * exp(0.5 * x) + runif(length(x), min = -1, max = 1)
}
x_test <- seq(0, 5, 0.2)
y_test <- black(x_test)

rigion <- data.frame(x = x_test, y = y_test)  # 预处理后的数据
ggplot(rigion, aes(x, y)) + geom_point(color = "blue")  # 画散点图，从图中可以建立指数函数模型
# 函数模型：y = c1*t*exp(c2*t), 函数线性化：lny = lnc1 + lnt + c2*t
# 替换变量,将未知量成为线性函数的系数：lny -lnt = c2*t + k,
# 自变量为t,因变量为lny-lnt,求系数 线性拟合求：k, c2
fun_y <- log(y_test, base = exp(1)) - log(x_test, base = exp(1))
fun_x <- x_test
relation <- lm(fun_y ~ fun_x)  # 建立线性关系
print(relation)  # 查看关系系数，结果c2 = 0.5583, k = 0.4780
k <- relation[[1]][1]
c2 <- relation[[1]][2]

# 带入c2和k的值，求出c1 = e^k
c1 <- exp(k)
# 函数模型为：
fun_last <- function(x) {
  c1 * x * exp(c2 * x)
}
# 绘拟合后的图形
ggplot(rigion, aes(x, y)) + geom_point(color = "blue", size = 3) + stat_function(fun = fun_last, 
                                                                                 color = "red", size = 1)




