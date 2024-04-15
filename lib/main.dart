import 'package:flutter/material.dart';

void main() {
  runApp(XOGame());
}

class XOGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(
        appBar: AppBar(
          title: Text('X O Game'),
        ),
        body:

        XOGameBoard(),
      ),
    );
  }
}

class XOGameBoard extends StatefulWidget {

  @override
  _XOGameBoardState createState() => _XOGameBoardState();
}

class _XOGameBoardState extends State<XOGameBoard> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late bool _gameOver;

  List<String> _players = ['X', 'O'];
  late String _selectedPlayer;

  @override
  void initState() {
    super.initState();
    _selectedPlayer = _players.first;
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = _selectedPlayer;
    _gameOver = false;
  }

  void _makeMove(int row, int col) {
    if (!_gameOver && _board[row][col] == '') {
      setState(() {
        _board[row][col] = _currentPlayer;
        _checkForWinner(row, col);
        _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
      });
    }
  }

  void _checkForWinner(int row, int col) {
    // Check rows
    if (_board[row].every((element) => element == _currentPlayer)) {
      _endGame();
      return;
    }
    // Check columns
    if (_board.every((row) => row[col] == _currentPlayer)) {
      _endGame();
      return;
    }
    // Check diagonals
    if ((row == col &&
        _board[0][0] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][2] == _currentPlayer) ||
        (row + col == 2 &&
            _board[0][2] == _currentPlayer &&
            _board[1][1] == _currentPlayer &&
            _board[2][0] == _currentPlayer)) {
      _endGame();
      return;
    }
    // Check for draw
    if (!_board.any((row) => row.any((cell) => cell == ''))) {
      _endGame(draw: true);
    }
  }

  void _endGame({bool draw = false}) {
    setState(() {
      _gameOver = true;
      if (draw) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Game Over'),
            content: Text('you can try again'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetBoard();
                },
                child: Text('Play Again'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Game Over'),
            content: Text('Player ${_currentPlayer == 'X' ? 'O' : 'X'} wins!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetBoard();
                },
                child: Text('Play Again'),
              ),
            ],
          ),
        );
      }
    });
  }

  void _resetBoard() {
    setState(() {
      _initializeBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: _selectedPlayer,
            onChanged: (value) {
              setState(() {
                _selectedPlayer = value!;
                _currentPlayer = _selectedPlayer;
                _resetBoard();
              });
            },
            items: _players.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () => _makeMove(row, col),
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      // clipBehavior: Clip.hardEdge,
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple,
                        // gradient:SweepGradient(colors: [Color.fromARGB(255, 212, 72, 72),Color.fromARGB(255, 231, 210, 202),Colors.black])
                      ),
                      child: Center(
                        child: Text(
                            _board[row][col],
                            style: TextStyle(
                              fontSize: 48.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                              // decorationColor: Colors.blue,
                              decorationThickness: 20,
                              //  shadows: [Shadow(color: Color.fromARGB(255, 26, 202, 173)),Shadow(color:Color.fromARGB(255, 198, 228, 31)),Shadow(color:Color.fromARGB(255, 209, 52, 52))]),
                            )
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ]);
    // ),

    // );
  }
}
