import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context) async {
  AlertDialog alert = await AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(color: Colors.amber),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
