# Example from the book R High Performance Programming (chap 8, Implementing data parallel algorithms section)
# The parallel package that comes with R provides the foundation for most parallel computing capabilities in other packages

# This example involves finding documents that match a regular expression
# The corpus, or set of documents, for this example is a sample of the Reuters-21578 dataset for the topic corporate acquisitions (acq) from the tm package
# Because this dataset contains only 50 documents, they are replicated 100,000 times to form a corpus of 5 million documents
# install.packages("tm")
library(tm)
data("acq")

textdata <- rep(sapply(content(acq), content), 1e5)

# The task is to find documents that match the regular expression \d+(,\d+)? mln dlrs, which represents monetary amounts in millions of dollars
    # \d+ matches a string of one or more digits, and (,\d+)? optionally matches a comma followed by one more digits
        # For example, the strings 12 mln dlrs, 1,234 mln dlrs and 123,456,789 mln dlrs will match the regular expression

pattern <- "\\d+(,\\d+)? mln dlrs"
# First, we will measure the execution time to find these documents serially with grepl():
# system.time(res1 <- grepl(pattern, textdata))

# Next, we will modify the code to run in parallel and measure the execution time on a computer with four CPU cores:
library(parallel)

# detectCores() function reveals how many CPU cores are available on the machine
detectCores()

# Before running any parallel code, makeCluster() is called to create a local cluster of processing nodes with all four CPU cores
# The corpus is then split into four partitions using the clusterSplit() function to determine the ideal split of the corpus, i.e. documents are distributed equally b/t partitions
cl <- makeCluster(detectCores())
part <- clusterSplit(cl, seq_along(textdata))
text.partitioned <- lapply(part, function(p) textdata[p])

# The actual parallel execution of grepl() on each partition of the corpus is carried out by the parSapply() function
system.time(res2 <- unlist(
    parSapply(cl, text.partitioned, grepl, pattern = pattern)
)) 

# Finally, the cluster is destroyed by calling stopCluster()
stopCluster(cl)

# It is good practice to ensure that stopCluster() is always called in production code, even if an error occurs during execution. This can be done as follows:
# doSomethingInParallel <- function(...) {
#     cl <- makeCluster(...)
#     on.exit(stopCluster(cl))
#     # do something
# }

# parallel provides the parSapply(), parApply() and parLapply() functions; these functions are analogous to the sapply(), apply(), and lapply() functions, respectively
# parallel also provides parRapply() and parCapply(), which provide parallel row and column apply() functions for matrices
