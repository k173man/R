<Query Kind="Statements" />

Func<string, string, int> computeLevenshteinDistance = (s1, s2) => {
    var n  = s1.Length + 1;
    var m  = s2.Length + 1;
    var d = new int[n, m];

    for (var i = 0; i < n; i++)
        d[i, 0] = i;

    for (var j = 0; j < m; j++)
        d[0, j] = j;

    for (var i = 1; i < n; i++) {
        for (var j = 1; j < m; j++) {
            var cost = s2[j - 1] == s1[i - 1] ? 0 : 1;

            d[i, j] = Math.Min(
				Math.Min(d[i - 1, j] + 1, d[i, j - 1] + 1), 
				d[i - 1, j - 1] + cost
			);
        }
    }

    return d[n - 1, m - 1];
};

Func<string, string, double> internalSimilarityScore = (s1, s2) => { 
    var dist = computeLevenshteinDistance(s1, s2);
    var maxLen = s1.Length > s2.Length ? s1.Length : s2.Length;
    
	if (maxLen == 0)
		return 1.0F;
    
	return 1.0F - Convert.ToDouble(dist) / Convert.ToDouble(maxLen);
};

Func<string, string> letterSimilarityString = (s1) => { 
    var result = new StringBuilder();
	var allChars = (s1 ?? "").ToUpper().ToCharArray();
    
	Array.Sort(allChars);
	    
    foreach (var ch in allChars) 
        if (Char.IsLetterOrDigit(ch))
            result.Append(ch);

    return result.ToString();
};

Func<string, string> wordSimilarityString = (s1) => { 
    var words = new List<string>();
	StringBuilder curWord = null;
	
	foreach (var ch in (s1 ?? "").ToUpper()) {
        if (Char.IsLetterOrDigit(ch)) {
            if (curWord == null)
                curWord = new StringBuilder();

            curWord.Append(ch);
		}
        else {
            if (curWord != null) {
                words.Add(curWord.ToString());
                curWord = null;
            }
        }
    }
	
    if (curWord != null) 
        words.Add(curWord.ToString());

    words.Sort(StringComparer.OrdinalIgnoreCase);
	
    return String.Join(" ", words.ToArray());
};

Func<string, string, double> similarityScore = (s1In, s2In) => { 
//	if (s1 == null || s2 == null) 
//		return null;

    var s1 = s1In.ToUpper().TrimEnd();
    var s2 = s2In.ToUpper().TrimEnd();
	
	// At this point, T-SQL would consider them the same, so I will too
    if (s1 == s2) 
		return 1.0F;

    var flatLevScore = internalSimilarityScore(s1, s2);

    var letterS2 = letterSimilarityString(s2);
    var letterS1 = letterSimilarityString(s1);
    var letterScore = internalSimilarityScore(letterS1, letterS2);

    // var wordS1 = wordSimilarityString(s1);
    // var wordS2 = wordSimilarityString(s2);
    // var wordScore = internalSimilarityScore(wordS1, wordS2);

    if (flatLevScore == 1.0F && letterScore == 1.0F)
		return 1.0F;
    if (flatLevScore == 0.0F && letterScore == 0.0F)
		return 0.0F;

	// return weighted score
    return (flatLevScore * 0.2F) + (letterScore * 0.8F);
};

var word1 = "THUNDERSTORM WIND";
var word2 = "THUNDERSTROM WIND";
//var word2 = "THUNDERTORM WINDS";
//var word2 = "THUNERSTORM WINDS";

var lDist = computeLevenshteinDistance(word1, word2);
lDist.Dump();

var iss = internalSimilarityScore(word1, word2);
iss.Dump();

var ss = similarityScore(word1, word2);
ss.Dump();
