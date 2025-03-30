
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

# Numerically check equations
# Provided numerical values
l_val   = 0.2051955299348816
a_vals  = [-0.15796008667982392, 0.06346529113687596, -1.131552999087326,
0.42079842968300063, -1.1566363660031738, 0.34193922432579843,
1.021357925042764, -0.06570944726252272, -0.3772888980405106,
-0.36074314712616484, 0.2399067209390549, 0.30830197876798765,
0.9683992777695778]

# Compute cosine and sine values numerically
c = [cos(a) for a in a_vals]
s = [sin(a) for a in a_vals]

# Assign numerical values to polynomial variables
subs = {
    l: l_val,
    c1: c[1], s1: s[1],
    c3: c[3], s3: s[3],
    c4: c[4], s4: s[4],
    c6: c[6], s6: s[6],
    c7: c[7], s7: s[7],
    c12: c[12], s12: s[12]
}

# Numerically evaluate the system of equations
numerical_results = [eq.subs(subs).n() for eq in Sys2]

for i, res in enumerate(numerical_results):
    print(f"Equation {i}: {res}")


print("Eliminate trigonometric variables :", Sys2)
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


        
t1 = stime()
print("Number of solutions = 1 found in %6.3f seconds." % (t1 - t0))

