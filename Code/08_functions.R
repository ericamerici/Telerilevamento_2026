# My functions!

somma <- function(x,y){
  z=x+y
  return(z)
  }

# Excercise: make the function called difference

differenzaselvaggia <- function(x,y){
  z=x-y
  return(z)
  }

# Data from ImageRy
88888896
# par(mfrow...)
mf <- function(nx,ny) {
  par(mfrow=c(nx, ny))
  }

# par(mfrow...) with default
mf <- function(nx=1,ny=2) {
  par(mfrow=c(nx, ny))
  }


plot(sent[[1]])
plot(sent[[2]])
mf(1,2)

# if else
numeri <- function(x){
  if(x>0){
    print("Questo numero è positivo, noo?")
    }
  else if(x<0){
    print("Questo numero è negativo, se non lo sai torna a scuola")
    }
  else {
    print("Zero non è né negativo né positivo")
    }
  }

# Cicli for
loop <- function() {
  for (i in 1:10) {
    print(i)
    }
  }

loop2 <- function() {
for (i in 1:10) {
  op <- i * 2
  print(op)
  }
}
