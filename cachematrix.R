#makeCacheMatrix creates a special "vector", which is really a list containing a function to
#set the value of the matrix
#get the value of the matrix
#set the value of the matrix inverse
#get the value of the matrix inverse from the cache (including NULL values, on first use)
#Note that the set function can reset the underlying matrix

makeCacheMatrix <- function(x = matrix()) {
    mInverse <- NULL
    set <- function(y) {        #save matrix, placeholder for inverse
	x <<- y
	mInverse <<- NULL
    }
    get <- function() x        #return underlying matrix
    setInverse <- function(computedInverse)  mInverse <<- computedInverse
                               #set value of inverse to computed value
    getInverse <- function() mInverse   #return cached value
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
    mInverse <- x$getInverse()  #retrieve cached value, which may be null
    if(!is.null(mInverse)) {    #if not NULL retrieve and return inverse
	message("getting cached data")
	return(mInverse)
    }
    data <- x$get()             #if NULL--get matrix
    mInverse <- solve(data, ...)    #compute index
    x$setInverse(mInverse)          #set cached value
    mInverse                        #return inverse
}


#The instructions told us to return the cached value if the underlying
#matrix hasn't changed, but doesn't describe desired behavior if it has.
#I implemented an update-and-recache approach
#
#Here, safeCacheSolve adresses the possibility that the matrix
#whose inverse is cached changed after its inverse was stored.
#Given the cachedMatrix, and checkMatrix (the matrix whose inverse was cached,
#which may have been modified)
#It retrieves the underlying matrix for the cached inverse object and compares
#it to the matrix argument
#If the matrix hasn't changed, the cached index is returned
#If it has changed, the cachedMatrix object is updated, and the inverse
#is recomupted and cached.
#
#Alternative approach: Raise an error if the matrix changed, 
#                      otherwise, return cached value
safeCacheSolve <-function(checkMatrix = matrix(), cachedMatrix) {
   if (!identical(checkMatrix, cachedMatrix$get())) { #matrix has changed
	cachedMatrix$set(checkMatrix)                 #reset matrix in
                                                      #cachedMatrix
        message("matrix has changed, computing new inverse")  #inform user
        return(cacheSolve(cachedMatrix))    #recompute inverse, which
                                            #will be cached in the call
                                            #cacheSolve
   }
   cacheSolve(cachedMatrix) #cached value is valid, return it
}

