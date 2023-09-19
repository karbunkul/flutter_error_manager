import 'package:flutter/widgets.dart';

import 'error_action.dart';
import 'error_layout_widget.dart';

@immutable
base class ErrorHandler<T> {
  final ErrorLayoutWidget? layout;
  final ErrorAction? action;
  final bool report;

  const ErrorHandler({this.layout, this.action, this.report = false});

  bool hasApply(err) => err.runtimeType == T;
}
