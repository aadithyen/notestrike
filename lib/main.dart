import 'package:flutter/material.dart';
import 'notecard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note.dart';
import 'noteclass.dart';
import 'dart:convert';

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
      onGenerateRoute: (RouteSettings settings) {
        if(settings.name == '/') {
          return new MaterialPageRoute<Null>(
            settings: settings,
            builder: (_) => new NoteStrike(),
            maintainState: false,
          );
        }
      },
      title: "Note Strike",
      home: Body(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(255, 255, 255, 1.0),
        //accentColor: Color.fromRGBO(252, 163, 17, 1.0)
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
  Future<Null> getSharedPrefs() async {
    print("Refreshing notes...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
          _noteKeys = prefs.getKeys();
    });
    _noteKeys.forEach((key) {
      var noteItemJson = prefs.getString(key);
      Map noteItem = json.decode(noteItemJson);
      setState(() {
        notes.add(noteItem);
      }); 
    });
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
        actions: <Widget>[
          new IconButton(
            icon : new Icon(Icons.account_circle),
            onPressed : () {
            },
            color: Colors.white,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add a Note"),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new NotePage(getSharedPrefs)),
          );
        }
      ),
      body: Container(
        child: ListView.builder(
          padding: new EdgeInsets.all(10.0),
          itemCount: _noteKeys.length,
          itemBuilder: (BuildContext context, int idx) {
            bool last = _noteKeys.length == (idx + 1);
            print(idx);
            print(notes[idx]);
            return new Container(
              child: new NoteCard(notes[idx]['title'], notes[idx]['body'], notes[idx]['category'], notes[idx]['created']),
              // child: new NoteCard("Hello", "Raman", 2 , DateTime.now()),
              padding: last ? EdgeInsets.only(bottom:70.0) : EdgeInsets.only(bottom:10.0),
              );
          },
        ),
       // color: Colors.grey[900],
      )
    );
  }
}
