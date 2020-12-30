import 'package:flutter/material.dart';

import 'database/dbconn.dart';
import 'editdatawidget.dart';
import 'models/trans.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget(this.trans);

  final Trans trans;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  _DetailWidgetState();

  DbConn dbconn = DbConn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
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
                          children: <Widget>[
                            Text('Transaction Name:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                            Text(widget.trans.transName, style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Transaction Type:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                            Text(widget.trans.transType, style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Amount:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                            Text(widget.trans.amount.toString(), style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Transaction Date:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                            Text(widget.trans.transDate, style: Theme.of(context).textTheme.headline6)
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
                                _navigateToEditScreen(context, widget.trans);
                              },
                              child: Text('Edit', style: TextStyle(color: Colors.white)),
                              color: Colors.blue,
                            ),
                            RaisedButton(
                              splashColor: Colors.red,
                              onPressed: () {
                                _confirmDialog();
                              },
                              child: Text('Delete', style: TextStyle(color: Colors.white)),
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
    );
  }

  _navigateToEditScreen (BuildContext context, Trans trans) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataWidget(trans)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                final initDB = dbconn.initDB();
                initDB.then((db) async {
                  await dbconn.deleteTrans(widget.trans.id);
                });

                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}