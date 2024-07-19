class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static const boardlength = 9;
  static const blocSize = 100;
  static const gridSize = 3;

  List<String>? board;

  static List<String>? initGameBoard() =>
      List.generate(boardlength, (index) => Player.empty);

  bool winnerCheck(String player, int index, List<int> scoreboard) {
    int row = index ~/ gridSize;
    int col = index % gridSize;
    int score = player == Player.x ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;

    if (row == col) scoreboard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreboard[2 * gridSize + 1] += score;

    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }

    return false;
  }
}
