library(ggplot2)
library(gcookbook)

#Making a Basic Histogram
?faithful##读取数据来源
head(faithful)##显示数据前几行，了解结构
##画柱状图，默认柱的宽度是最大值减最小值除以30，可以通过binwidth=x进行设置宽度
ggplot(faithful, aes(x=waiting)) + geom_histogram()
#如果不写第一个数据，直接将数据作为x值也是可以的。
w = faithful$waiting
ggplot(NULL, aes(x=w)) + geom_histogram()

#设置binwidth,fill,colour
ggplot(faithful, aes(x=waiting)) +
  geom_histogram(binwidth=5, fill="white", colour="black")
#设置横坐标起点origin
ggplot(faithful, aes(x=waiting)) +
  geom_histogram(fill="white", colour="black",origin=30)
#x轴起点为30，图像右移，变密集。

#画多个柱状图并进行分组
#Making Multiple Histograms from Grouped Data
library(MASS)##加载数据包
?birthwt##新生儿出生体重，种族等
##画柱状图，通过smoke把所有东西分开
ggplot(birthwt, aes(x=bwt)) + geom_histogram(fill="white", colour="black") +
  facet_grid(smoke ~ .)

birthwt1 = birthwt # Make a copy of the data
# Convert smoke to a factor
birthwt1$smoke = factor(birthwt1$smoke)
levels(birthwt1$smoke)

#为了直观理解，对smoke重新赋值，
install.packages(plyr)  # 安装plyr包
require(plyr) 
library(plyr)##一个对数据重新赋值的安装包
##把0和1变成no smoke和smoke
birthwt1$smoke <- revalue(birthwt1$smoke, c("0"="No Smoke", "1"="Smoke"))
##再次作图，图像一样但是右边标记变成了smoke和no smoke
ggplot(birthwt1, aes(x=bwt)) + geom_histogram(fill="white", colour="black") +
  facet_grid(smoke ~ .)

#通过母亲种族race分组
ggplot(birthwt, aes(x=bwt)) + geom_histogram(fill="white", colour="black") +
  facet_grid(race ~ .)
#重置y轴的取值scales="free"
ggplot(birthwt, aes(x=bwt)) + geom_histogram(fill="white", colour="black") +
  facet_grid(race ~ ., scales="free")

#在同一个表中对数据进行分组fill=smoke；position为不进行调整，做原始比较；alpha为透明度设置。
ggplot(birthwt1, aes(x=bwt, fill=smoke)) +
  geom_histogram(position="identity", alpha=0.4)

#制作密度曲线
#Making a Density Curve
#基础的
ggplot(faithful, aes(x=waiting)) + geom_density()
#expand_limits把x的值衍生到0，
ggplot(faithful, aes(x=waiting)) + geom_line(stat="density") +
  expand_limits(x=0)
#geom_line为设置区域线
ggplot(faithful, aes(x=waiting)) + geom_line(stat="density")
#adjust设置密度曲线的平滑程度
ggplot(faithful, aes(x=waiting)) +
  geom_line(stat="density", adjust=0.25, colour="red") +
  geom_line(stat="density") +
  geom_line(stat="density", adjust=2, colour="blue")

#设置x轴范围，起于35，止于105，colour=NA表示颜色是没有轮廓的
ggplot(faithful, aes(x=waiting)) +
  geom_density(fill="blue", colour=NA, alpha=.2) +
  geom_line(stat="density") +
  xlim(35, 105)
#把两个图组合
ggplot(faithful, aes(x=waiting, y=..density..)) +
  geom_histogram(fill="blue", colour="red", size=.2) +
  geom_density(color="green") +
  xlim(35, 105)

#Making Multiple Density Curves from Grouped Data
ggplot(birthwt1, aes(x=bwt, fill=smoke)) + geom_density(alpha=.3)


#Making a Frequency Polygon
ggplot(faithful, aes(x=waiting)) + geom_freqpoly()
ggplot(faithful, aes(x=waiting)) + geom_freqpoly(binwidth=4)


#Making a Density Plot of Two-Dimensional Data
p = ggplot(faithful, aes(x=eruptions, y=waiting))
#stat_density
p + geom_point() + stat_density2d()##加上蓝色等高线
##通过density level来区分颜色，颜色越浅密度越高
p + stat_density2d(aes(colour=..level..))
##contour隐藏等高线
p + stat_density2d(aes(fill=..density..), geom="raster", contour=FALSE)
p + geom_point() +
  stat_density2d(aes(alpha=..density..), geom="tile", contour=FALSE)##用方块进行展示
p + stat_density2d(aes(fill=..density..), geom="raster",
                   contour=FALSE, h=c(0.5,5))##h为手动规定x和y的密度，即横坐标涨0.5对应纵坐标的5

