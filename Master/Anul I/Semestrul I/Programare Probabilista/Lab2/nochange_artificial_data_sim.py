import numpy as np
import pymc as pm
from matplotlib import pyplot as plt

alpha = 1. / 20.
lambda_ = pm.rexponential(alpha)
print(lambda_)

data = np.r_[pm.rpoisson(lambda_, 80)]

np.savetxt("txtdata_sim.csv", data)

plt.bar(np.arange(80), data, color="#348ABD")
plt.xlabel("Time (days)")
plt.ylabel("count of text-msgs received")
plt.title("Artificial dataset")
plt.xlim(0, 80)

plt.show()

