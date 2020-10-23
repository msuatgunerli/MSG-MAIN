"""
sudoku = [[3,0,0,0,0,1,4,2,5],
          [0,0,0,0,0,9,8,0,1],
          [0,5,0,2,8,0,9,0,0],
          [0,2,0,0,0,6,0,9,7],
          [0,0,3,0,0,0,6,0,0],
          [5,4,0,8,0,0,0,1,0],
          [0,0,2,0,1,8,0,5,0],
          [6,0,9,5,0,0,0,0,0],
          [7,1,5,6,0,0,0,0,1]] 
"""

import numpy as np
#print ("Başlangıç")
#print(np.matrix(sudoku))

print("Enter the Rows From Left to Right Using No Spaces (Use 0 if blank): ")
R1 = input("Enter the First Row: ")
list(R1)
if len(R1) != 9:
    print("Wrong Number of Elements")
elif len(R1) == 9:
    continue
"""
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

if __name__ == "__main__":
    solve()
"""