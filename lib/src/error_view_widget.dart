import 'package:error_manager/src/error_handle_behavior.dart';
import 'package:flutter/widgets.dart';

import 'error_handler_scope.dart';
import 'error_view_scope.dart';

@immutable
final class ErrorViewController<T> {
  final T error;
  final StackTrace? stackTrace;
  final bool debugMode;
  final ErrorHandleBehavior behavior;

  const ErrorViewController({
    required this.error,
    required this.debugMode,
    required this.behavior,
    this.stackTrace,
  });

  bool get isDisplay => behavior == ErrorHandleBehavior.display;
  bool get isAction => behavior == ErrorHandleBehavior.action;
}

@immutable
abstract base class ErrorViewWidget<T> extends StatelessWidget {
  bool hasApply(Object error) {
    return error.runtimeType == T;
  }

  const ErrorViewWidget({super.key});

  Widget builder(BuildContext context, ErrorViewController<T> controller);

  @override
  Widget build(BuildContext context) {
    final errorScope = ErrorHandlerScope.of(context);
    final errorViewScope = ErrorViewScope.of(context);
    final controller = ErrorViewController<T>(
      error: errorViewScope.data.error as T,
      stackTrace: errorViewScope.data.stackTrace,
      debugMode: errorScope.debugMode,
      behavior: errorViewScope.data.behavior,
    );

    return builder(context, controller);
  }
}
