import 'package:flutter/material.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {required String message,
        String okBtnText = "Ok",
        }) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(okBtnText),
              //  onPressed: okBtnFunction,
              ),

            ],
          );
        });
  }
}