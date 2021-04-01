import 'package:flutter/material.dart';
import 'dart:math';

// modified version of https://medium.com/flutterdevs/keys-in-flutter-104fc01db48f

typedef void OnDelete(int index);

class StatelessColorful extends StatelessWidget {
  final Color color = UniqueColorGenerator.getColor();
  final OnDelete onDelete;

  StatelessColorful({Key key, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) => buildColorful(color);
}

class StatefulColorful extends StatefulWidget {
  final OnDelete onDelete;

  StatefulColorful({Key key, this.onDelete}) : super(key: key);
  final StatefulColorfulState state = StatefulColorfulState();

  @override
  State<StatefulColorful> createState() => state;

  set index(int index) => state.setIndex(index);
  get index => state.index;
}

class StatefulColorfulState extends State<StatefulColorful> {
  Color color;
  int index;

  @override
  void initState() {
    super.initState();
    color = UniqueColorGenerator.getColor();
  }

  void setIndex(int index) {
    if (mounted) {
      setState(() {
        this.index = index;
      });
    } else {
      this.index = index;
    }
  }

  @override
  Widget build(BuildContext context) =>
      buildColorful(color, onDelete: widget.onDelete, index: index);
}

Widget buildColorful(Color color, {OnDelete onDelete, int index}) {
  return ColoredBox(
    color: color,
    child: SizedBox(
      height: 200,
      width: 110,
      child: Form(
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDelete(index),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Hello',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class UniqueColorGenerator {
  static Color getColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}
