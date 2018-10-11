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
        child: new InkWell(
          child: new Container(
            child: new Column(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(
                    Icons.bookmark,
                    color: Colors.blueAccent,
                  ),
                  title: new Text("Text Title")
                ),
                new ButtonTheme.bar(
                  child: new ButtonBar(
                    children: <Widget>[
                      new IconButton(
                        onPressed: () {

                        },
                        icon: Icon(Icons.edit),
                      ),
                      new IconButton(
                        onPressed: () {

                        },
                        icon: Icon(Icons.delete),
                      )
                    ]
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            print("Pressed on Card");
          },
        )
      );
    }
}