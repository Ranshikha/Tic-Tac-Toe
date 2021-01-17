import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true; //the first player is zero
  List<String> displayExDh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  var myTextStyle = TextStyle(color: Colors.white, fontSize: 20);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  static var myNewFont = GoogleFonts.pressStart2P(
      textStyle: TextStyle(color: Colors.grey[100], letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Player O', style: myNewFont),
                        Text(ohScore.toString(), style: myNewFont),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Player X', style: myNewFont),
                        Text(exScore.toString(), style: myNewFont),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[700])),
                      child: Center(
                        child: Text(
                          displayExDh[index],
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'TIC TAC TOE',
                      style: myNewFontWhite,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      '@CREATEDBYAPPJUNKIES',
                      style: myNewFontWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExDh[index] == '') {
        displayExDh[index] = 'o';
        filledBoxes += 1;
      } else if (!ohTurn && displayExDh[index] == '') {
        displayExDh[index] = 'x';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayExDh[0] == displayExDh[1] &&
        displayExDh[0] == displayExDh[2] &&
        displayExDh[0] != '') {
      _showDialog(displayExDh[0]);
    }
    if (displayExDh[3] == displayExDh[4] &&
        displayExDh[3] == displayExDh[5] &&
        displayExDh[3] != '') {
      _showDialog(displayExDh[3]);
    }
    if (displayExDh[6] == displayExDh[7] &&
        displayExDh[6] == displayExDh[8] &&
        displayExDh[6] != '') {
      _showDialog(displayExDh[6]);
    }
    if (displayExDh[0] == displayExDh[3] &&
        displayExDh[0] == displayExDh[6] &&
        displayExDh[0] != '') {
      _showDialog(displayExDh[0]);
    }
    if (displayExDh[1] == displayExDh[4] &&
        displayExDh[1] == displayExDh[7] &&
        displayExDh[1] != '') {
      _showDialog(displayExDh[1]);
    }
    if (displayExDh[2] == displayExDh[5] &&
        displayExDh[2] == displayExDh[8] &&
        displayExDh[2] != '') {
      _showDialog(displayExDh[2]);
    }
    if (displayExDh[0] == displayExDh[4] &&
        displayExDh[0] == displayExDh[8] &&
        displayExDh[0] != '') {
      _showDialog(displayExDh[0]);
    }
    if (displayExDh[6] == displayExDh[4] &&
        displayExDh[6] == displayExDh[2] &&
        displayExDh[6] != '') {
      _showDialog(displayExDh[6]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('DRAW'),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  _checkScore();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner IS: ' + winner),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  _checkScore();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      exScore += 1;
    }
  }

  void _checkScore() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExDh[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
