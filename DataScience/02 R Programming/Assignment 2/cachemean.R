makeVector <- function(x = numeric()) {
  m <- NULL
  
  set <- function(y) {
    # if set() is called, then the original vector, parameter x, is being changed
    # as a result, the cached mean variable, m, needs to be set to NULL
    x <<- y
    m <<- NULL
  }
  
  get <- function() x
  
  setmean <- function(mean) m <<- mean
  
  getmean <- function() m
  
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}
cachemean <- function(x, ...) {
  m <- x$getmean()
  
  # cached mean exist
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  
  # cached mean wasn't found; get x, the x parameter passed into makeVector
  data <- x$get()
  
  # get the mean of x
  m <- mean(data, ...)
  
  # cache mean of x
  x$setmean(m)
  
  # return mean of x
  m
}