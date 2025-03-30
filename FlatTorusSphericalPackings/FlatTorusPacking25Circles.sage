
from time import time as stime

# Define the number field Q(sqrt(3))
K = QuadraticField(3, 'a')  # Define Q(sqrt(3)) with generator `a`
a = K.gen()                 # Generator for sqrt(3)

# Define the polynomial ring over Q(sqrt(3)) instead of Z[sqrt(3)]
R.<s1, c1, s3, c3, s4, c4, c6, s6, c7, s7, c12, s12, l> = PolynomialRing(K)

# Define the system of equations with additional trigonometric constraints
Sys2 = [
l**2*(2*c1*c3 + 2*s1*s3 - 7) - l*(2*c1 + 2*c3) + 1 ,
-9*a + l**2*(9*a*(-c1*s3 + c1*s4 + c3*s1 + c3*s4 - c4*s1 - c4*s3) + 17*c1*c3 - 3*c1*c4 - 21*c3*c4 + 17*s1*s3 - 3*s1*s4 - 21*s3*s4 + 26) + l*(c1*(9*a - 14) + c3*(9*a - 17) + 3*c4 - 3*s1 + s3*(9*a - 21) + s4*(18 - 9*a)) + 16 ,
l**2*(3*a*(-c1*s7 + 2*c3*s7 - 3*c4*s7 + c7*s1 - 2*c7*s3 + 3*c7*s4) - 4*c1*c3 + 6*c1*c4 + 3*c1*c7 - 12*c3*c4 - 6*c3*c7 + 9*c4*c7 - 4*s1*s3 + 6*s1*s4 + 3*s1*s7 - 12*s3*s4 - 6*s3*s7 + 9*s4*s7 + 14) + l*(3*a*s7 - 2*c1 + 4*c3 - 6*c4 - 3*c7) + 1 ,
-a + l**2*(a*(c1*s4 - c1*s6 + c3*s4 - c3*s6 - c4*s1 - c4*s3 + c6*s1 + c6*s3) + 2*c1*c3 - c1*c4 + c1*c6 - c3*c4 + c3*c6 - 2*c4*c6 + 2*s1*s3 - s1*s4 + s1*s6 - s3*s4 + s3*s6 - 2*s4*s6 + 3) + l*(a*(c1 + c3 - s4 + s6) - 2*c1 - 2*c3 + c4 - c6 - s1 - s3 + 2*s4 - 2*s6) + 2 ,
-9*a + l**2*(9*a*(-c1*s12 - c1*s6 + c12*s1 + c12*s3 - c3*s12 - c3*s6 + c6*s1 + c6*s3) + 15*c1*c12 + 26*c1*c3 + 15*c1*c6 + 15*c12*c3 + 18*c12*c6 + 15*c3*c6 + 15*s1*s12 + 26*s1*s3 + 15*s1*s6 + 15*s12*s3 + 18*s12*s6 + 15*s3*s6 + 35) + l*(9*a*(c1 + c3 + s12 + s6) - 26*c1 - 15*c12 - 26*c3 - 15*c6 - 15*s1 - 18*s12 - 15*s3 - 18*s6) + 22 ,
l**2*(3*a*(-2*c1*s3 + c1*s4 + c1*s6 - 3*c1*s7 + 2*c3*s1 + c3*s4 + c3*s6 + 3*c3*s7 - c4*s1 - c4*s3 - 3*c4*s7 - c6*s1 - c6*s3 - 3*c6*s7 + 3*c7*s1 - 3*c7*s3 + 3*c7*s4 + 3*c7*s6) - 16*c1*c3 + 21*c1*c4 + 21*c1*c6 + 15*c1*c7 - 15*c3*c4 - 15*c3*c6 - 3*c3*c7 + 18*c4*c6 + 9*c4*c7 + 9*c6*c7 - 16*s1*s3 + 21*s1*s4 + 21*s1*s6 + 15*s1*s7 - 15*s3*s4 - 15*s3*s6 - 3*s3*s7 + 18*s4*s6 + 9*s4*s7 + 9*s6*s7 + 38) + l*(3*a*(-s1 + s3 - s4 - s6) - 5*c1 + c3 - 3*c4 - 3*c6 - 6*c7) + 1 ,
-6*a + l**2*(3*a*(-2*c1*s12 + 2*c1*s3 - 2*c1*s6 - 3*c1*s7 + 2*c12*s1 + 2*c12*s3 - 3*c12*s7 - 2*c3*s1 - 2*c3*s12 - 2*c3*s6 + 2*c6*s1 + 2*c6*s3 - 3*c6*s7 + 3*c7*s1 + 3*c7*s12 + 3*c7*s6) + 24*c1*c12 + 14*c1*c3 + 24*c1*c6 - 21*c1*c7 + 6*c12*c3 + 18*c12*c6 - 9*c12*c7 + 6*c3*c6 - 12*c3*c7 - 9*c6*c7 + 24*s1*s12 + 14*s1*s3 + 24*s1*s6 - 21*s1*s7 + 6*s12*s3 + 18*s12*s6 - 9*s12*s7 + 6*s3*s6 - 12*s3*s7 - 9*s6*s7 + 41) + l*(3*a*(2*c1 + 2*c3 - 3*c7 + 2*s1 + 2*s12 + 2*s6) - 14*c1 - 6*c12 - 8*c3 - 6*c6 + 12*c7 - 24*s1 - 18*s12 - 6*s3 - 18*s6 + 9*s7) + 13 ,
c1^2 + s1^2 - 1,  # Ensures (c0, s0) is on the unit circle
c3^2 + s3^2 - 1,  # Ensures (c1, s1) is on the unit circle
c4^2 + s4^2 - 1,  # Ensures (c2, s2) is on the unit circle
c6^2 + s6^2 - 1,   # Ensures (c3, s3) is on the unit circle
c7^2 + s7^2 - 1,  # Ensures (c1, s1) is on the unit circle
c12^2 + s12^2 - 1
]

