import 'package:flutter/material.dart';
import 'package:minesweeper/game_page.dart';
import 'package:minesweeper/widget/game_board_tile.dart';
import 'dart:math';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final int numOfRows = 9;
  final int numOfColumns = 9;
  final int numOfMines = 11;

  List<List<TileState>> gameTilesState;
  List<List<bool>> gameTilesStatus;

  void resetBoard() {

    //2D list for tile status (covered/blown/open/flagged/revealed)
    gameTilesState = List<List<TileState>>.generate(numOfRows, (row) {
      return List<TileState>.filled(numOfColumns, TileState.covered);
    });

    //2D list for tile mine status (true for mine, false for normal)
    gameTilesStatus = List<List<bool>>.generate(numOfRows, (row) {
      return List<bool>.filled(numOfColumns, false);
    });

    //logic to place mines on the game board
    Random random = Random();
    int remainingNumOfMines = numOfMines;

    while (remainingNumOfMines > 0) {
      int positionOfMine = random.nextInt(numOfRows * numOfColumns);
      int rowIndexOfMine = positionOfMine ~/ numOfRows;
      int columnIndexOfMine = positionOfMine % numOfColumns;

      //check if new position doesn't have a mine already
      if (!gameTilesStatus[rowIndexOfMine][columnIndexOfMine]) {
        gameTilesStatus[rowIndexOfMine][columnIndexOfMine] = true;
        remainingNumOfMines--;
      }
    }
  }

  @override
  void initState() {
    resetBoard();
    super.initState();
  }

  Widget buildBoard() {
    List<Row> gameBoardRow = <Row>[];

    for (int i = 0; i < numOfRows; i++) {
      List<Widget> rowChildren = <Widget>[];

      for (int j = 0; j < numOfColumns; j++) {
        TileState tileState = gameTilesState[i][j];

        if (tileState == TileState.covered) {
          rowChildren.add(
            Tile(),
          );
        }
      }

      gameBoardRow.add(Row(
        children: rowChildren,
        mainAxisAlignment: MainAxisAlignment.center,
        key: ValueKey<int>(i),
      ));
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: gameBoardRow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: buildBoard(),
      ),
    );
  }
}