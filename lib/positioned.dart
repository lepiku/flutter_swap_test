import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swap_app/colorful.dart';

// modified version of https://medium.com/flutterdevs/keys-in-flutter-104fc01db48f

class PositionedKey extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedKeyState();
}

class PositionedKeyState extends State<PositionedKey> {
  List<StatefulColorful> tiles;

  @override
  void initState() {
    super.initState();
    tiles = [
      StatefulColorful(
        key: UniqueKey(), // Key is important
        onDelete: onDelete,
      ),
      StatefulColorful(
        key: UniqueKey(),
        onDelete: onDelete,
      ),
      StatefulColorful(
        key: UniqueKey(),
        onDelete: onDelete,
      ),
    ];
    refreshIndex();
  }

  void onDelete(index) {
    print('delete $index');
    setState(() {
      tiles.removeAt(index);
      refreshIndex();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tiles,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.arrow_right_alt),
            onPressed: swapTiles,
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: resetTiles,
          ),
        ],
      ),
    );
  }

  void swapTiles() {
    setState(() {
      tiles.insert(0, tiles.removeAt(tiles.length - 1));
      refreshIndex();
    });
  }

  /// so it can delete correctly
  void refreshIndex() {
    print('refresh idx');
    for (int idx = 0; idx < tiles.length; idx++) {
      tiles[idx].index = idx;
    }
  }

  void resetTiles() {
    setState(() {
      tiles = [
        StatefulColorful(
          key: UniqueKey(),
          onDelete: onDelete,
        ),
        StatefulColorful(
          key: UniqueKey(),
          onDelete: onDelete,
        ),
        StatefulColorful(
          key: UniqueKey(),
          onDelete: onDelete,
        ),
      ];
      refreshIndex();
    });
  }
}
