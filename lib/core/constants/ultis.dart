import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'dart:io';

// extension Target on Object {
//   bool isAndroid() {
//     return Platform.isAndroid;
//   }
//   bool isIOS() {
//     return Platform.isIOS;
//   }
//   bool isLinux() {
//     return Platform.isLinux;
//   }
//   bool isWindows() {
//     return Platform.isWindows;
//   }
//   bool isMacOS() {
//     return Platform.isMacOS;
//   }
// }

showToastSuccess(BuildContext context, String text) {
  if (Platform.isAndroid || Platform.isIOS) {
    CherryToast.success(
      toastPosition: Position.bottom,
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ).show(context);
  } else {
    CherryToast.success(
      toastPosition: Position.top,
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ).show(context);
  }
}

showToastInformation(BuildContext context, String text) {
  if (Platform.isAndroid || Platform.isIOS) {
    CherryToast.info(
      toastPosition: Position.bottom,
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ).show(context);
  } else {
    CherryToast.info(
      toastPosition: Position.top,
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ).show(context);
  }
}

showToastFailed(BuildContext context, String text) {
  if (Platform.isAndroid || Platform.isIOS) {
    CherryToast.error(
      toastPosition: Position.bottom,
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ).show(context);
  } else {
    CherryToast.error(
      toastPosition: Position.top,
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ).show(context);
  }
}

showToastWarning(BuildContext context, String text) {
  if (Platform.isAndroid || Platform.isIOS) {
    CherryToast.warning(
      toastPosition: Position.bottom,
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ).show(context);
  } else {
    CherryToast.warning(
      toastPosition: Position.top,
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ).show(context);
  }
}
