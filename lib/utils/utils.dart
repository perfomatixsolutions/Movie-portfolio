import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/const/constants.dart';

showAlertDialogBox(BuildContext mContext) {
    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(APP_NAME,style: TextStyle(color: Colors.white),),
            content: Text(MOVIE_ALERT_DESCRIPTION,style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.black,
          );
        });
  }

/// fun to navigate to previous screen

moveToLastScreen(BuildContext context) {
  Navigator.pop(context,true);
}
