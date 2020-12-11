/*

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

showAlertDialog(context,e) {
  BuildContext dialogContext;
  Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //return AdminScreen();
        Navigator.pop(dialogContext,true);

        //}));
      }
  );
  /*
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(e),
    actions: [
      okButton,
    ],
  );

   */
  showDialog(context:context, builder: (BuildContext context) {
    dialogContext = context;
    return showAlert(dialogContext,e);
  });
}

 */


