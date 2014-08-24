I've included a command file and output from the command to demonstrate
my code in action. I had some problems defining the behavior for
'matrix has changed after inverse was cached' and included an extra
function, a safeCacheSolve, to handle that use case.

commands.Rhistory  : file of commands to test my functions
To demonstrate that I have an inverse, in cases where inspection
won't do anything useful, I use matrix multiplication, %*%, to 
demonstrate that a matrix multiplied by its inverse gives something
that looks awfully like an identity matrix (of the appropriate dimensions)
For the 100x100 case, I look at sums of rows and columns.

commands.output    : output of these commands
