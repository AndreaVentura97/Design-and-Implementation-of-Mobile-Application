

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

showAlertDialog(context,e) {
  BuildContext dialogContext;
  Widget vote;


  return AlertDialog(
    title: Text("Votes"),
    content: Text("Votes"),
    actions: [
      vote,
    ],
  );


  showDialog(context:context, builder: (BuildContext context) {
    dialogContext = context;
    //return showAlert(dialogContext,e);
  });
}




