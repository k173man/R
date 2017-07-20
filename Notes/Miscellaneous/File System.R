setwd('Notes')

# removes all of the path up to and including the last path separator (if any), i.e. returns directory or file name
basename(R.home())

library(tools)
file_ext('Subsetting.R')
file_path_as_absolute('Subsetting.R')
file_path_sans_ext(list.files('data'), compression = FALSE)
list_files_with_exts('data', exts = c('data', 'txt'))

# returns the part of the path up to but excluding the last path separator, or "." if there is no path separator, i.e. returns parent directory name
dirname(R.home())

# Construct the path to a file from components in a platform-independent way
file.path('C:', 'Docs', fsep = .Platform$file.sep)

# expands path preceded by a ~
path.expand('~/')

# concatenates text & writes it to a file
cat('test1 - line 1\n', 'test1 - line 2\n', file = 'test1.txt')
cat('test2 - line 1\n', 'test2 - line 2\n', file = 'test2.txt')

# shows file contents in default app associated w/ file extension, or in R Studio if no associated app
file.show('test1.txt')
file.show('test2.txt')

# appends contents of file2 (2nd arg) to the contents of file1 (1st arg)
file.append(file1 = 'test1.txt', file2 = 'test2.txt')

# all of these file operations return a boolean value (indicating success/failure?)
# creates files if they don't exist, or truncates existing files
file.create('test1.txt', 'test2.txt')
file.exists('test1.txt', 'test2.txt')
file.rename('test2.txt', 'test3.txt')

# copy.mode: should file permission bits be copied where possible? default = T
# copy.date: should file dates be preserved where possible? default = F
# recursive - default = F
# overwrite - default = recursive, i.e.  default = F
file.copy(from = 'test3.txt', to = 'test2.txt', copy.mode = T, copy.date = T)

file.symlink(from = 'test1.txt', to = 'test1lnk.txt')
# file.link creates a hard link
# file.link(from = '', to = '')
# Sys.junction(from = '', to = '')

# delete symlink & files
file.remove('test1lnk.txt', 'test1.txt', 'test2.txt', 'test3.txt')

dir.create('tmp')
# unlink() w/ recursive is used to delete directories; also deletes files
unlink('tmp', recursive = T)

# returns R install directory path
R.home()
# returns path of specified sub-item (directory or file) contained in R install directory
R.home('docs')

# list directories & files in specified path
list.files(R.home())

# pattern arg is a RegEx, not necessarily an extension
# all.files arg: return hidden files (T); default F
# full.names arg: return full path (T), or object name; default F
# recursive: recurse into sub-directories (T); default F
# ignore.case: case-insensitive (T); default F
# include.dirs: include sub-directories (T) in recursive listing (they always are in non-recursive listings); default F
list.files(
    path = 'data', 
    pattern = '.csv', 
    all.files = T, 
    full.names = T, 
    recursive = T, 
    ignore.case = T, 
    include.dirs = T
)

# dir() is the same as list.files()
dir(path = R.home())

# full.names arg: return full path (T), or object name; default T
# recursive: recurse into sub-directories (T); default T
list.dirs(path = R.home(), recursive = F)
