import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar mySnackbar(sText, sColor, sIcon) {
  return GetSnackBar(
    margin: EdgeInsets.all(15),
    icon: Icon(sIcon, color: Colors.white),
    borderRadius: 8,
    message: (sText),
    duration: Duration(seconds: 3),
    backgroundColor: sColor,
  );
}
