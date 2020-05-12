import 'package:flutter/material.dart';
import 'package:flutter_offline/models/trans.dart';

import 'detailwidget.dart';

class TransList extends StatelessWidget {
  final List<Trans> trans;
  TransList({Key key, this.trans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
        itemCount: trans == null ? 0 : trans.length,
        itemBuilder: (BuildContext context, int index) {
          return
            Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailWidget(trans[index])),
                    );
                  },
                  child: ListTile(
                    leading: trans[index].transType == 'earning'? Icon(Icons.attach_money): Icon(Icons.money_off),
                    title: Text(trans[index].transName),
                    subtitle: Text(trans[index].amount.toString()),
                  ),
                )
            );
        });
  }
}
