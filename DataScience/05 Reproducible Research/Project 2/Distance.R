library(stringr)
library(stringdist)

stringDistance <- function(distMethod) {
    isLetterOrDigit <- function (s) (s %in% LETTERS || s %in% 0:9)
    
    # Inputs: string 1 & string 2; Output: Int
    getLetterSimilarityString <- function (s1) {
        allChars <- ifelse(is.null(s1), "", s1)
        allChars <- sort(substring(allChars, 1:nchar(allChars), 1:nchar(allChars)))
        result <- ""
        
        for (ch in allChars) {
            if(isLetterOrDigit(ch))
                result <- paste0(result, ch)
        }
        
        result
    }
    
    getWordSimilarityString <- function (s1) {
        words <- vector("character")
        curWord <- NULL
        allChars <- ifelse(is.null(s1), "", s1)
        allChars <- substring(allChars, 1:nchar(allChars), 1:nchar(allChars))    
        
        for (ch in allChars) {
            if (isLetterOrDigit(ch)) {
                curWord <- paste0(curWord, ch)
            } else {
                if (!is.null(curWord)) {
                    words <- c(words, curWord)
                    curWord <- NULL
                }
            }
        }
        
        if (!is.null(curWord))
            words <- c(words, curWord)
        
        words <- sort(words)
        
        paste(words, collapse = " ")
    }
    
    # Inputs: string 1 & string 2; Output: Double
    internalGetSimilarityScore <- function(s1, s2) {
        ncharS1 <- nchar(s1)
        ncharS2 <- nchar(s2)
        
        # adist implements Levenshtein distance
        # dist <- adist(s1, s2)
        
        # partial list of method options for stringdist
            # osa - default; Optimal String Aligment (restricted Damerau-Levenshtein distance)
            # lv - Levenshtein distance (as in R's native adist)
            # dl - Full Damerau-Levenshtein distance
        dist <- stringdist(s1, s2, method = distMethod)
        
        maxLen <- ifelse(ncharS1 > ncharS2, ncharS1, ncharS2)
        
        if (maxLen == 0)
            return (1)
        
        1 - dist/maxLen
    }
    
    # Inputs: string 1 & string 2; Output: Double
    getSimilarityScore <- function (string1, string2) {
        s1 <- str_to_upper(str_trim(string1))
        s2 <- str_to_upper(str_trim(string2))
        
        if (s1 == s2)
            return(1.0)
    
        flatLevScore  <- internalGetSimilarityScore(s1, s2)
        letterS1 <- getLetterSimilarityString(s1)
        letterS2 <- getLetterSimilarityString(s2)
        letterScore <- internalGetSimilarityScore(letterS1, letterS2)
    
        # wordS1 <- getWordSimilarityString(s1)
        # wordS2 <- getWordSimilarityString(s2)
        # wordScore <- internalGetSimilarityScore(wordS1, wordS2)
    
        if (flatLevScore == 1 && letterScore == 1)
            return(1)
        if (flatLevScore == 0 && letterScore == 0)
            return(0)
    
        (flatLevScore * 0.2) + (letterScore * 0.8)
    }
    
    list(getSimilarityScore = getSimilarityScore)
}

