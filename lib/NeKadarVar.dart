import 'package:flutter/material.dart';

import 'Sayac.dart';

class NeKadarVar extends StatelessWidget {
  NeKadarVar({@required this.hour,@required this.min,@required this.sec,this.textStyle});

  final int hour;
  final int min;
  final int sec;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Sayac(
          value: hour,
          label: "Saat",
          numberTextStyle: textStyle,
        ),
        Sayac(
          value: min,
          label: "Dakika",
          numberTextStyle: textStyle,
        ),
        Sayac(
          value: sec,
          label: "Saniye",
          numberTextStyle: textStyle,
        ),
      ],
    );
  }
}
