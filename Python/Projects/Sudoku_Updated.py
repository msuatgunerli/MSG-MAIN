import numpy as np
print()
N=1
matrix = []

for i in range(9):
    print("Enter values for Row " + str(N) + " (separate using spaces and enter 0 for empty cells):")
    row = list(map(int, input().split()))
    if len(row) != 9:
        print("Wrong number of elements entered for Row " + str(N))
        break
    N=N+1
    matrix.append(row)

sudoku = matrix

def possible(y, x, n):
    global sudoku
    for i in range(0, 9):
        if sudoku[y][i] == n:
            return False
    for i in range(0, 9):
        if sudoku[i][x] == n:
            return False
    x0 = (x//3)*3
    y0 = (y//3)*3
    for i in range(0, 3):
        for j in range(0, 3):
            if sudoku[y0+i][x0+j] == n:
                return False
        return True


def solve():
    global sudoku
    for y in range(9):
        for x in range(9):
            if sudoku[y][x] == 0:
                for n in range(1, 10):
                    if possible(y, x, n):
                        sudoku[y][x] = n
                        solve()
                        sudoku[y][x] = 0
                return
    print("\n" + "SOLUTION" + "\n")
    print(np.matrix(sudoku))
    print()
    input("Click Enter for Other Possible Solns")


if __name__ == "__main__":
    solve()