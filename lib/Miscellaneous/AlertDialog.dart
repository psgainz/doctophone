import 'package:flutter/material.dart';
import 'dart:async';

import 'package:doctophone/Miscellaneous/GlobalVariables.dart';
import 'package:doctophone/Miscellaneous/AppColors.dart';

List<Widget> buttons(int numberButtons, BuildContext context) {
  List<Widget> buttonsList = List();

  if(numberButtons == 1) {
    buttonsList.add(
      FlatButton(
        onPressed: () {
          warningButtonPressed = 'Ok';
          Navigator.pop(context);
        },
        child: Text('OK'),
      )
    );
  }
  else {
    buttonsList.add(
      FlatButton(
        onPressed: () {
          warningButtonPressed = 'Yes';
          Navigator.pop(context);
        },
        child: Text('Yes'),
      ),
    );
    buttonsList.add(
      FlatButton(
        onPressed: () {
          warningButtonPressed = 'No';
          Navigator.pop(context);
        },
        child: Text('No'),
      )
    );
  }

  return buttonsList;
}

Future showAlertDialog(BuildContext context, 
  {String alertTitle = 'Hi',
  String alertText = 'Hello',
  int numberButtons = 1}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title : Text(
          alertTitle,
          style: TextStyle(
            color: enabled,
          ),
        ),
        content: Text(
          alertText,
          style: TextStyle(
            color: enabled,
          ),
        ),
        actions: <Widget>[
          ...buttons(numberButtons, context)
        ],
      );
    }
  );
}