import 'package:error_manager/error_manager.dart';
import 'package:flutter/material.dart';

final class SnackBarErrorAction extends ErrorAction {
  @override
  Future<void> handle(context, child) async {
    final messenger = ScaffoldMessenger.of(context)..removeCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: child,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
