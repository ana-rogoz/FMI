x <- c( 1:10, 2:35 , 50 , 100 , 1000)

par(mfrow = c(3,2))

curve(dt(x, 30), from = -5, to = 5, col = "orange", 
      xlab = "quantile", ylab = "density")
curve(dt(x, 10), from = -5, to = 5, col = "dark green", add = TRUE)
curve(dt(x, 5), from = -5, to = 5, col = "sky blue", add = TRUE)
curve(dt(x, 1), from = -5, to = 5, col = "grey40", add = TRUE)

curve(pt(x, 30), from = -5, to = 5, col = "orange")
curve(pt(x, 10), from = -5, to = 5, col = "dark green", add = TRUE)
curve(pt(x, 5), from = -5, to = 5, col = "sky blue", add = TRUE)
curve(pt(x, 1), from = -5, to = 5, col = "grey40", add = TRUE)

curve(df(x, 15,15), from = -5, to = 5, col = "orange", 
      xlab = "quantile", ylab = "density", lwd = 2)
curve(df(x, 10,8), from = 0, to = 5, col = "dark green", add = TRUE, lwd = 2)
curve(df(x, 5,3), from = 0, to = 5, col = "sky blue", add = TRUE, lwd = 2)
curve(df(x, 1,12), from = 0, to = 5, col = "grey40", add = TRUE, lwd = 2)

curve(pf(x, 15,15), from = -5, to = 5, col = "orange", lwd = 2)
curve(pf(x, 10,8), from = 0, to = 5, col = "dark green", add = TRUE, lwd = 2)
curve(pf(x, 5,3), from = 0, to = 5, col = "sky blue", add = TRUE, lwd = 2)
curve(pf(x, 1,12), from = 0, to = 5, col = "grey40", add = TRUE, lwd = 2)

curve(dchisq(x, 30), from = -2, to = 5, col = "orange", 
      xlab = "quantile", ylab = "density", lwd = 2)
curve(dchisq(x, 20), from = -2, to = 5, col = "dark green", add = TRUE, lwd = 2)
curve(dchisq(x, 15), from = -2, to = 5, col = "sky blue", add = TRUE, lwd = 2)
curve(dchisq(x, 5), from = -2, to = 5, col = "grey40", add = TRUE, lwd = 2)

curve(pchisq(x, 30), from = -2, to = 5, col = "orange",lwd = 2)
curve(pchisq(x, 20), from = -2, to = 5, col = "dark green", add = TRUE, lwd = 2)
curve(pchisq(x, 15), from = -2, to = 5, col = "sky blue", add = TRUE, lwd = 2)
curve(pchisq(x, 5), from = -2, to = 5, col = "grey40", add = TRUE, lwd = 2)

