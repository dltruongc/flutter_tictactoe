import 'dart:convert';

import 'package:flutter/material.dart';

import 'board.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool xIsNext;
  List<String> squaresValues;
  List<Map<String, List<String>>> history;
  int stepNumber;

  _GameState() {
    // this.history = List.filled(9, null) => history.last == history[8];
    // => false
    this.history = [
      {"squares": List.filled(9, null)}
    ];
    stepNumber = 0;
    this.squaresValues = List.filled(9, null);
    xIsNext = true;
  }

  handleClick(int id) {
    final history1 = this.history.sublist(0, this.stepNumber + 1);

    final current = history1.last;
    final squares = [...current['squares']];

    if (calculateWinner(squares) != null || squares[id] != null) {
      return;
    }

    squares[id] = xIsNext ? 'X' : 'O';
    this.history = [...history1];
    setState(() {
      this.history.add({"squares": squares});
      this.squaresValues = squares;
      // stepNumber == index of history
      this.stepNumber = history1.length - 1;
      this.xIsNext = !this.xIsNext;
    });
  }

  String calculateWinner(squares) {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (int i = 0; i < lines.length; i++) {
      final a = lines[i][0];
      final b = lines[i][1];
      final c = lines[i][2];
      if (squares[a] != null &&
          squares[a] == squares[b] &&
          squares[a] == squares[c]) {
        return squares[a];
      }
    }
    return null;
  }

  jumpTo(int step) {
    setState(() {
      this.stepNumber = step;
      this.xIsNext = (step % 2) == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final history1 = this.history; // reference
    final current = history1[this.stepNumber];

    final winner = calculateWinner(current["squares"]);

    final moves = history1.map<Widget>((item) {
      int move = history1.indexOf(item);
      String desc = 'Go to move #$move';
      if (move == 0) desc = 'Go to game start';
      return RaisedButton(
        onPressed: () => this.jumpTo(move),
        child: Text(desc),
      );
    }).toList();

    String status;
    if (winner != null) {
      status = 'Winner: ' + winner;
    } else {
      status = 'Next player: ' + (this.xIsNext ? 'X' : 'O');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tic tac toe'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Text(
            status,
            style: Theme.of(context).textTheme.display1,
          ),
          Board(
            onClick: this.handleClick,
            squares: current["squares"],
          ),
          SizedBox(
            width: 180,
            height: 80,
            child: ListView(children: moves),
          ),
        ],
      ),
    );
  }
}
