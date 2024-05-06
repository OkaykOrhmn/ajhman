import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showNormalSnackBar(BuildContext context, String message) {

  SnackBar snackBar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.fixed,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorSnackBar(BuildContext context, String message) {

  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.redAccent,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}