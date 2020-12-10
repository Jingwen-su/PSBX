#简介
#基于在研究rsympy时引入的Reticulate包，我将在这里对Reticulate包进行解释和练习，以加深理解。
#reticulat包，它包含了用于Python和R之间协同操作的全套工具，在R和Rstudio中均可使用。
#包括：
#1）在R中支持多种方式调用Python。包括R Markdown、加载Python脚本、导入Python模块以及在R会话中交互式地使用Python。
#2）实现R和Python对象之间的转换(例如R和Python数据框、R矩阵与NumPy数组之间)。

install.packages("reticulate")
library("reticulate")
py_available()
use_condaenv("/Users/jingwensu/opt/anaconda3")

py_config()
py_available()
py_module_available("pandas")

install_miniconda()
miniconda_path()
miniconda_update()

os <- import("os")
os$listdir("./")

py_install("seaborn")
py_module_available("seaborn")

sns <- import("seaborn")
tips <- sns$load_dataset("tips")
print(head(tips))



library(rSymPy)




