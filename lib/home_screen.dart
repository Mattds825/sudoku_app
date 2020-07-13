import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:sudoku_app/num_tile.dart';

class HomeScreen extends StatefulWidget {
  int wrongMoves = 0;
  List<NumTile> tiles = List();

  int difficulty;
  Grid puzzleGrid = Grid();
  Puzzle puzzle;

  HomeScreen(this.difficulty);

  _HomeScreenState state = _HomeScreenState();

  @override
  _HomeScreenState createState() => state;
}

class _HomeScreenState extends State<HomeScreen> {
  
  String board = '';
  bool isReady = false;
  bool done = false;

  @override
  void initState() {
    super.initState();
    PuzzleOptions puzzleOptions = new PuzzleOptions(
        difficulty: widget.difficulty, patternName: _getPatternName());

    widget.puzzle = new Puzzle(puzzleOptions);

    widget.puzzle.generate().then((_) {
      setState(() {
        isReady = true;
        widget.puzzleGrid = widget.puzzle.board();
      });
      widget.puzzle.onBoardChange((c) {
        if (_checkBoardDone()) {
          setState(() {
            done = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (!done)
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Wrong moves: ${widget.wrongMoves}'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                        ),
                      ),
                      GridView.count(
                        mainAxisSpacing: 0,
                        shrinkWrap: true,
                        crossAxisCount: 9,
                        children: _buildNumTile(),
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Complete Board',
                            style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.puzzleGrid = widget.puzzle.solvedBoard();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Text('done'),
      ),
    );
  }

  _buildNumTile() {
    if (isReady) {
      // puzzle.board().isRowViolated(position)
      // print(puzzle.board().matrix()[1][0].getValue());
      List<NumTile> tileList = List();

      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          Position pos = widget.puzzleGrid.matrix().toList()[i][j].position;
          int value = widget.puzzleGrid.matrix()[i][j].getValue();
          tileList.add(NumTile(
            num: value,
            active: (value == 0) ? false : true,
            pos: pos,
            grid: widget.puzzleGrid,
            screen: widget,
          ));
        }
      }

      return tileList;
    } else {
      return List.generate(
        81,
        (index) => NumTile(
          num: 0,
        ),
      );
    }
  }

  _getPatternName() {
    var rand = Random();
    int choice = rand.nextInt(3);

    switch (choice) {
      case 0:
        return 'winter';
        break;
      case 1:
        return 'summer';
        break;
      case 2:
        return 'spring';
        break;
      case 3:
        return 'fall';
        break;
    }
  }

  bool _checkBoardDone() {
    bool failed = false;

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        Position pos = widget.puzzleGrid.matrix().toList()[i][j].position;
        if (widget.puzzleGrid.isColumnViolated(pos) ||
            widget.puzzleGrid.isRowViolated(pos) ||
            widget.puzzleGrid.isSegmentViolated(pos)) {
          failed = true;
        }
      }
    }
    return failed;
  }
}
