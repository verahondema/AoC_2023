%dw 2.0
output json
import * from dw::core::Arrays
fun linesApart(allLines) = allLines splitBy('\n') map (line) -> {
    line: line
}
fun wordToNumber(word) = word match {
        case x if word contains "three" -> wordToNumber(word replace "three" with "t3e")
        case x if word contains "four" -> wordToNumber(word replace "four" with 4)
        case x if word contains "five" -> wordToNumber(word replace "five" with "5e")
        case x if word contains "six" -> wordToNumber(word replace "six" with 6)
        case x if word contains "seven" -> wordToNumber(word replace "seven" with 7)
        case x if word contains "nine" -> wordToNumber(word replace "nine" with "9e")
        case x if word contains "eight" -> wordToNumber(word replace "eight" with "e8t")
        case x if word contains "two" -> wordToNumber(word replace "two" with "t2o")
        case x if word contains "one" -> wordToNumber(word replace "one" with "o1e")
        else -> word
    }

fun completeSum(listOfNumbers) = sumBy(listOfNumbers, (item) -> item.sum)
fun removeLetters(words) = words replace /[a-z]/ with ""

---
{
firstPart: completeSum(linesApart(payload) map {
    sum: (removeLetters($.line))[0] ++ (removeLetters($.line))[-1]
}),
secondPart: completeSum(linesApart(payload) map {
    sum: (removeLetters((wordToNumber($.line)))[0] ++ (removeLetters((wordToNumber($.line))))[-1])
})
}


