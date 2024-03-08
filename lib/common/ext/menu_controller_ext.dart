import 'package:flutter/material.dart';

extension MenuControllerExt on MenuController {
  void toggle() {
    if (isOpen) {
      close();
    } else {
      open();
    }
  }
}
