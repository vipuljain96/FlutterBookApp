import 'package:flutter/material.dart';
import 'package:flutter_offline/adddatawidget.dart';
import 'dart:async';
import 'package:flutter_offline/models/books.dart';
import 'package:flutter_offline/database/dbconn.dart';
import 'package:flutter_offline/bookslist.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booksactions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Books Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbConn dbconn = DbConn();
  List<Books> booksList;
  int totalCount = 0;

  @override
  Widget build(BuildContext context) {

    if(booksList == null) {
      booksList = List<Books>();
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new Container(
        child: new Center(
            child: new FutureBuilder(
              future: loadList(),
              builder: (context, snapshot) {
                return booksList.length > 0? new BooksList(books: booksList):
                new Center(child:
                new Text('No data found, tap plus button to add!', style: Theme.of(context).textTheme.headline6));
              },
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child:  new FutureBuilder(
      //     future: loadTotal(),
      //       builder: (context, snapshot)  {
      //         return Padding(
      //           padding: EdgeInsets.all(16.0),
      //           child: Text('Total: $totalCount', style: Theme.of(context).textTheme.headline6),
      //         );
      //       },
      //   ),
      //   color: Colors.cyanAccent,
      // ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future loadList() {
    final Future futureDB = dbconn.initDB();
    return futureDB.then((db) {
      Future<List<Books>> futureBooks = dbconn.books();
      futureBooks.then((booksList) {
        setState(() {
          this.booksList = booksList;
        });
      });
    });
  }

  // Future loadTotal() {
  //   final Future futureDB = dbconn.initDB();
  //   return futureDB.then((db) {
  //     Future<int> futureTotal = dbconn.countTotal();
  //     futureTotal.then((ft) {
  //       setState(() {
  //         this.totalCount = ft;
  //       });
  //     });
  //   });
  // }

  _navigateToAddScreen (BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}
