import 'package:flutter/material.dart';
import 'noteclass.dart';
import 'note.dart';
import 'main.dart';

// class NoteCard extends StatefulWidget {
//   final _title, _body, _category, _created, _refreshCallBack;
//   NoteCard(this._title, this._body, this._category, this._created, this._refreshCallBack);
//   @override
//     State<StatefulWidget> createState() {
//       return new NoteCardState(this._title, this._body, this._category, this._created);
//     }
// }

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

class NoteCard extends StatelessWidget{
  final Note _note;
  final _deleteCallBack, _editCallBack;
  NoteCard(this._note, this._deleteCallBack, this._editCallBack);
  @override
    Widget build(BuildContext context) {
      return new Card(
        child: new InkWell(
          onTap : () {
            this._editCallBack(_note);
          },
          child: new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new ListTile(
                  leading: new Icon(
                    Icons.bookmark,
                    color: Color(returnColor(_note.category)),
                  ),
                  title: new Text(_note.title,
                    style: new TextStyle(
                      fontWeight : FontWeight.bold
                    ),)
                ),
                new Container(
                  child: new Text(_note.body,),
                  padding: EdgeInsets.symmetric(horizontal : 20.0)
                ),
                new ButtonTheme.bar(
                  child: new ButtonBar(
                    children: <Widget>[
                      new IconButton(
                        onPressed: () async {
                          return showDialog<Null>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Are you sure you want to delete?'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Delete'),
                                    textColor: Colors.redAccent,
                                    onPressed: () {
                                      _deleteCallBack(_note.created);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
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
        )
      );
    }
}