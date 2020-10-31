import 'package:flutter/material.dart';

class Sayac extends StatelessWidget {
  Sayac({this.value, this.label, this.numberTextStyle});

  final int value;
  final String label;
  final TextStyle numberTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            value == null || value < 0
                ? "00"
                : value.toString().padLeft(2, "0"),
            style: numberTextStyle,
          ),
          Text(label),
        ],
      ),
    );
  }
}
