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
    return new MaterialApp(
      title: "Note Strike",
      home: Body(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[700],
      )
    );
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
       // backgroundColor: Color.fromRGBO(30, 4, 40, 1.0),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add a Note"),
        onPressed: () {
          print("Pressed");
        }
      ),
      body: new Container(
        child: ListView.builder(
          padding: new EdgeInsets.all(16.0),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: NoteCard(),
              padding: EdgeInsets.only(bottom:10.0),
              );
          },
        ),
       // color: Colors.grey[900],
      )
    );
  }
}
