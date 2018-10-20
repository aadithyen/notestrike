import 'package:flutter/material.dart';
import 'notecard.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class NotePage extends StatefulWidget {
  var _refreshNotes;
  NotePage(this._refreshNotes);
  @override
    State<StatefulWidget> createState() {
      return new NotePageState(this._refreshNotes);
    }
}
enum Categories {
  blue,red,green,orange,grey
}

class NotePageState extends State<NotePage> {
  var _category=0, _title, _body, _created, _lastUpdate,_refreshNotes;
  NotePageState(this._refreshNotes);
  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
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
              onPressed: () {}
            ),
            PopupMenuButton<Categories>(
              icon: Icon(Icons.bookmark,
                color: Color(returnColor(_category))),
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
                _category = action.index;
                
              });
            }
          )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.save),
          label: Text("Save"),
          backgroundColor: Color(returnColor(_category)),
          onPressed: () async {
            var note = json.encode({
              "category": _category,
              "title": _title,
              "body": _body,
              "created": DateTime.now().toString(),
              "lastUpdate": _lastUpdate.toString()
            });
            final prefs = await SharedPreferences.getInstance();
            prefs.setString(DateTime.now().toString(), note);
            Timer timer = new Timer(new Duration(seconds: 1), this._refreshNotes);
          }
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(
                  bottom: 0.0,
                  top: 15.0,
                  left: 15.0,
                  right: 15.0,
                ),
                child: new TextField(
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: InputBorder.none
                  ),
                  onChanged: (str) {
                    setState(() {
                      _title= str;
                    });
                  },
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    color: Colors.black,
                    
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
              new Container(
                height:50.0,
                padding: EdgeInsets.all(15.0),
                child: new TextField(
                  onChanged: (str) {
                    setState(() {
                      _body = str;
                    });
                  },
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences, 
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter your note here...",
                    border: InputBorder.none
                  ),
                ),
              )
            ],
          )
        ),
      );
    } 
}