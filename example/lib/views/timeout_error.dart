import 'package:error_manager/error_manager.dart';
import 'package:example/views/error_view.dart';
import 'package:flutter/material.dart';

class TimeoutError extends Error {}

final class TimeoutErrorView extends ErrorViewWidget<TimeoutError> {
  const TimeoutErrorView({super.key});

  @override
  Widget builder(context, controller) {
    return const ErrorView(
      icon: Icons.timer_outlined,
      message: 'Время вышло',
    );
  }
}
