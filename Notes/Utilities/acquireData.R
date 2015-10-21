if (length(grep("package:tools", search(), fixed = T)) == 0)
  library(tools)

if (length(grep("package:R.utils", search(), fixed = T)) == 0)
  library(R.utils)

downloadDecompressArchive <- function(url, dataDirectoryName = "data", archiveFileName, overWrite = F) {
  # build file paths
  archiveFilePathAndName <- file.path(dataDirectoryName, archiveFileName)
  
  # create data directory
  if(!dir.exists(dataDirectoryName)) {
    dir.create(dataDirectoryName)
  }
  # download file
  if (overWrite || !file.exists(archiveFilePathAndName)) {
    # message("Downloading file")
    download.file(url, archiveFilePathAndName)
  }
  
  archiveExt <- file_ext(archiveFileName)
  # decompress archived file
  if (file.exists(archiveFilePathAndName)) {
    # message("Decompressing file")
    if(archiveExt == "zip")
      unzip(archiveFilePathAndName, exdir = dataDirectoryName, overwrite = overWrite)
    
    if(archiveExt %in% c("7z", "bz2", "gz", "xz"))
      decompressFile(filename = archiveFilePathAndName, ext = archiveExt, FUN = gzfile, overwrite = overWrite)
  }
  
  dataFiles <- list.files(dataDirectoryName, include.dirs = F)
  dataFiles[which(file_ext(dataFiles) != archiveExt)]
}
