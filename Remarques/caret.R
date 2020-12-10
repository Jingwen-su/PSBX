#清空工作目录
rm(list = ls())
#加载caret
library(caret)
#加载数据
dat1=read.table(file ="/Users/jingwensu/Desktop/BankChurners1.csv",encoding = "uft-8",sep=",",header = T,row.names = 1)
head(dat1)
print(ncol(dat1))
#数据预处理
##缺失值处理
###查看数据集大小
nrow(dat1)
###删除缺失值
dat=na.omit(dat1)
nrow(dat)
##转换数据类型
dat$Gender =factor(dat$"Gender", levels = c("F","M"),labels =  c("Femme","homme"))
head(dat)
#设置随机种子
set.seed(1234)
##留出法：将数据80%分为训练集，20%作为测试集
trainIndex= createDataPartition(dat$Attrition_Flag, p= .8, list = FALSE, times = 1)
##训练集
datTrain= dat[trainIndex, ]
##测试集
datTest= dat[-trainIndex, ]
##全集上因变量各个水平的比例
table(dat$Attrition_Flag)/nrow(dat)
##训练集上因变量各个水平的比例
table(datTrain$Attrition_Flag)/nrow(datTrain)
##测试集上因变量各水平的比例
table(datTest$Attrition_Flag)/nrow(datTest)
##标准化处理
###利用训练集的均值和方差对测试集进行标准化
preProcValues= preProcess(datTrain,method = c("center","scale"))
trainTransformed= predict(preProcValues, datTrain)
testTransformed= predict(preProcValues,datTest)
##变量选择
###封装法rfe
####要选择对变量个数
subsets= c(2,5,10,15,20,25,30,35,40,45,50,55,60,65,70)
####定义控制参数，functions是确定用什么样的模型进行自变量排序，这里用的是随机森林：根据目标函数或预测效果评分，每次选择若干特征；method是确定用什么抽样方法，这里用的cv，即交叉验证
ctrl = rfeControl(functions = rfFuncs,method = "cv")
x=trainTransformed[,-which(colnames(trainTransformed) %in%"Gender")]
y=trainTransformed[,"Gender"]
Profile=rfe(x,y, sizes=c(1:5),rfeControl = ctrl)
Profile$optVariables
##模型训练及调参
dat.train=trainTransformed[,c(Profile$optVariables,"Gender")]
dat.test=testTransformed[,c(Profile$optVariables,"Gender")]
##随机森林
set.seed(1234)
gbmFitl=train(Gender ~., data = dat.train,method="rf")
#用于训练模型
importance=varImp(gbmFitl, scale=FALSE)
#得到各个变量的重要性
plot(importance,xlab = "importance")
##交叉验证
set.seed(1234)
index= createFolds(dat$Gender,k=3,list = FALSE,returnTrain = TRUE)
index
testIndex=which(index==1)
datTraincv=dat[-testIndex,]##训练集
datTestcv=dat[testIndex,]##测试集
##关于时间序列分割用：createTimeSlices(1:nrow(growdata),initialWindow=5,horizon=2,fixedWindow=TRUE);其中5为初始的window，2表示测试集是训练集的后两位，fixedwindow表示都是训练集宽度一致，如果想每次都从第一个样本开始则设置为FALSE默认为TRUE##

##处理缺失值：preProcess()函数，建立在训练集中。
###中位数法：
###imputation_k=preProcess(datTrain,method="medianImpute")
###datTrain1= predict(imputation_k,datTrain)
###datTest1=predict(imputation_k,datTest)
###k近邻法：method="knnImpute";这种方法可能显示结果为多位小数，如有需要请进行标准化处理

##处理0方差变量：当某组数据值一样或者都为0时，对我们的分析没有意义,因此进行去除。
###dim(datTrain)
###(nzv=nearZeroVar(datTrain))
###datTrain=datTrain[,-nzv]

##处理高度xian xinxianxin


