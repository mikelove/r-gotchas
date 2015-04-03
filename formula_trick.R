makeFormula <- function(name) {
  y <- 1:10
  x <- 1:10
  out <- as.formula(paste("~",name), env=.GlobalEnv)
  out
}

f <- makeFormula("x")
ls(environment(f))

# now x and y are not in the environment of formula
