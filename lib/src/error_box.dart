import 'package:flutter/widgets.dart';

import 'error_handler.dart';
import 'error_handler_scope.dart';
import 'error_layout_scope.dart';
import 'error_view_scope.dart';

@immutable
class ErrorBox extends StatelessWidget {
  final List<ErrorHandler> handlers;
  final Object? error;
  final StackTrace? stackTrace;

  final Widget? child;

  const ErrorBox({
    super.key,
    required this.handlers,
    this.error,
    this.stackTrace,
    this.child,
  });

  @override
  Widget build(context) {
    ErrorWidget.builder = _errorWidgetBuilder(context, handlers: handlers);

    if (error == null) {
      return child ?? const SizedBox.shrink();
    }

    return _ErrorBox(
      handlers: handlers,
      error: error!,
      stackTrace: stackTrace,
    );
  }

  ErrorWidgetBuilder _errorWidgetBuilder(
    BuildContext context, {
    required List<ErrorHandler> handlers,
  }) {
    return (details) {
      return _ErrorBox(
        handlers: handlers,
        error: details.exception,
        stackTrace: details.stack,
      );
    };
  }
}

class _ErrorBox extends StatelessWidget {
  final List<ErrorHandler> handlers;
  final Object error;
  final StackTrace? stackTrace;

  const _ErrorBox({
    required this.handlers,
    required this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    final errorScope = ErrorHandlerScope.of(context);

    final handler = errorScope.findHandler(
      error: error,
      stackTrace: stackTrace,
      handlers: handlers,
    );

    final errorViewScope = ErrorViewScope.maybeOf(context);
    final errorViewData = errorViewScope != null
        ? errorViewScope.data
        : ErrorViewData(error: error, stackTrace: stackTrace);

    return ErrorViewScope(
      data: errorViewData,
      child: Builder(builder: (context) {
        final view = errorScope.findView(error);
        return ErrorLayoutScope(
          error: view,
          child: handler.layout ?? errorScope.defaultErrorLayout,
        );
      }),
    );
  }
}
