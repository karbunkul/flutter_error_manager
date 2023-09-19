import 'package:error_manager/src/error_action.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'error_box.dart';
import 'error_handler.dart';
import 'error_handler_scope.dart';
import 'error_layout_widget.dart';
import 'error_view_widget.dart';
import 'types.dart';

@immutable
class ErrorManager extends StatelessWidget {
  final bool debugMode;
  final List<ErrorViewWidget>? errors;
  final ReportCallback onReport;
  final List<ErrorHandler>? handlers;
  final ErrorViewWidget<Object> defaultErrorView;
  final ErrorLayoutWidget? defaultErrorLayout;
  final ErrorAction? defaultErrorAction;
  final Widget child;

  const ErrorManager({
    super.key,
    required this.child,
    required this.onReport,
    required this.defaultErrorView,
    this.defaultErrorLayout,
    this.defaultErrorAction,
    this.errors,
    this.debugMode = kDebugMode,
    this.handlers,
  });

  @override
  Widget build(context) {
    return ErrorHandlerScope(
      onReport: onReport,
      debugMode: debugMode,
      handlers: handlers ?? [],
      errors: errors ?? [],
      defaultErrorView: defaultErrorView,
      defaultErrorLayout: defaultErrorLayout ?? const _DefaultErrorLayout(),
      defaultErrorAction: defaultErrorAction ?? const _DefaultErrorAction(),
      child: ErrorBox(handlers: const [], child: child),
    );
  }
}

@immutable
final class _DefaultErrorLayout extends ErrorLayoutWidget {
  const _DefaultErrorLayout();

  @override
  Widget builder(context, controller) {
    return controller.error;
  }
}

@immutable
final class _DefaultErrorAction extends ErrorAction {
  const _DefaultErrorAction() : super();
  @override
  Future<void> handle(BuildContext context, Widget child) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => child,
    );
  }
}
