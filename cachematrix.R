#makeCacheMatrix creates a special "vector", which is really a list containing a function to
#set the value of the matrix
#get the value of the matrix
#set the value of the matrix inverse
#get the value of the matrix inverse from the cache (including NULL values, on first use)

makeCacheMatrix <- function(x = matrix()) {
    m_inverse <- NULL
    set <- function(y) {
	x <<- x
	m_inverse <<- NULL
    }
    get <- function() x
    set_inverse <- function(m_inverse) m <<- m_inverse
    get_inverse <- function() m_inverse
    list(set = set, get = get,
	set_inverse = set_inverse,
	get_inverse = get_inverse)
}


#The following function calculates the inverse of the special "matrix"
#created with the above function. However, it first checks to see if the
#inverse has already been calculated. If so, it `get`s the inverse from the
#cache and skips the computation. Otherwise, it calculates the inverse of
#the matrix using the solve function and sets the value of the inverse in the
#cache via the `setinverse` function.

cacheSolve <- function(x, ...) {
    m_inverse <- x$get_inverse()
	if(!is.null(m_inverse)) {
	    message("getting cached data")
	    return(m_inverse)
	}
    data <- x$get()
    m_inverse <- solve(data, ...)
    x$set_inverse(m_inverse)
    m_inverse
}

