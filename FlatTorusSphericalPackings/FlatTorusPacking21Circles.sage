
from time import time as stime

# Define the number field Q(sqrt(3))
K = QuadraticField(3, 'a')  # Define Q(sqrt(3)) with generator `a`
a = K.gen()                 # Generator for sqrt(3)

# Define the polynomial ring over Q(sqrt(3)) instead of Z[sqrt(3)]
R.<s0, c0, s1, c1, s2, c2, c3, s3, l> = PolynomialRing(K)

# Define the system of equations with additional trigonometric constraints
Sys2 = [
    # eq1
    18*l**2-2*l*(a*s0+4*c0)+1,
    # eq2
    l**2*((a*s0+11*c0)*c3-(a*c0-11*s0)*s3-31)-l*((a-11)*c0-(a+11)*s0+2*c3+2*s3)-2,
    # eq3
    l**2*(2*(a*s1-8*c1)*c0-2*(a*c1+8*s1)*s0-67)-2*l*((a-16)*c0-2*(a+4)*s0-2*c1-s1)-5,
    # eq4
    l**2*(2*(a*s1-6*c1)*c0+2*(a*s0+c1+6*c0)*c2+2*(a*s0+c1+6*c0-c2)*c3-2*(a*c1+6*s1)*s0-2*(a*c0-s1-6*s0)*s2-2*(a*c0-s1-6*s0+s2)*s3-41)-2*l*((a-6)*c0-(a+6)*s0-c1+c2+c3-s1+s2+s3)-2,
    # eq5
    l**2*((a*s1-9*c1)*c0+(a*s0+2*c1+9*c0)*c2-(a*c1+9*s1)*s0-(a*c0-2*s1-9*s0)*s2-22)-l*((a-9)*c0-(a+9)*s0-2*c1+2*c2-2*s1+2*s2)-2,
    # Trigonometric constraints
    c0^2 + s0^2 - 1,  # Ensures (c0, s0) is on the unit circle
    c1^2 + s1^2 - 1,  # Ensures (c1, s1) is on the unit circle
    c2^2 + s2^2 - 1,  # Ensures (c2, s2) is on the unit circle
    c3^2 + s3^2 - 1   # Ensures (c3, s3) is on the unit circle
]

# Generate the ideal for the system of equations
J1 = R.ideal(Sys2)

# Print the solution dimension
print("Ideal = ", J1)

# Solve for the variety of the ideal
t0 = stime()
E = J1.elimination_ideal( [s0, c0, s1, c1, s2, c2, c3, s3] )
f = E.gen(0).change_ring( QuadraticField(3) )
P = factor(f)[0][0]
print(P)


# Convert P to a univariate polynomial ring over Q(sqrt(3))
K = QuadraticField(3, 'a')  # Define Q(sqrt(3)) with generator 'a'
a = K.gen()
R.<l> = PolynomialRing(K)  # Define a univariate polynomial ring in x over Q(sqrt(3))
P_univar = R(P)  # Convert the multivariate polynomial to a univariate polynomial


print(P_univar)

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
print(R_term)
# Accumulate terms in R_part and Q_part
R_part += R_term * l^i
Q_part += Q_term * l^i

print("R part of P:", R_part)
print("Q part of P:", Q_part)
 
# Construct the norm polynomial: P * P^* = (R + a*Q) * (R - a*Q) = R^2 - 3*Q^2
P_integer = (R_part^2 - 3 * Q_part^2)  # Norm polynomial over Z

print("Norm polynomial over Z:")
print(P_integer)

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


# Specify the value of interest
target_value = 0.222692694476667333403160

# Find the root closest to the target value
closest_root = min(numerical_roots, key=lambda r: abs(r - target_value))

# Display the closest root
print(f"The root closest to {target_value} is approximately {closest_root}.")
 
        
t1 = stime()
print("Number of solutions = 1 found in %6.3f seconds." % (t1 - t0))

quit()