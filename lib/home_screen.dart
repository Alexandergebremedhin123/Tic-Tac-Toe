//import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';
import 'dart:ui' as ui;
import 'alert_dialog.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _scoreX = 0;
  int _scoreO = 0;
  bool _turnOfO = true;
  int _filledBoxes = 0;
  final List<String> _xOrOList = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body:Image(
        image: AssetImage("assets/images/alexflut2.jpeg"),

      ),*/
      body: Column(

          children: [

            _buildPointsTable(),
            _buildGrid(),
            _buildTurn(),

            // _buildImage(),
          ]

      ),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _clearBoard();
            },
          )
        ],
        centerTitle: true,
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontSize: 30.0, /*color: Colors.green,*/fontFamily:'Raleway',fontWeight: FontWeight.w800,
            foreground: Paint()
              ..style=PaintingStyle.stroke
              ..strokeWidth=3.5
              ..color=Colors.pink,

          ),

        ),
      ),
       backgroundColor: Colors.red,


    );

  }

  Widget _buildPointsTable() {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                children: [

                  Text(
                    'Player O',
                    style: kCustomText(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800, ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _scoreO.toString(),
                    style: kCustomText(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Player X',
                    style: kCustomText(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _scoreX.toString(),
                    style: kCustomText(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Expanded(
      flex: 3,
      child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _tapped(index);
              },
              child: Container(
                decoration:
                BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: new BorderRadius.circular(30.0),
                  color: Colors.lightGreen,
                ),
                child: Center(
                  child: Text(
                    _xOrOList[index],
                    style: TextStyle(
                      color:
                      _xOrOList[index] == 'x' ? Colors.indigo : Colors.red,
                      fontSize: 80,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildTurn() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _turnOfO ? 'Turn of O' : 'Turn of X',
            style: kCustomText(color: Colors.black),
          ),
        ),
      ),
    );
  }


  bool win=false;
  void _tapped(int index) {

    setState(() {

      if (_turnOfO && _xOrOList[index] == '') {
        _xOrOList[index] = 'o';
        _filledBoxes += 1;
        _turnOfO = !_turnOfO;
      }



      gameAI();
      _checkTheWinner();
      if(win=true)
        _turnOfO=true;


    });
  }


  void gameAI(){

    var _RandomNumber1 = Random().nextInt(9);

    if (!_turnOfO && _xOrOList[_RandomNumber1] == '') {
      _xOrOList[_RandomNumber1] = 'x';
      _filledBoxes += 1;
    }
    else if (_xOrOList[_RandomNumber1] != '') {
      while (_xOrOList[_RandomNumber1] != '') {
        _RandomNumber1 = Random().nextInt(9);
      }
      _xOrOList[_RandomNumber1] = 'x';
      _filledBoxes += 1;
    }

  }

  void _checkTheWinner() {
    // check first row
    if (_xOrOList[0] == _xOrOList[1] &&
        _xOrOList[0] == _xOrOList[2] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      win=true;
      return;
    }

    // check second row
    if (_xOrOList[3] == _xOrOList[4] &&
        _xOrOList[3] == _xOrOList[5] &&
        _xOrOList[3] != '') {
      _showAlertDialog('Winner', _xOrOList[3]);
      win=true;
      return;
    }

    // check third row
    if (_xOrOList[6] == _xOrOList[7] &&
        _xOrOList[6] == _xOrOList[8] &&
        _xOrOList[6] != '') {
      _showAlertDialog('Winner', _xOrOList[6]);
      win=true;
      return;
    }

    // check first column
    if (_xOrOList[0] == _xOrOList[3] &&
        _xOrOList[0] == _xOrOList[6] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      win=true;
      return;
    }

    // check second column
    if (_xOrOList[1] == _xOrOList[4] &&
        _xOrOList[1] == _xOrOList[7] &&
        _xOrOList[1] != '') {
      _showAlertDialog('Winner', _xOrOList[1]);
      win=true;
      return;
    }

    // check third column
    if (_xOrOList[2] == _xOrOList[5] &&
        _xOrOList[2] == _xOrOList[8] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      win=true;
      return;
    }

    // check diagonal
    if (_xOrOList[0] == _xOrOList[4] &&
        _xOrOList[0] == _xOrOList[8] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      win=true;
      return;
    }

    // check diagonal
    if (_xOrOList[2] == _xOrOList[4] &&
        _xOrOList[2] == _xOrOList[6] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      win=true;
      return;
    }

    if (_filledBoxes == 9) {
      _showAlertDialog('Draw', '');
    }
  }

  void _showAlertDialog(String title, String winner) {
    showAlertDialog(
        context: context,
        title: title,
        content: winner == ''
            ? 'The match ended in a draw'
            : 'The winner is ${winner.toUpperCase()}',
        defaultActionText: 'OK',
        onOkPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
        });

    if (winner == 'o') {
      _scoreO += 1;
    } else if (winner == 'x') {
      _scoreX += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _xOrOList[i] = '';
      }
    });

    _filledBoxes = 0;
  }
}
