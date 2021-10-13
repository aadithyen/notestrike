import 'package:flutter/material.dart';
import 'notecard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note.dart';
import 'noteclass.dart';
import 'dart:convert';

void main() => runApp(NoteStrike());

class NoteStrike extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        if(settings.name == '/') {
          return new MaterialPageRoute<Null>(
            settings: settings,
            builder: (_) => new NoteStrike(),
            maintainState: false,
          );
        }
      },
      title: "Notestrike",
      home: Body(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
        accentColor: Colors.blue
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
  Set _noteKeys = Set();
  var notes = <Map>[];
  SharedPreferences prefs;

  Future<Null> gotoNote(Note note) async {
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new NotePage(note)),
    );
    getSharedPrefs();
  }

  Future<Null> getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _noteKeys = prefs.getKeys();
    });
    var notesArr = <Map>[];
    _noteKeys.forEach((key) {
      var noteItemJson = prefs.getString(key);
      Map noteItem = json.decode(noteItemJson);
      notesArr.add(noteItem);
    });
    setState(() {
      notes = notesArr;
    }); 
  }

  dynamic deleteNote(String key) async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    getSharedPrefs();
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: .75,
        title: new Text("Note Strike",
          style: new TextStyle(
            fontWeight: FontWeight.bold 
          ),
        ),
        // actions: <Widget>[
        //   new IconButton(
        //     icon : new Icon(Icons.account_circle),
        //     onPressed : () {
        //     },
        //     color: Colors.white,
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add a Note"),
        onPressed: () {
          gotoNote(new Note());
        }
      ),
      body: Container(
        child: ListView.builder(
          padding: new EdgeInsets.all(10.0),
          itemCount: _noteKeys.length,
          itemBuilder: (BuildContext context, int idx) {
            bool last = _noteKeys.length == (idx + 1);
            Note note = new Note(notes[idx]['category'], notes[idx]['title'], notes[idx]['body'], notes[idx]['created'], notes[idx]['lastUpdate']);
            return new Container(
              child: new NoteCard(note, deleteNote, gotoNote),
              padding: last ? EdgeInsets.only(bottom:70.0) : EdgeInsets.only(bottom:10.0),
              );
          },
        ),
       // color: Colors.grey[900],
      )
    );
  }
}
