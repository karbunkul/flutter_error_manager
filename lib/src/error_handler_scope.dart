import 'package:flutter/widgets.dart';

import 'error_action.dart';
import 'error_handler.dart';
import 'error_layout_widget.dart';
import 'error_view_widget.dart';
import 'types.dart';

@immutable
class ErrorHandlerScope extends InheritedWidget {
  final bool debugMode;
  final ReportCallback onReport;
  final List<ErrorHandler> handlers;
  final List<ErrorViewWidget> errors;
  final ErrorViewWidget<Object> defaultErrorView;
  final ErrorLayoutWidget defaultErrorLayout;
  final ErrorAction defaultErrorAction;

  const ErrorHandlerScope({
    super.key,
    required this.debugMode,
    required this.handlers,
    required this.onReport,
    required this.errors,
    required this.defaultErrorView,
    required this.defaultErrorLayout,
    required this.defaultErrorAction,
    required Widget child,
  }) : super(child: child);

  static ErrorHandlerScope of(BuildContext context) {
    final ErrorHandlerScope? result =
        context.dependOnInheritedWidgetOfExactType<ErrorHandlerScope>();
    assert(result != null, 'No ErrorHandlerScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ErrorHandlerScope oldWidget) {
    return debugMode != oldWidget.debugMode;
  }

  ErrorHandler findHandler({
    required Object error,
    bool report = true,
    StackTrace? stackTrace,
    List<ErrorHandler>? handlers,
  }) {
    final newHandlers = [
      ...handlers ?? [],
      ...this.handlers,
    ];

    return newHandlers.firstWhere((element) {
      final hasApply = element.hasApply(error);

      if (report && hasApply && element.report) {
        onReport(error, stackTrace);
      }

      return hasApply;
    }, orElse: () {
      if (report) {
        onReport(error, stackTrace);
      }

      return const ErrorHandler<Object>();
    });
  }

  ErrorViewWidget findView(Object error) {
    return errors.firstWhere(
      (element) => element.hasApply(error),
      orElse: () => defaultErrorView,
    );
  }
}
