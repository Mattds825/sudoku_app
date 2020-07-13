import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:sudoku_app/home_screen.dart';

class NumTile extends StatefulWidget {
  int num;
  bool active = false;
  Position pos;
  Grid grid;
  HomeScreen screen;
  bool violated = false;

  NumTile({Key key, this.num, this.active, this.pos, this.grid, this.screen})
      : super(key: key);

  @override
  _NumTileState createState() => _NumTileState();
}

class _NumTileState extends State<NumTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        child: Container(
          width: 25,
          height: 25,
          color: Colors.orange.shade100,
          child: Center(
            child: Text((widget.active) ? widget.num.toString() : ''),
          ),
        ),
        onTap: () => showDialog(
            context: context,
            builder: (_) {
              return GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.blue.shade100,
                                child: Center(child: Text('1')),
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              _changeNum(1);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                color: Colors.blue.shade100,
                                child: Center(child: Text('2')),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _changeNum(2);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                child: Center(child: Text('3')),
                                color: Colors.blue.shade100,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _changeNum(3);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                child: Center(child: Text('4')),
                                color: Colors.blue.shade100,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _changeNum(4);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                child: Center(child: Text('5')),
                                color: Colors.blue.shade100,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _changeNum(5);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                color: Colors.blue.shade100,
                                child: Center(child: Text('6')),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _changeNum(6);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                child: Center(child: Text('7')),
                                color: Colors.blue.shade100,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _changeNum(7);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                child: Center(child: Text('8')),
                                color: Colors.blue.shade100,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _changeNum(8);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                child: Center(child: Text('9')),
                                color: Colors.blue.shade100,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _changeNum(9);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void _changeNum(int new_num) {
    setState(() {
      widget.num = new_num;

      bool prevInvalid = false;

      if (!widget.grid.cellAt(widget.pos).valid() &&
          widget.grid.cellAt(widget.pos).getValue() != 0)
        prevInvalid = true;

      widget.screen.puzzle.fillCell(widget.pos, widget.num);

      if (!widget.active) widget.active = true;

      if (!widget.grid.isColumnViolated(widget.pos) &&
          !widget.grid.isRowViolated(widget.pos) &&
          !widget.grid.isSegmentViolated(widget.pos)) {
        widget.grid.cellAt(widget.pos).setValidity(true);
      }

      if (!widget.grid.cellAt(widget.pos).valid()) {
        // print('widget.violated');
        if (!prevInvalid) {
          widget.screen.state.setState(() {
            widget.screen.wrongMoves++;
          });
        }
      } else {
        print('valid');
        if (widget.screen.wrongMoves > 0) {
          widget.screen.state.setState(() {
            widget.screen.wrongMoves--;
            widget.violated = false;
          });
        }
      }
    });
  }
}
