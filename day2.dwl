%dw 2.0
output json
var linesApart = payload splitBy('\n')
var colors = linesApart map (line, index) -> {
    game: line splitBy (";") map (subGame, index) -> {
        gameId: ((subGame splitBy (/[\:\,]/)) filter ($ contains "Game"))[0],
        blue: ((subGame splitBy (/[\:\,]/)) filter ($ contains "blue"))[0],
        green: ((subGame splitBy (/[\:\,]/)) filter ($ contains "green"))[0],
        red: ((subGame splitBy (/[\:\,]/)) filter ($ contains "red"))[0]
    }
}

fun possible(games) = games filter (($.blue contains "15") or ($.blue contains "16") or ($.blue contains "17") or ($.blue contains "18") or ($.blue contains "19") or ($.blue contains "20") or ($.red contains "13") or ($.red contains "14") or ($.red contains "15") or ($.red contains "16") or ($.red contains "17")or ($.red contains "18") or ($.red contains "19") or ($.red contains "20") or ($.green contains "14") or ($.green contains "15") or ($.green contains "16") or ($.green contains "17") or ($.green contains "18") or ($.green contains "19") or ($.green contains "20"))

var possibleGames = colors.game map (game) -> {
    possibleGames: if (isEmpty(possible(game))) (game.gameId[0] replace /[A-Z][a-z]+\s/ with "")
                    else "not"
}
---
(possibleGames filter (!($.possibleGames contains "not"))).possibleGames reduce ($$ + $)






