import numpy as np

def simplexPrimal(A, b, c, B_idx):
    # Find B according to A and B_idx.
    m, n = A.shape
    x = np.zeros((n, 1))

    # R_idx union B_idx compose the entire A.
    R_idx = np.setdiff1d(np.array(list(range(n))), B_idx)

    print ("B_idx = " + str(B_idx))
    print ("R_idx = " + str(R_idx))

    while True:
        B = A[:, B_idx]
        x = np.zeros((n, 1))
        B_inv = np.linalg.inv(B)
        
        print ("B = \n" + str(B))
        print ("b = \n" + str(b))
        # Set x just on B_idx positions.      
        aux = B_inv @ b
        for i in range(len(aux)):
            x[B_idx[i]] = aux[i]

        print ("x =\n" + str(x))

        # Assert if x has any negative value
        if np.min(x) < 0:
            print ("Baza B primita nu este primal admisibila.")
            return

        # Step 1.
        # Calculating rj for each x in R_idx.
        rj = np.zeros((n, 1))
        rj_neg_idx = []
        for i in range(len(R_idx)):
            j = R_idx[i]
            rj[j] = c[j] - c[B_idx].transpose() @ B_inv @ A[:, j]
            if rj[j] < 0:
                rj_neg_idx.append(i)
        # rj is calculated just for the R indexes.

        print ("rj =\n" + str(rj))
        
        # Step 2: check if we have already fount optimal solution.
        if len(rj_neg_idx) == 0:
            print ("S-a gasit solutie optima:\n" + str(x))

            for i in range(len(R_idx)):
                if rj[R_idx[i]] == 0:
                    print ("Solutie degenerata")
                    break
            return x

        # dj represents directions to go from the actual point.
        dj = np.zeros((n, n))
        for j in range(len(rj_neg_idx)):
            aux = -B_inv @ A[:, rj_neg_idx[j]]
            for poz in range(len(aux)):
                dj[B_idx[poz]][rj_neg_idx[j]] = aux[poz]
            dj[j][rj_neg_idx[j]] = 1

            isInfinity = True
            for line in range(n):
                if dj[line][rj_neg_idx[j]] < 0:
                    isInfinity = False
            if isInfinity == True:
                print ("dj =\n" + str(dj))
                print ("S-a gasit solutie optima infinita pe directia/coloana " + str(rj_neg_idx[j]) )
                return x
        
        print ("dj =\n" + str(dj))

        # Change the base. This way guartees that there will be no cycles.
        outX = np.argmin(rj)
        colOutX = dj[:, outX]

        print ("outX = " + str(outX))

        inX = -1
        actMinDiv = 2 ** 31
        for i in range(n):
            if colOutX[i] < 0:
                if -x[i] / colOutX[i] < actMinDiv:
                    actMinDiv = -x[i] / colOutX[i]
                    inX = i
        
        print ("inX = " + str(inX))
        
        for i in range(len(B_idx)):
            if B_idx[i] == inX:
                B_idx[i] = outX
        
        for i in range(len(R_idx)):
            if R_idx[i] == outX:
                R_idx[i] = inX
        
        print ("B_idx = " + str(B_idx))
        print ("R_idx = " + str(R_idx))

    # Useless.
    return x
    

# A = np.array([[2, 4, 6, 1, 2], [3, 5, 7, 0, 1]])
# c = np.array([1, 3, 5, 7, 9])
# B_idx = np.array([3, 4])
# b = np.array([1, 5])
# x = simplexPrimal(A, b, c, B_idx) # Baza care nu e primal admisibila.

# A = np.array([[3, 2, 1, 1, 0], [2, 5, 3, 0, 1]])
# c = np.array([-2, -3, -4, 0, 0])
# B_idx = np.array([3, 4])
# b = np.array([10, 15])
# x = simplexPrimal(A, b, c, B_idx) # Solutie Buna

# A = np.array([[-1, -1, 1, 0, 0], [1, -1, 0, 1, 0], [-1, 1, 0, 0, 1]])
# c = np.array([-1, -1, 0, 0, 0])
# B_idx = np.array([2, 3, 4])
# b = np.array([1, 1, 1])
# x = simplexPrimal(A, b, c, B_idx) # Solutie infinita

# A = np.array([[-1, 1, 2, -3], [2, 2, -1, 1]])
# c = np.array([1, 2, 4, 3])
# B_idx = np.array([2, 3])
# b = np.array([1, 1])
# x = simplexPrimal(A, b, c, B_idx)

A = np.array([[2, 0, 0, 1, 0, 0], [0, 2, 0, 0, 1, 0], [0, 0, 2, 0, 0, 1]])
c = np.array([-1, -1, -1, 0, 0, 0])
B_idx = np.array([3, 4, 5])
b = np.array([1, 1, 1])
x = simplexPrimal(A, b, c, B_idx) # Solutie Buna
