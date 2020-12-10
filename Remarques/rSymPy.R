install.packages("reticulate")
library("reticulate")
py_available()
use_condaenv("/Users/jingwensu/opt/anaconda3")

py_config()
py_available()
py_module_available("pandas")


sympy <- import("sympy")
x = sympy$Symbol('x')
y = sympy$Symbol('y')
#k m n = sympy$symbols('k m n')
print(3*x+y**3)

repl_python()
import pandas as pd

source_python("/Users/jingwensu/Desktop/sympy.py")


install.packages("rSymPy")
library(rSymPy)
Q <- Var("Q")
n <- Var("n")
m <- Var("m")
g <- Var("g")
k <- Var("k")
Sf <- Var("Sf")
y <- Var("y")


sympy("expr = n*Q*(2*y*sqrt(1+m**2))**(2/3) - k*(m*y**2)**(5/3)*sqrt(Sf)")
sympy("solve(expr.subs([(Q, 1.2), (n, 0.045), (m, 3.4), (Sf, 0.2), (g, 9.806), (k, 1)]), y)")
out <- sympy("solve(expr.subs([(Q, 1.2), (n, 0.045), (m, 3.4), (Sf, 0.2), (g, 9.806), (k, 1)]), y)")
out <- as.numeric(unlist(strsplit(gsub("\\[|\\]", "", out), ",")))
length(out)
out


repl_python()#Créer une console Python

#Il y a un petit problème ici, je ne peux implémenter que du code python dans la console.
##from sympy import *
##x,y = symbols('x y')
##expr=sin(x)*exp(x)
##diff_expr=diff(expr, x)
##diff_expr2=diff(expr,x,2)
##print(diff_expr)
##print(diff_expr2)

exit#Retour à R

#Utilisez py $ object pour obtenir des objets en python
#Récupérez l'objet créé en R depuis Python: r.object
