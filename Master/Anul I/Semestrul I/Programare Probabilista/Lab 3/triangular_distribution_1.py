import pymc as pm
import numpy as np
from matplotlib import pyplot as plt

a = -3
b = 8
c = 0

@pm.stochastic(dtype=float)
def Z(value = c, a = a, b = b, c = c):

    def logp(value, a, b, c):
        if a <= value < c:
            return np.log((2. * (value - a)) / ((b - a) * (c - a)))
        if value == c:
            return np.log(2. / (b - a))
        if c < value <= b:
            return np.log((2. * (b - value)) / ((b - a) * (b - c)))
        return -np.inf
    
    def random(a, b, c):
        return np.random.triangular(a, c, b)

model = pm.Model([Z])

mcmc = pm.MCMC(model)
mcmc.sample(40000, 10000, 1)
Z_samples = mcmc.trace('Z')[:]

plt.hist(Z_samples, bins = 40)
plt.show()



