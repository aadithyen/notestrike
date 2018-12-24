import 'package:flutter/material.dart';
import 'notecard.dart';
import 'dart:convert';
import 'noteclass.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

class NotePage extends StatefulWidget {
  Note _note;
  NotePage(this._note);
  @override
    State<StatefulWidget> createState() {
      return new NotePageState(this._note);
    }
}
enum Categories {
  blue,red,green,orange,grey
}


class NotePageState extends State<NotePage> {
  Note _note;
  TextEditingController _titleController, _bodyController;
  final FocusNode bodyFocus = FocusNode();

  NotePageState(this._note) {
    _titleController = new TextEditingController(
      text: _note.title
    );
    _bodyController = new TextEditingController(
      text: _note.body
    );    
  }

  @override
    void dispose() {
      bodyFocus.dispose();
      super.dispose();
    }

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(_titleController.text + " : " + _bodyController.text );
              }
            ),
            PopupMenuButton<Categories>(
              icon: Icon(Icons.bookmark,
                color: Color(returnColor(_note.category))),
            itemBuilder: (BuildContext context) => <PopupMenuItem<Categories>>[
              const PopupMenuItem<Categories>(
                value: Categories.blue,
                  child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: Colors.blue,
                  ),
                  title: Text("Blue"),
                )
              ),
              const PopupMenuItem<Categories>(
                value: Categories.red,
                  child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: Colors.red,
                  ),
                  title: Text("Red"),
                )
              ),
              const PopupMenuItem<Categories>(
                value: Categories.green,
                  child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: Colors.green,
                  ),
                  title: Text("Green"),
                )
              ),
              const PopupMenuItem<Categories>(
                value: Categories.orange,
                  child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: Colors.orange,
                  ),
                  title: Text("Orange"),
                )
              ),
              const PopupMenuItem<Categories>(
                value: Categories.grey,
                  child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: Colors.grey,
                  ),
                  title: Text("Grey"),
                )
              ),
            ],
            onSelected: (Categories action) {
              setState(() {
                _note.category = action.index;
                
              });
            }
          )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.save),
          label: Text("Save"),
          foregroundColor: Colors.white,
          backgroundColor: Color(returnColor(_note.category)),
          onPressed: () async {
            if(_titleController.text == "") {
              scaffoldState.currentState.showSnackBar(
                new SnackBar(
                  content: Text("Title can't be empty"),
                )
              );
              return;
            }
            final created = (_note.created == "") ? DateTime.now().toString() : _note.created;
            var note = json.encode({
              "category": _note.category,
              "title": _titleController.text,
              "body": _bodyController.text,
              "created": created,
              "lastUpdate": DateTime.now().toString()
            });
            _note.created = created;
            final prefs = await SharedPreferences.getInstance();
            prefs.setString(created, note);
            scaffoldState.currentState.showSnackBar(
              new SnackBar(
                content: Text("Saved")
              )
            );
            
          }
        ),
        body:
        Builder( builder: (context) => 
          Container(
            color: Colors.grey[850],
            child: ListView(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(
                    bottom: 0.0,
                    top: 15.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: new TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,        
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  
                  ),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      width: 1.0,
                      color: Color(0xFFCCCCCC)
                    ))
                  ),
                ),
                new InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(bodyFocus);
                  },
                  child: Container(
                    height: 500.0,
                    padding: EdgeInsets.all(15.0),
                    child: new TextFormField(
                      controller: _bodyController,
                      focusNode: bodyFocus,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences, 
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Enter your note here...",
                        border: InputBorder.none
                      ),
                    ),
                  )
                )
              ],
            )
          ),
        )
      );
    } 
}