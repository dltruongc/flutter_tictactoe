import 'package:flutter/material.dart';

import 'square.dart';

class Board extends StatelessWidget {
  final List<String> squares;
  final Function onClick;

  Board({
    Key key,
    @required this.squares,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(9, (int id) {
          return Square(
            value: squares[id],
            onClick: () => onClick(id),
          );
        }),
      ),
    );
  }
}
