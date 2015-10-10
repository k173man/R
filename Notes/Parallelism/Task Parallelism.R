require(parallel)

dirs = list.dirs("C:/Docs", recursive = F)

processDir = function(dirNm, outputPath) {
    subDirs = list.dirs(dirNm)    
    cat(subDirs, file = outputPath, sep = "\n")
}

# this will create 1 worker for each core; may want to use some fraction of all cores
cores <- detectCores()/2
cl <- makeCluster(cores)

# without this statement, the parallel code cannot find processDir()
clusterExport(cl, list("processDir"))

# multiple task are represented by a list of lists
    ## each individual task is a list with 2 elements
        ### #1 is a string containing the name of the function that will be called
        ### #2 is a list in which each element is a named arg for the function in #1

# this creates 3 tasks, one for each of the 1st 3 elements in dirs
calls <- list(
    dir1 = list("processDir", list(dirNm = dirs[[1]], outputPath = paste0(basename(dirs[[1]]), ".txt"))), 
    dir2 = list("processDir", list(dirNm = dirs[[2]], outputPath = paste0(basename(dirs[[2]]), ".txt"))), 
    dir3 = list("processDir", list(dirNm = dirs[[3]], outputPath = paste0(basename(dirs[[3]]), ".txt")))
)

parLapply(
    cl, 
    calls, 
    function(call) {
        do.call(call[[1]], call[[2]])
    }
)

stopCluster(cl)
