import numpy as np
from sympy import *

A = np.array ([[1,2],[2,1]]) # func0 X+2Y, func1 2X+Y

B1 = [5, 11, 17] # FUNC0 SONUÇLARI BURAYA - 1(1) + 2(2) = 5 ve 1(3) + 2(4) = 11 FALAN
B2 = [4, 10, 16] # FUNC1 SONUÇLARI BURAYA - 2(1) + 1(1) = 4 ve 2(3) + 1(4) = 10 FALAN

for n in range (0,3): #RAKAM SETİ KOYDUKÇA ARTIR BURAYI
    B = np.array([B1[n], B2[n]])
    X = np.linalg.solve(A,B)
    print("X"+ str(n) + " ve "  "Y" + str(n), str(X))
