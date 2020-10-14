# -*- coding: utf-8 -*-
"""
Created on Mon Feb 17 21:49:13 2020

@author: mehme
"""
sudoku = [[9,2,0,0,1,4,0,0,0],
          [0,0,0,6,9,0,0,3,0],
          [8,0,6,0,0,0,0,4,0],
          [0,7,0,0,0,0,5,0,0],
          [3,5,0,0,0,0,8,0,7],
          [0,0,0,3,0,0,0,0,0],
          [6,0,4,0,0,5,0,2,0],
          [0,9,1,2,6,0,0,0,0],
          [0,0,0,0,8,0,0,5,1]]
import numpy as np
print ("Başlangıç")
print(np.matrix(sudoku))

def possible (y,x,n):
    global sudoku
    for i in range (0,9):
        if sudoku[y][i] == n:
            return False
    for i in range (0,9):
        if sudoku [i][x] == n:
            return False
    x0 = (x//3)*3
    y0 = (y//3)*3
    for i in range (0,3):
        for j in range (0,3):
            if sudoku [y0+i] [x0+j] == n:
                return False
        return True
        
def solve():
    global sudoku
    for y in range(9):
        for x in range(9):
            if sudoku [y][x] == 0:
                for n in range(1,10):
                    if possible(y,x,n):
                        sudoku [y][x] = n
                        solve()
                        sudoku [y][x] = 0
                return
    print("Sonuç")
    print(np.matrix(sudoku))
    input("Click Enter for Other Possible Solns")
        