import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui/theme/colors.dart';
import 'package:tic_tac_toe/utils/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastvalue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
  Game game = Game();

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
    (game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "TIC TAC TOE GAME",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 50,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "It's $lastvalue turn".toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 40),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlength ~/ 3,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(Game.boardlength, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          if (game.board![index] == "") {
                            setState(() {
                              game.board![index] = lastvalue;
                              turn++;
                              gameOver = game.winnerCheck(
                                  lastvalue, index, scoreBoard);
                              if (gameOver) {
                                result = "$lastvalue is the Winner";
                              } else if (!gameOver && turn == 9) {
                                result = "It's a DRAW!";
                                gameOver = true;
                              } else {
                                lastvalue = lastvalue == "X" ? "O" : "X";
                              }
                            });
                          }
                        },
                  child: Container(
                      width: Game.blocSize.toDouble(),
                      height: Game.blocSize.toDouble(),
                      decoration: BoxDecoration(
                          color: MainColor.secondaryColor,
                          border: Border.all(color: MainColor.primaryColor),
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                              color: game.board![index] == "X"
                                  ? Colors.blue
                                  : Colors.pink,
                              fontSize: 64),
                        ),
                      )),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            result,
            style: const TextStyle(color: Colors.white, fontSize: 54),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastvalue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            icon: const Icon(
              Icons.replay,
              size: 60,
            ),
            label: const Text("Repeat The Game"),
          )
        ],
      ),
    );
  }
}
