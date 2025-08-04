import 'dart:async';

import 'package:flutter/material.dart';
class DeBouncer {
  Duration? duration;
  VoidCallback? action;
  Timer? _timer;

  DeBouncer({this.duration});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration ?? const Duration(milliseconds: 1000), action);
  }
}