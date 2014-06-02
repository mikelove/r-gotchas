# Some R gotchas

[Here](http://stackoverflow.com/questions/1535021/whats-the-biggest-r-gotcha-youve-run-across)
is a stackoverflow discussion with many R gotchas. Below I recreate
those which I consider important to be aware of. Some of these are not
a fault of the language per se, but I list them here anyway.

### Dropped dimensions

For matrix:


```r
m <- matrix(1:6, ncol=3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

```r
m[1,] # vector
```

```
## [1] 1 3 5
```

```r
m[,1] # vector
```

```
## [1] 1 2
```

```r
m[1,,drop=FALSE] # matrix
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
```

For data.frame:


```r
df <- data.frame(a=1:3,b=4:6)
df
```

```
##   a b
## 1 1 4
## 2 2 5
## 3 3 6
```

```r
df[1,] # data.frame
```

```
##   a b
## 1 1 4
```

```r
df[,1] # vector
```

```
## [1] 1 2 3
```

```r
df[,1,drop=FALSE] # data.frame
```

```
##   a
## 1 1
## 2 2
## 3 3
```

### stringsAsFactors: data.frame and read.table


```r
df <- data.frame(a=c("10","11","12"))
as.numeric(df$a) + 1
```

```
## [1] 2 3 4
```

```r
df <- data.frame(a=c("10","11","12"), stringsAsFactors=FALSE)
as.numeric(df$a) + 1
```

```
## [1] 11 12 13
```

### Logical operators


```r
c(TRUE,TRUE,FALSE) & c(FALSE,TRUE,TRUE) # element-wise
```

```
## [1] FALSE  TRUE FALSE
```

```r
c(TRUE,TRUE,FALSE) && c(FALSE,TRUE,TRUE) # just the first
```

```
## [1] FALSE
```

```r
x <- "hi"
is.numeric(x) && x + 1 # evaluates left to right
```

```
## [1] FALSE
```

```r
is.numeric(x) & x + 1 # produces error
```

```
## Error: non-numeric argument to binary operator
```

### sapply() and apply() return columns


```r
m <- matrix(1:6, ncol=3)
m^2
```

```
##      [,1] [,2] [,3]
## [1,]    1    9   25
## [2,]    4   16   36
```

```r
apply(m, 2, `^`, 2) # column-wise, ok
```

```
##      [,1] [,2] [,3]
## [1,]    1    9   25
## [2,]    4   16   36
```

```r
apply(m, 1, `^`, 2) # gives back row-wise operation as columns
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    9   16
## [3,]   25   36
```

### Column names restricted characters


```r
df <- data.frame("test-it-#1"=1:2)
df
```

```
##   test.it..1
## 1          1
## 2          2
```

```r
make.names("test-it-#1") # this function is used
```

```
## [1] "test.it..1"
```

### Removing columns by name


```r
df <- data.frame(a=1:2,b=3:4,c=5:6,d=7:8)
df[,-(2:3)] # numeric index ok 
```

```
##   a d
## 1 1 7
## 2 2 8
```

```r
df[,-c("b","c")] # not character index
```

```
## Error: invalid argument to unary operator
```

```r
subset(df, select=-c(b,c)) # by name works here
```

```
##   a d
## 1 1 7
## 2 2 8
```

### Safer to use seq_along and seq_len


```r
x <- numeric(0)
1:length(x)
```

```
## [1] 1 0
```

```r
seq_len(length(x))
```

```
## integer(0)
```

```r
seq_along(x)
```

```
## integer(0)
```

### is.na and is.null


```r
x <- c(1,2,NA,NULL)
which(x == NA)
```

```
## integer(0)
```

```r
which(is.na(x))
```

```
## [1] 3
```

```r
y <- NULL
y == NULL
```

```
## logical(0)
```

```r
is.null(y)
```

```
## [1] TRUE
```

### Formulas save variables in environment even if not referenced

This is clear from the formula class description, but good to know in the era of large datasets.


```r
f <- function() {
  y <- 1:10
  form <- ~ 1
  form
}
get("y", environment(f()))
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

