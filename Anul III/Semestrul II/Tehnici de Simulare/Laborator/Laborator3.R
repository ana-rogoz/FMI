# Metoda Monte Carlo

# -1 
next_n <- function(N){
  N = N * N
  new_number = N%%1000%/%10;
  new_number = new_number%%10 + new_number%/%10;
  new_number = new_number%%10 + new_number%/%10;
  return (new_number)
}

cicle_length = integer(99)
for (index in 1:99){
  freq <- integer(100)
  steps <- 1
  curr_val = index
  freq[curr_val+1] = 1
  while(1) {
    curr_val = next_n(curr_val);
    if (freq[curr_val+1] == 1) {
      break;
    }
    steps <- steps + 1
    freq[curr_val+1] = 1
  }
  cicle_length[index] = steps
}

mean_cicle_length = sum(cicle_length)/99

# 0
x0 <- runif(10000, 0, 1)
f0 <- function(x)(1-x^2)^(3/2)
integrala_0 <- sum(f0(x0))/10000

# 0'
x0_1 <- runif(200000, -2, 2)
f0_1 <- function(x)((exp(1)^(x + x^2))*4)
integrala_0_1 <- sum(f0_1(x0_1))/200000

# 1 -> take a = pi
x1 <- runif(200000, 0, 1)
f1 <- function(y)((((1-y)/y)^(pi-1)) * (exp(1)^((y-1)/y)) * (1/y^2))
integrala_1 <- sum(f1(x1))/200000

# 2
x2 <- runif(100000, 0, 1)
y2 <- runif(100000, 0, 1)
f2 <- function(x, y)(exp(1)^((x-y)^2))
integrala_2 <- sum(f2(x2, y2))/100000

# 3 cov(U, e^U); cov(X, Y) = E(XY) - E(X)*E(Y)
x3 <- runif(100000, 0, 1)
f3_0 <- function(x)(exp(1)^x)
y3 <- f3_0(x3) 
f3 <- function(x, y)(x*y)
integrala_3 <- sum(f3(x3,y3))/100000 - sum(x3)*sum(y3)/10000000000

# 4
N = 10000
y4 <- integer(N)
for (index in 1:N){
  x4 <- runif(100, 0, 1)
  sum <- 0
  for (i in 1:100) {
    sum <- sum + x4[i]
    if (sum > 1) {
      y4[index] = i;
      break;
    }
  }
}
estimated_N = sum(y4)/N
