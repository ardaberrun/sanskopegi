import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NeKadarVar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

const kNumberTextStyle = TextStyle(fontSize: 55, fontWeight: FontWeight.bold);

class SansKopegim extends StatefulWidget {
  @override
  _SansKopegimState createState() => _SansKopegimState();
}

class _SansKopegimState extends State<SansKopegim> {
  Timer _timer;
  int _hour;
  int _min;
  int _sec;
  int _day;
  DateTime _now;
  DateTime _end;
  String _random;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDay().then((_) {
      print("$_day");
      if (DateTime.now().day != _day) {
        setRandomValue();
      }
      getRandomValue();
      startTimer();
    });
  }

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now();
        _end = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day + 1,
          0,
          0,
          0,
        );
        _hour = _end.difference(_now).inHours;
        _min = _end.difference(_now).inMinutes % 60;
        _sec = _end.difference(_now).inSeconds -
            (_end.difference(_now).inHours * 3600 +
                _end.difference(_now).inMinutes % 60 * 60);
        if (DateTime.now().day != _day) {
          setDay();
          setRandomValue();
        }
      });
    });
  }

  Future<void> getRandomValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getRandom");
    if (prefs.getString("random") == null) {
      setRandomValue();
    } else {
      _random = prefs.getString("random");
    }
  }

  Future<void> setRandomValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("setRandom");
    _random = (Random().nextDouble() * 99 + 1).toStringAsFixed(2);
    prefs.setString("random", _random);
  }

  Future<void> setDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _day = DateTime.now().day;
    prefs.setInt("day", _day);
  }

  Future<void> getDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("day") == null) {
      setDay();
    } else {
      _day = prefs.getInt("day");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  headerAnimationLoop: false,
                  dialogType: DialogType.INFO,
                  body: Text(
                    "Hergün 00:00'da şans köpeğinden günlük şansını isteyebilirsin.\n\nUnutma şans köpeğinin sana vereceği şans, gün boyu yanında olacak!",
                    style: TextStyle(fontStyle: FontStyle.italic,),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(5.0),
                  btnOkOnPress: () {},
                )..show();
              },
              child: Icon(
                Icons.info_outline,
                size: 40.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: NeKadarVar(
            hour: _hour,
            sec: _sec,
            min: _min,
            textStyle: kNumberTextStyle,
          ),
        ),
        Expanded(
          flex: 4,
          child: Image.asset("images/dog.png"),
        ),
        Expanded(
          child: Text("Bugün sana verdiğim şans ",style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0,color: Colors.white,),),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Visibility(
              visible: _random == null ? false : true,
              child: Text(
                "%$_random",
                style: kNumberTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
