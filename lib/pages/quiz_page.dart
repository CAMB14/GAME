import 'package:flutter/material.dart';

import 'dart:math';
import 'package:english_words/english_words.dart';
import './correct_wrong.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  bool overlayshow = false;
  bool answeroverlay = false;
  String _theState = "0";
  int _actualWordType = 0;
  int scoretot = 0;
  final _random = new Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void setRandomWord() {
    var option = next(0, 2);
    var randomItem = "";
    if (option == 0) {
      print("change to noun");
      randomItem = (nouns.toList()..shuffle()).first;
    } else {
      print("change to adjective");
      randomItem = (adjectives.toList()..shuffle()).first;
    }

    setState(() {
      _theState = randomItem;
      _actualWordType = option;
    });
  }

  void _onPressed(int option) {
    if (option == _actualWordType) {
      print("good");
      scoretot = scoretot + 2;
      answeroverlay = true;
      overlayshow = true;
    } else {
      print("not good");
      if (scoretot != 0) {
        scoretot = scoretot - 1;
      }
      answeroverlay = false;
      overlayshow = true;
    }
    setRandomWord();
  }

  void _onReset() {}

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Material(
                color: Colors.white,
                child: new Padding(
                  padding: new EdgeInsets.symmetric(vertical: 20.0),
                  child: new Center(
                    child: new Text("SCORE: " + scoretot.toString()),
                  ),
                )),
            new Expanded(
              child: new Material(
                color: Colors.orange[100],
                child: new InkWell(
                  onTap: () => _onPressed(1),
                  child: new Center(
                      child: new Container(
                    decoration: new BoxDecoration(
                        border:
                            new Border.all(color: Colors.white, width: 5.0)),
                    padding: new EdgeInsets.all(20.0),
                    child: new Text("Adjective",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                  )),
                ),
              ),
            ),
            new Material(
                color: Colors.white,
                child: new Padding(
                  padding: new EdgeInsets.symmetric(vertical: 20.0),
                  child: new Center(
                    child: new Text("$_theState".toUpperCase()),
                  ),
                )),
            new Expanded(
              child: new Material(
                color: Colors.red[100],
                child: new InkWell(
                  onTap: () => _onPressed(0),
                  child: new Center(
                      child: new Container(
                    decoration: new BoxDecoration(
                        border:
                            new Border.all(color: Colors.white, width: 5.0)),
                    padding: new EdgeInsets.all(20.0),
                    child: new Text("Noun",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                  )),
                ),
              ),
            ),
            new Material(
                child: new InkWell(
                    onTap: () => scoretot = 0,
                    child: new Padding(
                      padding: new EdgeInsets.symmetric(vertical: 20.0),
                      child: new Center(
                        child: new Text(" RESET "),
                      ),
                    )))
          ],
        ),
        overlayshow == true
            ? new CorrectWrongOverlay(answeroverlay, () {
                this.setState(() {
                  overlayshow = false;
                });
              })
            : new Container()
      ],
    );
  }
}
