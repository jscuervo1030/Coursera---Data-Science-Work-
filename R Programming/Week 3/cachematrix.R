## Programming Assignment 2 - R Programming
## Juan Sebastián Cuervo Sánchez - 

## First Function - Make Cache Matrix
## The First Function builds an object of type Matrix 
## and stores the cache of it 

makeCacheMatrix <- function(x = matrix())
{
## The function requires an object type matrix in order to execute  
  
  minversa <- NULL
  
## Create the object and assigns a Null value in order to use it 

set <- function(y) 
{
  x <<- y
    minversa <<- NULL
}

## Creates the object and the required retrieve functions. Returns a List with the objects 

get <- function() x
setinverse <- function(inverse) minversa <<- inverse
getinverse <- function() minversa
list(set = set, get = get,
     setinverse = setinverse,
     getinverse = getinverse)

}



## The funcion calls the function  in order to see if m contains any value.
## If the object is not null (!) the if conditional will only retrieve a message in the 
## Console and the value of the matrix inverse. Instead it will solve the matrix inverse with the
## stored data and return and show the result


cacheSolve <- function(x, ...) 
{

## Gets the value of the cache object    
  
  minversa <- x$getinverse()
  
##  If the object is already calculated , return the stored value
  
  if (!is.null(minversa))
  {
    message("Getting Cached Matrix Inverse. Please Wait ... ")
    return(minversa)
  }
  
  ## If not obtain the data and solve the inverse 
  ## Note : We assume the matrix is square as noted in the instructions vccccc
  
  data <- x$get()
  minversa <- solve(data)
  x$setinverse(minversa)
  minversa
  
  ## The function requires and assumes a square matrix so solve () function does not give error
  ## We assume 
  
  
 
}
