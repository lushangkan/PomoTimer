import 'package:flutter/material.dart';

String? getAppLocal(BuildContext context) {
  var app = context.findAncestorWidgetOfExactType<MaterialApp>();
  if (app?.locale != null) {
    return app?.locale!.languageCode;
  }

  return null;
}