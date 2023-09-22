import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

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
  List<Widget> rowWidgt = [];

  Container _newEntry(int length, bool editable) {
    return Container(
      width: length > 1? 200:50,
      height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextField(
            enabled: editable,
            maxLength: length,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              //hintText: '',
            )),) ;
  }

  Container _shadow(int length, bool editable){
    return Container(
      width: length > 1? 200:50,
      height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(style: BorderStyle.solid)),
      child: const Center(child: Text('')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Words'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: [
              Draggable<Widget>(data: _newEntry(1, true), feedback: _shadow(1, false), child: _newEntry(1, false)),
              Draggable<Widget>(data: _newEntry(10, true), feedback: _shadow(10, false), child: _newEntry(10, false)),
              
            ],
          ),
          SizedBox(height: 20),
          DragTarget<Widget>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                // width: 200,
                height: 100,
                color: Colors.grey,
                
                child: ReorderableRow(
                    children: rowWidgt,
                    onReorder: (oldIndex, newIndex) => {print('$oldIndex, $newIndex')},
                    ),
              );
            },
            onAccept: (item) {
              setState(() {
                // droppedItems.add(item);
                //item.
                rowWidgt.add(item);
              });
            },
          ),
          SizedBox(height: 20),
          Text('Dropped Items: ${droppedItems.join(", ")}'),
          ElevatedButton(onPressed: (){setState(() {
            rowWidgt.clear();
          });}, child: const Text('Clear'))
        ],
      ),
    );
  }
}