# Some R gotchas

### Dropped dimensions


```r
m <- matrix(1:9, ncol=3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```

```r
m[1,] # vector
```

```
## [1] 1 4 7
```

```r
m[,1] # vector
```

```
## [1] 1 2 3
```

```r
m[1,,drop=FALSE] # matrix
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
```

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
df[,1,drop=FALSE]
```

```
##   a
## 1 1
## 2 2
## 3 3
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
m <- matrix(1:9, ncol=3)
m^2
```

```
##      [,1] [,2] [,3]
## [1,]    1   16   49
## [2,]    4   25   64
## [3,]    9   36   81
```

```r
apply(m, 2, `^`, 2) # column-wise, ok
```

```
##      [,1] [,2] [,3]
## [1,]    1   16   49
## [2,]    4   25   64
## [3,]    9   36   81
```

```r
apply(m, 1, `^`, 2) # gives back row-wise operation as columns
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    9
## [2,]   16   25   36
## [3,]   49   64   81
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
