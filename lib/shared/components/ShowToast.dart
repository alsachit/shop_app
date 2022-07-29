import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastState {success , error, warning}

class ShowToast {

  static void showToast({required ToastState state, required String message}) {
        Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static Color chooseToastColor(ToastState state) {
    Color color;
    switch (state) {
      case ToastState.success :
        color = Colors.green;
        break;
      case ToastState.error :
        color = Colors.red;
        break;
      case ToastState.warning :
        color = Colors.orangeAccent;
        break;
    }

    return color;
  }
}
