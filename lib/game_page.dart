import 'package:flutter/material.dart';
import 'package:minesweeper/widget/game_board.dart';

enum TileState { covered, blown, open, flagged, revealed }

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Minesweeper"),
        ),
        body: GameBoard(),
      ),
    );
  }
}
