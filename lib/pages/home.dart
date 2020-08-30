import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum GesturesList { onTap, onDoubleTap, onLongPress, onPanUpdate }

class Home extends StatefulWidget {
  const Home({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _gesturedDetected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            this._buildGestureDetector(),
            Divider(
              color: Colors.black,
              height: 44.0,
            ),
            this._buildDraggable(),
            Divider(
              height: 40.0,
            ),
            this._buildDragTarget(),
          ],
        ),
      )),
    );
  }

  GestureDetector _buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        print(describeEnum(GesturesList.onTap));
        this._displayGestureDetected(describeEnum(GesturesList.onTap));
      },
      onDoubleTap: () {
        print(describeEnum(GesturesList.onDoubleTap));
        this._displayGestureDetected(describeEnum(GesturesList.onDoubleTap));
      },
      onLongPress: () {
        print(describeEnum(GesturesList.onLongPress));
        this._displayGestureDetected(describeEnum(GesturesList.onLongPress));
      },
      onPanUpdate: (DragUpdateDetails details) {
        print('onPanUpdate: $details');
        this._displayGestureDetected(describeEnum(GesturesList.onPanUpdate));
      },
      child: Container(
        color: Colors.lightGreen.shade100,
        width: double.infinity,
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.access_alarm,
              size: 98.0,
            ),
            Text('${this._gesturedDetected}'),
          ],
        ),
      ),
    );
  }

  void _displayGestureDetected(String gesture) {
    setState(() {
      this._gesturedDetected = gesture;
    });
  }

  Draggable<int> _buildDraggable() {
    return Draggable(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.palette,
            color: Colors.deepOrange,
            size: 48.0,
          ),
          Text('Drag Me below to change color'),
        ],
      ),
      childWhenDragging: Icon(
        Icons.palette,
        color: Colors.grey,
        size: 48.0,
      ),
      feedback: Icon(
        Icons.brush,
        color: Colors.deepOrange,
        size: 80.0,
      ),
      data: Colors.deepOrange.value,
    );
  }

  DragTarget<int> _buildDragTarget() {
    Color paintedColor;
    return DragTarget<int>(
        onAccept: (colorValue) {
          paintedColor = Color(colorValue);
        },
        builder: (BuildContext context, List<dynamic> acceptedData,
                List<dynamic> rejectedData) =>
            acceptedData.isEmpty
                ? Text(
                    'Drag To and see color change',
                    style: TextStyle(
                      color: paintedColor,
                    ),
                  )
                : Text(
                    'Painting Color: $acceptedData',
                    style: TextStyle(
                        color: Color(acceptedData[0]),
                        fontWeight: FontWeight.bold),
                  ));
  }
}
