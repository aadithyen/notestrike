import 'package:flutter/material.dart';

class NoteCard extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return new NoteCardState();
    }
}

class NoteCardState extends State<NoteCard> {
  @override
    Widget build(BuildContext context) {
      return new Card(
        child: new Container(
          child: new Column(
            children: <Widget>[
              new ListTile(
                leading: new Icon(
                  Icons.bookmark,
                  color: Colors.blue,
                ),
                title: new Text("Text Title")
              )
            ],
          ),
        )
      );
    }
}