class(1)
# "numeric"
class(TRUE)
# "logical"
class(rnorm(100))
# "numeric"
class(NA)
# "logical"
class("doosh")

# now more complex
x <- rnorm(100)
y <- x + rnorm(100)
fit <- lm(y ~ x) # linear regression
class(fit)


#s3 generic functions (base package)
mean
print

# checking methods available
methods("print")

# s4 generic function (methods package)
show

showMethods("show")

#s3 class/method example
set.seed(2)
x <- rnorm(100)
mean(x)

head(getS3method("mean", "default"), 10)

# another example
set.seed(3)
df <- data.frame(x = rnorm(100), y=1:100)
sapply(df, mean)

# example 3
set.seed(10)
x <- rnorm(100)
plot(x)
class(x)

x <- as.ts(x)
plot(x)
class(x)

# Defining an S4 Method
library(methods)
setClass("polygon",
         representation(x = "numeric",
                        y = "numeric"))
setMethod("plot", "polygon",
          function(x, y, ...){
            plot(x@x, x@y, type="n",...)
            xp <- c(x@x, x@x[1])
            yp <- c(x@y, x@y[1])
            lines(xp, yp)
          })

showMethods("plot")

p <- new("polygon", x = c(1, 2, 3, 4), y = c(1, 2, 3, 1))
plot(p)
class(p)

getMethod(plot)
