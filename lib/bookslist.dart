import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/models/books.dart';

import 'detailwidget.dart';

class BooksList extends StatelessWidget {
  final List<Books> books;
  BooksList({Key key, this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: books == null ? 0 : books.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailWidget(books[index])),
                        );
                      },
                      child: ListTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                            Container(
                              width: 80,
                              height: 80,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                          books[index].image))),
                            ),
                            Column(children: <Widget>[
                              Text(
                                books[index].booksName,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text("by : " + books[index].booksAuth,
                                  style: TextStyle(fontSize: 14)),
                            ]),
                            SizedBox(width: 180),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_box,
                                  size: 40,
                                ))
                          ])))));
        });
  }
}
