
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlertDialogBox(BuildContext mContext) {
    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Movie Time",style: TextStyle(color: Colors.white),),
            content: Text("Will be soon",style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.black,
          );
        });
  }
