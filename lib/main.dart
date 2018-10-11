import 'package:flutter/material.dart';
import './notecard.dart';

void main() => runApp(NoteStrike());

// class noteStrike extends StatefulWidget {
//   @override
//     State<StatefulWidget> createState() {
//       return new noteStrikeState();
//     }
// }

class NoteStrike extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: "Note Strike", home: Body());
  }
}

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BodyState();
  }
}

class BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Note Strike",
          style: new TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add a Note"),
        onPressed: () {
          print("Pressed");
        }
      ),
      body: new ListView.builder(
        padding: new EdgeInsets.all(16.0),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return new NoteCard();
        },
      )
    );
  }
}
