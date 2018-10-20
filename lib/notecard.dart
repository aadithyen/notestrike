import 'package:flutter/material.dart';
import 'noteclass.dart';

class NoteCard extends StatefulWidget {
  final _title, _body, _category, _created;
  NoteCard(this._title, this._body, this._category, this._created);
  @override
    State<StatefulWidget> createState() {
      return new NoteCardState(this._title, this._body, this._category, this._created);
    }
}

int returnColor(int category) {
  switch (category) {
    case 0:
      return 0xFF2196F3;
      break;
    case 1:
      return 0xFFF44336;
      break;
    case 2:
      return 0xFF4CAF50;
      break;
    case 3:
      return 0xFFFF9800;
      break;
    case 4:
      return 0xFF9E9E9E;
      break;
    default:
      return 0;
  }
}

class NoteCardState extends State<NoteCard> {
  var _title, _body, _category, _created;
  NoteCardState(this._title, this._body, this._category, this._created);

  @override
    Widget build(BuildContext context) {
      return new Card(
        child: new InkWell(
          child: new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new ListTile(
                  leading: new Icon(
                    Icons.bookmark,
                    color: Color(returnColor(_category)),
                  ),
                  title: new Text(_title,
                    style: new TextStyle(
                      fontWeight : FontWeight.bold
                    ),)
                ),
                new Container(
                  child: new Text(_body,),
                  padding: EdgeInsets.symmetric(horizontal : 20.0)
                ),
                new ButtonTheme.bar(
                  child: new ButtonBar(
                    children: <Widget>[
                      new IconButton(
                        onPressed: () {

                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black38,),
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