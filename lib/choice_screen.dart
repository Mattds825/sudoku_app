import 'package:flutter/material.dart';
import 'package:sudoku_app/home_screen.dart';

class ChoiceScreen extends StatefulWidget {
  ChoiceScreen({Key key}) : super(key: key);

  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChoiceCard(
                text: 'Easy',
                color: Colors.green,
                onTap: () {
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => HomeScreen(0)));
                },
              ),
              ChoiceCard(
                text: 'Medium',
                color: Colors.amber,
                onTap: () {
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => HomeScreen(1)));
                },
              ),
              ChoiceCard(
                text: 'Hard',
                color: Colors.red,
                onTap: () {
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => HomeScreen(2)));
                },
              ),
              ChoiceCard(
                text: 'resume game',
                color: Colors.blue,
                onTap: () {
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => HomeScreen(1)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;

  ChoiceCard({Key key, this.text, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          color: color,
          child: Container(
            width: double.infinity,
            height: 50.0,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      onTap: onTap
    );
  }
}