print("Starting Computations :", Sys2)
# Generate the ideal for the system of equations
J1 = R.ideal(Sys2)

# Print the solution dimension
print("Ideal = ", J1)

# Solve for the variety of the ideal
t0 = stime()
E = J1.elimination_ideal( [s1, c1, s3, c3, s4, c4, c6, s6, s7, c7, s12, c12] )
f = E.gen(0).change_ring( QuadraticField(3) )
P = factor(f)[0][0]
print(P)


# Convert P to a univariate polynomial ring over Q(sqrt(3))
K = QuadraticField(3, 'a')  # Define Q(sqrt(3)) with generator 'a'
a = K.gen()
R.<l> = PolynomialRing(K)  # Define a univariate polynomial ring in x over Q(sqrt(3))
P_univar = R(P)  # Convert the multivariate polynomial to a univariate polynomial

# Convert P to the complex field (CC) to find numerical roots
P_complex = P_univar.change_ring(CC)

# Find the roots numerically
numerical_roots = P_complex.roots(multiplicities=False)

# Display each root
print("Numerical roots of the polynomial P:")
for i, root in enumerate(numerical_roots, 1):
    print(f"Root {i}: {root}")
    

    
# Initialize R_part and Q_part as zero polynomials
R_part = R(0)
Q_part = R(0)

# Separate P into R and Q parts
for i, coeff in enumerate(P_univar.coefficients(sparse=False)):
    # Separate parts in terms of the number field generator `a`
    # constant term (part without `a`)
    R_term = coeff.trace() / 2  # Real part or "constant" part
    # term involving `a`
    Q_term = (coeff - R_term) / a  # Imaginary part in terms of `a`
    
    # Accumulate terms in R_part and Q_part
    R_part += R_term * l^i
    Q_part += Q_term * l^i

print("R part of P:", R_part)
print("Q part of P:", Q_part)

# Construct the norm polynomial: P * P^* = (R + a*Q) * (R - a*Q) = R^2 - 3*Q^2
P_integer = (R_part^2 - 3 * Q_part^2)  # Norm polynomial over Z


print("Norm polynomial over Z:")
print(P_integer)

'''
prec = 200  # Set a high precision level (200 bits should be enough)
CC = ComplexField(prec)

# Convert P to the complex field (CC) to find numerical roots
P_complex = P_integer.change_ring(CC)

# Find the roots numerically
numerical_roots = P_complex.roots(multiplicities=False)

# Display each root
print("Numerical roots of the polynomial P:")
for i, root in enumerate(numerical_roots, 1):
 print(f"Root {i}: {root}")
    
# Enumerate coefficients with powers
for power, coeff in enumerate((8*75497472*2477483004346470106833095944308480723151456937914680261903046720484565350094997173021589470410965115954169577432650033*P_integer).coefficients(sparse=False)):
 if coeff!=0:
  print(f"Coefficient of x^{power}: {coeff}") 
 
P_complex = 8*75497472*2477483004346470106833095944308480723151456937914680261903046720484565350094997173021589470410965115954169577432650033*P_integer.change_ring(CC)
# Find the roots numerically
numerical_roots = P_complex.roots(multiplicities=False)

# Display each root
print("Numerical roots of the polynomial P:")
for i, root in enumerate(numerical_roots, 1):
 print(f"Root {i}: {root}")

 '''

        
t1 = stime()
print("Number of solutions = 1 found in %6.3f seconds." % (t1 - t0))

