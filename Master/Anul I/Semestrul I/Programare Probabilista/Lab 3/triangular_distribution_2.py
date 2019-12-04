import pymc as pm
import numpy as np
from matplotlib import pyplot as plt

def triangular_logp(value, a, b, c):
    if a <= value < c:
        return np.log((2. * (value - a)) / ((b - a) * (c - a)))
    if value == c:
        return np.log(2. / (b - a))
    if c < value <= b:
        return np.log((2. * (b - value)) / ((b - a) * (b - c)))
    return -np.inf

def triangular_random(a, b, c):
    return np.random.triangular(a, c, b)


Z = pm.Stochastic( logp = triangular_logp,
                doc = 'Triangular Distribution',
                name = 'Z',
                parents = {'a': -3, 'b': 8, 'c': 0},
                random = triangular_random,
                trace = True,
                value = 0,
                dtype = float,
                rseed = 1.,
                observed = False,
                cache_depth = 2,
                plot=True,
                verbose = 0)

model = pm.Model([Z])

mcmc = pm.MCMC(model)
mcmc.sample(40000, 10000, 1)
Z_samples = mcmc.trace('Z')[:]

plt.hist(Z_samples, bins = 40)
plt.show()



