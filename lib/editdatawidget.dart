import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/database/dbconn.dart';
import 'models/books.dart';

enum BooksType { earning, expense }

class EditDataWidget extends StatefulWidget {
  EditDataWidget(this.books);

  final Books books;

  @override
  _EditDataWidgetState createState() => _EditDataWidgetState();
}

class _EditDataWidgetState extends State<EditDataWidget> {
  _EditDataWidgetState();

  DbConn dbconn = DbConn();
  final _addFormKey = GlobalKey<FormState>();
  int _id;
  final format = DateFormat("dd-MM-yyyy");
  final _booksDescController = TextEditingController();
  final _booksNameController = TextEditingController();
  final _booksAuthController = TextEditingController();
  final _booksCateController = TextEditingController();
  final _bookspubyearController = TextEditingController();

  @override
  void initState() {
    _id = widget.books.id;
    _booksDescController.text = widget.books.booksDesc;
    _booksNameController.text = widget.books.booksName;
    _bookspubyearController.text = widget.books.pubyear.toString();
    _booksCateController.text = widget.books.booksCate;
    _booksAuthController.text = widget.books.booksAuth;
   // _amountController.text = widget.books.amount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Book Name"),
                                  TextFormField(
                                    controller: _booksNameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Book Name',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter book name';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {},
                                  ),
                                ])),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Description'),
                              TextFormField(
                                controller: _booksDescController,
                                decoration: const InputDecoration(
                                  hintText: 'Description',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Add Some Description';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Author Name'),
                              TextFormField(
                                controller: _booksAuthController,
                                decoration: const InputDecoration(
                                  hintText: 'Author',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Add Author Name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Category of Book'),
                              TextFormField(
                                controller: _booksCateController,
                                decoration: const InputDecoration(
                                  hintText: 'Category',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Add Category of Book';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Publication Year'),
                              TextFormField(
                                controller: _bookspubyearController,
                                decoration: const InputDecoration(
                                  hintText: 'Publication Year',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Publication Year';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (_addFormKey.currentState.validate()) {
                                    _addFormKey.currentState.save();
                                    final initDB = dbconn.initDB();
                                    initDB.then((db) async {
                                      await dbconn.updateBooks(Books(id : _id,booksDesc: _booksDescController.text, booksName: _booksNameController.text,pubyear: int.parse(_bookspubyearController.text), booksAuth: _booksAuthController.text, booksCate: _booksCateController.text));
                                    });

                                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                  }
                                },
                                child: Text('Update', style: TextStyle(color: Colors.white)),
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}