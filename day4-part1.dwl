%dw 2.0
output application/json
import isNumeric from dw::core::Strings
var splittedPayload = payload splitBy ("\n")
var numbersPlotted = splittedPayload map (card) -> {
    winningNumbers: ((((card splitBy "|")[0])) splitBy " ") filter (isNumeric($)),
    myNumbers: (((card splitBy "|")[1]) splitBy  " ") filter (isNumeric($))
}

fun compareNumbers(number, listOfWin) = if (listOfWin contains number) number
                                        else "lose"


---
sum((numbersPlotted map (myCard) -> {
    myCard: myCard.myNumbers map (myNumber) -> {
        number: (compareNumbers(myNumber, myCard.winningNumbers)) 
}
}) map (win) -> {
    points: (sizeOf(win.myCard filter (!($.number contains "lose")))) match {
        case 0 -> 0
        case 1 -> 1
        case 2 -> 2
        case 3 -> 4
        case 4 -> 8
        case 5 -> 16
        case 6 -> 32
        case 7 -> 64
        case 8 -> 128
        case 9 -> 256
        case 10 -> 512
        else -> ""
    } 
}.points)








