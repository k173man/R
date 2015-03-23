require(stringr)
# returns start & end index
str_locate("Shane Reed", "Reed")
# global version
str_locate_all("Shane Reed Reed", "Reed")
str_replace("Shane Reed", "R", "W")
str_replace_all("Shane Reed Reed", "R", "W")
# extract specified pattern
shopping_list <- c("apples x4", "flour", "sugar", "milk x2")
str_extract(shopping_list, "\\d")
# returns boolean indicating if a match is found
fruit <- c("apple", "banana", "pear", "pinapple")
str_detect(fruit, "a")


# use nchar(), not length(), to get the length of a string
nchar("Shane")

# create a vector of characters from a string
STR = "Shane Thomas Reed"
# using substring(...), not substr(...), does the following: substring(..., 1, 1), substring(..., 2, 2) substring(..., n, n)
vSTR = substring(STR, 1:nchar(STR), 1:nchar(STR))

rep(paste0("V", 1:3))

substr(x = "ShaneThomasReed", start = 6, stop = 11)
substr(x = "ShaneThomasReed", start = nchar("Shane") + 1, stop = nchar("ShaneThomas"))

nchar("Shane")

tolower("SHANE")

toupper("shane")

# Proper Case
words <- c('woRd Word', 'Word', 'word words')
# Regular Expressions
# (?<=\\b)([a-z]) says look for a lowercase letter preceded by a word boundary (e.g., a space or beginning of a line)
    ## (?<=...) is called a "look-behind" assertion
    ## \\U\\1 says replace that character with it's uppercase version
        ### \\1 is a back reference to the first group surrounded by () in the pattern
gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(words), perl=TRUE)


# Translates a list of characters (old) to the corresponding character in new.
chartr("ain", "ane", "Shain")

paste(c("Shane", "Thomas", "Reed"), sep = " ")
paste("Shane", "Thomas", "Reed", sep = " ")

# sprintf() - string print format
    ## place holders - string: %s, digit: %d, floating point: %f, floating point using scientific notation: %e
    ## in code below, %02d indicates a digit (%d), w/ a width of 2 & padded with 0
sprintf("%s: %02d", "A number formatted with a width of 2 & padded with 0", 1)
# formatC(...) is bases on C-style formatting; code below produces same results as sprintf("%02d", 1)
formatC(1, flag=0, width=2)
# more formatC(...): digits indicates # of significant digits
formatC(1000000.3892, digits = 3, big.mark = ",", format = "f")
# format(...) format an R object for pretty printing (not just numbers)
format(c(6, 1000000.3892), nsmall = 3, big.mark = ",", scientific = F, drop0trailing = T, trim = T)


# fixed indicates if delimiter is a constant or regex (default)
strsplit("Shane Reed", split = " ", fixed = TRUE)

# value = T, then the matching values are return; otherwise, the indexes of the matches are returned (default)
# fixed indicates if delimiter is a constant or regex
# invert = T, then non-matches are returned
# returns "Thomas"
grep(pattern = "Thomas", c("Shane", "Thomas", "Reed"), value = T, fixed = T, invert = F)
# returns "Shane" "Reed
grep(pattern = "Thomas", c("Shane", "Thomas", "Reed"), value = T, fixed = T, invert = T)
# returns 2
grep(pattern = "Thomas", c("Shane", "Thomas", "Reed"), value = F, fixed = T, invert = F)
# returns "Shane Thomas Reed"
grep(pattern = "Thomas", "Shane Thomas Reed", value = T, fixed = T, invert = F)
# returns 1
grep(pattern = "Thomas", "Shane Thomas Reed", value = F, fixed = T, invert = F)

# same as grep(), except it returns a logical vector of the same length as the character vector provided as an argument
# returns F T F
grepl(pattern = "Thomas", c("Shane", "Thomas", "Reed"), fixed = T)

# similar manner to grep(), but then substitutes the first instance of a match with a specified string
sub(pattern = "Thomas", replacement = "Bobo", c("Shane", "Thomas", "Reed"), fixed = T)

# replaces all matches to pattern, not just the 1st match; i.e. a global replacement
gsub(pattern = "Thomas", replacement = "Bobo", c("Shane", "Thomas", "Reed", "Thomas"), fixed = T)

# reports the character position in the provided string(s) where the start of the match with pattern occurs
# also returns the length of the match
regexpr("e", c("Shane", "Thomas", "Reed"), fixed = T)

# this is the closest thing to indexOf in C#; MUST TAKE 1ST ELEMENT 
regexpr("Thomas", "Shane Thomas Reed", fixed = T)[1]

# global version of regexpr
gregexpr("e", c("Shane", "Thomas", "Reed"), fixed = T)

# retrieve the matching components of a string vector for a provided match object (produced by regxpr() or gregexpr()).
l <- c("apple", "grape", "banana")
r <- regexpr(pattern = "a", l)
regmatches (x = l, m = r)

# assign() & get ()
# assign(...) below is the same as x <- c(1, 2, 3)
assign("x", c(1, 2, 3))

# display results of assign(...)
x

# gets the value of the provided variable
get("x")
# creates 3 variables: x1, x2, x3; then assigns values: 1*3, 2*3, 3*3, respectively
for(i in 1:3)
    assign(paste("x", i, sep = ""), i*3)

# display results of for(...)
x1; x2; x3

for(i in 1:3) {
	cur = get(paste("x", i, sep = ""))
    print(cur)
}


