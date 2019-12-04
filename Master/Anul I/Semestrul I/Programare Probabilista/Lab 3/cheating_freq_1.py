import pymc as pm
from matplotlib import pyplot as plt


N = 100
p = pm.Uniform("freq_cheating", 0, 1)
true_answers = pm.Bernoulli("truths", p, size=N)
first_coin_flips = pm.Bernoulli("first_flips", 0.5, size=N)
second_coin_flips = pm.Bernoulli("second_flips", 0.5, size=N)

@pm.deterministic
def observed_proportion(t_a=true_answers,
                        fc=first_coin_flips,
                        sc=second_coin_flips):

    observed = fc * t_a + (1 - fc) * sc
    return observed.sum() / float(N)

X = 35

observations = pm.Binomial("obs", N, observed_proportion, observed=True, value=X)


model = pm.Model([p, true_answers, first_coin_flips,
                  second_coin_flips, observed_proportion, observations])

# To be explained in Chapter 3!
mcmc = pm.MCMC(model)
mcmc.sample(40000, 15000)

p_trace = mcmc.trace("freq_cheating")[:]
plt.hist(p_trace, histtype="stepfilled", normed=True, alpha=0.85, bins=30,
         label="posterior distribution", color="#348ABD")
plt.vlines([.05, .35], [0, 0], [5, 5], alpha=0.3)
plt.xlim(0, 1)
plt.legend()

plt.show()



