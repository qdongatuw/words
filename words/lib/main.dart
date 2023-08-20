import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DragAndDropApp(),
    );
  }
}

class DragAndDropApp extends StatefulWidget {
  @override
  _DragAndDropAppState createState() => _DragAndDropAppState();
}

class _DragAndDropAppState extends State<DragAndDropApp> {
  List<String> draggableItems = ['Item 1', 'Item 2', 'Item 3'];
  List<String> droppedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop App'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: draggableItems.map((item) {
              return Draggable<String>(
                data: item,
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.blue,
                  child: Center(child: Text(item, style: TextStyle(color: Colors.white))),
                ),
                feedback: Material(
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.blue.withOpacity(0.7),
                    child: Center(child: Text(item, style: TextStyle(color: Colors.white))),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          DragTarget<String>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 200,
                height: 100,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    droppedItems.isNotEmpty ? droppedItems.last : 'Drop Here',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
            onAccept: (item) {
              setState(() {
                droppedItems.add(item);
              });
            },
          ),
          SizedBox(height: 20),
          Text('Dropped Items: ${droppedItems.join(", ")}'),
        ],
      ),
    );
  }
}
