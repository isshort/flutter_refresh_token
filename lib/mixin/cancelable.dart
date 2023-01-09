import 'package:async/async.dart';
import 'package:flutter/material.dart';

mixin CancelableMixin<T extends StatefulWidget> on State<T> {
  late CancelableOperation<void> cancellableOperation;
  TextEditingController controller = TextEditingController();
  final _delayTime = const Duration(milliseconds: 1500);

  void _start() {
    cancellableOperation = CancelableOperation.fromFuture(
      Future.delayed(_delayTime),
    );
  }

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    cancellableOperation.cancel();
  }

  void onChange(String value, VoidCallback action) {
    cancellableOperation.cancel();
    _start();
    cancellableOperation.value.whenComplete(
      action,
    );
  }
}
