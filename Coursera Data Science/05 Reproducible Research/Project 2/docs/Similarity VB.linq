<Query Kind="VBProgram">
  <Connection>
    <ID>c67ee20a-473b-4a6b-8265-ae1f09d2b1b3</ID>
    <Server>WCDRE0E3.CDR-P01.CHP.BANKOFAMERICA.COM,15001</Server>
    <Database>MARS</Database>
    <DisplayName>MARS</DisplayName>
  </Connection>
</Query>

Sub Main
    Dim word1 = "FLOOD/FLASH FLOOD"
    Dim word2 = "FLOOD/FLASH/FLOOD"
'    Dim dist = ComputeLevenstheinDistance(word1, word2)
    Dim similarityScore = GetSimilarityScore(word1, word2)

    similarityScore.Dump()
End Sub

Function ComputeLevenshteinDistance(ByVal string1 As String, ByVal string2 As String) As Integer
    Dim s1 As String = string1
    Dim s2 As String = string2

    Dim n As Integer = s1.Length
    Dim m As Integer = s2.Length
    Dim d As Integer(,) = New Integer(n, m) {}

    If n = 0 Then Return m
    If m = 0 Then Return n

    For i As Integer = 0 To n
        d(i, 0) = i
    Next

    For j As Integer = 0 To m
        d(0, j) = j
    Next

    For j As Integer = 1 To m

    For i As Integer = 1 To n
			Dim cost As Integer = If((s2(j - 1) = s1(i - 1)), 0, 1)

            d(i, j) = Math.Min(Math.Min(d(i - 1, j) + 1, d(i, j - 1) + 1), d(i - 1, j - 1) + cost)
        Next
    Next

    Return d(n, m)
End Function

Function GetSimilarityScore(string1 As String, string2 As String) As Double
    Dim s1 As String = string1.ToUpper().TrimEnd(" "c)
    Dim s2 As String = string2.ToUpper().TrimEnd(" "c)
    If s1 = s2 Then Return 1.0F ' At this point, T-SQL would consider them the same, so I will too

    Dim flatLevScore As Double = InternalGetSimilarityScore(s1, s2)

    Dim letterS1 As String = GetLetterSimilarityString(s1)
    Dim letterS2 As String = GetLetterSimilarityString(s2)
    Dim letterScore As Double = InternalGetSimilarityScore(letterS1, letterS2)

    'Dim wordS1 As String = GetWordSimilarityString(s1)
    'Dim wordS2 As String = GetWordSimilarityString(s2)
    'Dim wordScore As Double = InternalGetSimilarityScore(wordS1, wordS2)

    If flatLevScore = 1.0F AndAlso letterScore = 1.0F Then Return 1.0F
    If flatLevScore = 0.0F AndAlso letterScore = 0.0F Then Return 0.0F

    ' Return weighted result
    Return (flatLevScore * 0.2F) + (letterScore * 0.8F)
End Function

Function InternalGetSimilarityScore(s1 As String, s2 As String) As Double
    Dim dist As Integer = ComputeLevenshteinDistance(s1, s2)
    Dim maxLen As Integer = If(s1.Length > s2.Length, s1.Length, s2.Length)
    If maxLen = 0 Then Return 1.0F
    Return 1.0F - Convert.ToDouble(dist) / Convert.ToDouble(maxLen)
End Function

Function GetLetterSimilarityString(s1 As String) As String
    Dim allChars = If(s1, "").ToUpper().ToCharArray()
    Array.Sort(allChars)
    Dim result As New StringBuilder()
    
    For Each ch As Char In allChars
        If Char.IsLetterOrDigit(ch) Then
            result.Append(ch)
        End If
    Next
    
    Return result.ToString()
End Function

Function GetWordSimilarityString(s1 As String) As String
    Dim words As New List(Of String)()
    Dim curWord As StringBuilder = Nothing
    
    For Each ch As Char In If(s1, "").ToUpper()
        If Char.IsLetterOrDigit(ch) Then
            If curWord Is Nothing Then
                curWord = New StringBuilder()
            End If
            curWord.Append(ch)
        Else
            If curWord IsNot Nothing Then
                words.Add(curWord.ToString())
                curWord = Nothing
            End If
        End If
    Next
    
    If curWord IsNot Nothing Then
        words.Add(curWord.ToString())
    End If

    words.Sort(StringComparer.OrdinalIgnoreCase)
    
    Return String.Join(" ", words.ToArray())
End Function