#makeCacheMatrix creates a special "vector", which is really a list containing a function to
#set the value of the matrix
#get the value of the matrix
#set the value of the matrix inverse
#get the value of the matrix inverse from the cache (including NULL values, on first use)

makeCacheMatrix <- function(x = matrix()) {
    mInverse <- NULL
    set <- function(y) {
	x <<- x
	mInverse <<- NULL
    }
    get <- function() x
    setInverse <- function(computedInverse)  mInverse <<- computedInverse
    getInverse <- function() mInverse
    list(set = set, get = get,
	setInverse = setInverse,
	getInverse = getInverse)
}


#The following function calculates the inverse of the special "matrix"
#created with the above function. However, it first checks to see if the
#inverse has already been calculated. If so, it `get`s the inverse from the
#cache and skips the computation. Otherwise, it calculates the inverse of
#the matrix using the solve function and sets the value of the inverse in the
#cache via the `setinverse` function.

cacheSolve <- function(x, ...) {
    mInverse <- x$getInverse()
    if(!is.null(mInverse)) {
	message("getting cached data")
	return(mInverse)
    }
    data <- x$get()
    mInverse <- solve(data, ...)
    x$setInverse(mInverse)
    mInverse
}

