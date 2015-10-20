library(tools)

acquireData <- function(url, dataDirectoryName = "data", archiveFileName = NULL, fileName, overWriteFiles = F) {
  # build file paths
  filePathAndName <- file.path(dataDirectoryName, fileName)
  archiveFilePathAndName <- NULL
  
  if(!is.null(archiveFileName)) {
    archiveFilePathAndName <- file.path(dataDirectoryName, archiveFileName)
  }
  
  downloadFilePathAndName <- ifelse(is.null(archiveFilePathAndName), filePathAndName, archiveFilePathAndName)
  
  # message(paste("File Path: ", filePathAndName))
  # message(paste("Archive Path: ", archiveFilePathAndName))
  # message(paste("Download Path: ", downloadFilePathAndName))
  
  # create data directory
  if(!dir.exists(dataDirectoryName)) {
    dir.create(dataDirectoryName)
  }
  # download file
  if (overWriteFiles || !file.exists(downloadFilePathAndName)) {
    # message("Downloading file")
    download.file(url, downloadFilePathAndName)
  }
  
  archiveExt <- file_ext(archiveFileName)
  # decompress archived file
  if (overWriteFiles || (!is.null(archiveFileName) && file.exists(archiveFilePathAndName) && !file.exists(filePathAndName))) {
    # message("Decompressing file")
    if(archiveExt == "zip")
      unzip(archiveFilePathAndName, exdir = dataDirectoryName, overwrite = overWriteFiles)
    
#     if(archiveExt %in% c("7z", "bz2", "gz", "xz"))
#       gzfile()
  }
  
  dataFiles <- list.files(dataDirectoryName)
  dataFiles[which(file_ext(dataFiles) != archiveExt)]
}
