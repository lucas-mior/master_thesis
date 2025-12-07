from sympy import symbols, laplace_transform, exp, sin, cos, Heaviside
from sympy.abc import t, s

# Define some example functions of time
f1 = exp(-2*t)            # $e^{-2t}$
f2 = sin(3*t)             # $sin(3t)$
f3 = cos(5*t)             # $cos(5t)$
f4 = t**2                 # $t^2$
f5 = Heaviside(t-1)       # $u(t-1)$

# Compute Laplace transforms
L1 = laplace_transform(f1, t, s, noconds=True)
L2 = laplace_transform(f2, t, s, noconds=True)
L3 = laplace_transform(f3, t, s, noconds=True)
L4 = laplace_transform(f4, t, s, noconds=True)
L5 = laplace_transform(f5, t, s, noconds=True)

print("L{e^{-2t}} =", L1)
print("L{sin(3t)} =", L2)
print("L{cos(5t)} =", L3)
print("L{t^2} =", L4)
print("L{u(t-1)} =", L5)
