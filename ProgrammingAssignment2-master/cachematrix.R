## These two functions are programmed to cache time-consuming computations, taking advantage of the scoping rules of the R language
## and how they can be manipulated to preserve state inside of an R object. 

## (1)
## This function makeCacheMatrix() creates a special "matrix" object that can cache its inverse. It creates a list of functions to:
## 1. get the matrix, 
## 2. set the matrix, 
## 3. set the inverse and 
## 4. get the inverse
makeCacheMatrix <- function(x = matrix()) {
        n <- NULL
        set <- function(y) {
                x <<- y  ##assigns a value to an object in the parent environment
                n <<- NULL
        }
        get <- function() x ##gets the matrix
        setinverse <- function(inverse) n <<- inverse ##sets the inverse
        getinverse <- function() n ##gets the inverse
        list(set = set, 
             get = get,
             setinverse = setinverse,
             getinverse = getinverse) ##creates a list of functions that'll later be used as input in cacheSolve
}

## (2)
## This function computes the inverse of the special "matrix" returned by the above function. 
cacheSolve <- function(x, ...) {
        n <- x$getinverse()
        if(!is.null(n)) { ##if the inverse has already been calculated, function retrieves it from the cache w/out computing
                message("getting cached martix inverse")
                n ##print the output
        }
        matrix <- x$get() ##otherwise, function computes the inverse
        n <- solve(matrix, ...)
        x$setinverse(n)
        n ##print the output
}
