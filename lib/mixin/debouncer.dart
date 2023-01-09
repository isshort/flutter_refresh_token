import 'dart:async';

import 'package:flutter/material.dart';

const milliseconds = 1500;
mixin Debouncer {
  Timer? _timer;

  void debounceRun(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: milliseconds), action);
  }
}
