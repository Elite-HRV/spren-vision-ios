import 'package:flutter/material.dart';

class DialogUtils {
  static Future<bool?> displayDialogOKCallBack(
      BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content:  Text(message),
          actions: <Widget>[
            FlatButton(
              child:  const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}