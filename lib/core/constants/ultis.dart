import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';

showToastSuccess(BuildContext context, String text) {
  CherryToast.success(
    toastPosition: Position.bottom,
    title: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  ).show(context);
}

showToastInformation(BuildContext context, String text) {
  CherryToast.info(
    toastPosition: Position.bottom,
    title: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  ).show(context);
}

showToastFailed(BuildContext context, String text) {
  CherryToast.error(
    toastPosition: Position.top,
    title: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  ).show(context);
}

showToastWarning(BuildContext context, String text) {
  CherryToast.warning(
    toastPosition: Position.bottom,
    title: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  ).show(context);
}
