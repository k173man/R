## makeCacheMatrix and cacheSolve are used in tandem to implement a matrix inversion caching system

## makeCacheMatrix creates a special matrix object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  invrsmtrx <- NULL
  
  # set ensures that, if the matrix has changed, the old inverse matrix will not be returned
  set <- function(y) {
    x <<- y
    invrsmtrx <<- NULL
  }
  
  get <- function() x
  
  setinversematrix <- function(mtrx) invrsmtrx <<- mtrx
  
  getinversematrix <- function() invrsmtrx
  
  list(set = set, get = get,
       setinversematrix = setinversematrix,
       getinversematrix = getinversematrix)
}


## cacheSolve computes the inverse of the special "matrix" returned by makeCacheMatrix above
## if the inverse has been cached, then the cached invserse matrix will be return
## otherwise, the inverse will be computed, cached, and then returned
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  invrsmtrx <- x$getinversematrix()
  
  if(!is.null(invrsmtrx)) {
    message("getting cached data")
    return(invrsmtrx)
  }
  
  data <- x$get()
  
  invrsmtrx <- solve(data, ...)
  
  x$setinversematrix(invrsmtrx)
  
  invrsmtrx
}
