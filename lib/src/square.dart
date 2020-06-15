import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final String value;
  final Function onClick;
  Square({this.value, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onClick,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.blue,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Text(
            this.value.toString(),
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ),
    );
  }
}
