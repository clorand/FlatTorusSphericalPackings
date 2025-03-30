import matplotlib.pyplot as plt
from matplotlib.patches import Circle
import matplotlib.cm as cm
import matplotlib.colors as mcolors
import numpy as np
from _overlapped import NULL
import sympy as sp

l   = 0.2051955299348816
a0  = -0.15796008667982392
a1  = 0.06346529113687596
a2  = -1.131552999087326
a3  = 0.42079842968300063
a4  = -1.1566363660031738
a5  = 0.34193922432579843
a6  = 1.021357925042764
a7  = -0.06570944726252272
a8  = -0.3772888980405106
a9  = -0.36074314712616484
a10 = 0.2399067209390549
a11 = 0.30830197876798765
a12 = 0.9683992777695778

J = (1+1j*np.sqrt(3))/2

e0 = np.exp(1j*a0)   # red
e1 = np.exp(1j*a1)   # yellow
e2 = np.exp(1j*a2)   # cyan
e3 = np.exp(1j*a3)   # blue
e4 = np.exp(1j*a4)   # magenta
e5 = np.exp(1j*a5)   # purple
e6 = np.exp(1j*a6)   # green
e7 = np.exp(1j*a7)   # white
e8 = np.exp(1j*a8)   # pink
e9 = np.exp(1j*a9)   # brown
e10 = np.exp(1j*a10) # gray
e11 = np.exp(1j*a11) # olive
e12 = np.exp(1j*a12) # teal

print('l', l)
print('a0', a0)
print('a1', a1)
print('a2', a2)
print('a3', a3)
print('a4', a4)
print('a5', a5)
print('a6', a6)
print('a7', a7)
print('a8', a8)
print('a9', a9)
print('a10', a10)
print('a11', a11)
print('a12', a12)

#0 3 5 6 7 12 l | 1 2 4 8 9 10 11   

eq1 = (3*e0+e3-1/l)-(-e1)
eq2 = ((2*J**2+J)*e0+e3-1j/l)-(e2+e4)
eq3 = (-e0-e3+e6)-(-e2-e11)
eq4 = (-J**2*e0-e5+e6)-(-e1+e9)
eq5 = ((J**2-1)*e0-J**2*e7)-(e1-e8-e10)
eq6 = (-e0+J*e7-e3+e5)-(-e4)
eq7 = (-e0+e12)-(-e4-e10+e11)

print(-e0, e12, e10, e8, -e11)


print("eq1", np.allclose(eq1,0))
print("eq2", np.allclose(eq2,0))
print("eq3", np.allclose(eq3,0))
print("eq4", np.allclose(eq4,0))
print("eq5", np.allclose(eq5,0))
print("eq6", np.allclose(eq6,0))
print("eq7", np.allclose(eq7,0))

# Matrix form
A = sp.Matrix([e1, e2, e4, e8, e9, e10, e11])
M = sp.Matrix([[-1, 0, 0, 0, 0, 0, 0],
               [ 0, 1, 1, 0, 0, 0, 0],
               [ 0,-1, 0, 0, 0, 0,-1],
               [-1, 0, 0, 0, 1, 0, 0],
               [ 1, 0, 0,-1, 0,-1, 0],
               [ 0, 0,-1, 0, 0, 0, 0],
               [ 0, 0,-1, 0, 0,-1, 1]])


B = sp.Matrix([3*e0+e3-1/l, (2*J**2+J)*e0+e3-1j/l, -e0-e3+e6, -J**2*e0-e5+e6, (J**2-1)*e0-J**2*e7, -e0+J*e7-e3+e5, -e0+e12])




print("A=", A)
print("B=", B)
print("M*A-B=0?", np.allclose(M*A-B, 0))
print("A-M^(-1)B=0?", np.allclose(A-M.inv()*B, 0))
print("M^(-1)", M.inv())
