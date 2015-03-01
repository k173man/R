substr(x = "ShaneThomasReed", start = 6, stop = 11)
substr(x = "ShaneThomasReed", start = nchar("Shane") + 1, stop = nchar("ShaneThomas"))

nchar("Shane")

tolower("SHANE")

toupper("shane")

# Translates a list of characters (old) to the corresponding character in new.
chartr("ain", "ane", "Shain")

paste(c("Shane", "Thomas", "Reed"), sep = " ")
paste("Shane", "Thomas", "Reed", sep = " ")

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
