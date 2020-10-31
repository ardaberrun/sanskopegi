import 'dart:core';

class DiffTimer {
  DateTime now ;
  DateTime end;
  int _diffHour;
  int _diffMin;
  int _diffSec;
  DiffTimer({this.now,this.end});

  int get diffSec{
   _diffSec = end.difference(now).inSeconds - (end.difference(now).inHours * 3600 + end.difference(now).inMinutes % 60 * 60);
    return _diffSec;
  }

  int get diffMin{
    _diffMin = end.difference(now).inMinutes % 60;
    return _diffMin;
  }


  int get diffHour{
    _diffHour = end.difference(now).inHours;
    return _diffHour;
  }

}