import 'package:flutter/widgets.dart';

import 'error_handler.dart';
import 'error_handler_scope.dart';
import 'error_layout_scope.dart';
import 'error_view_scope.dart';

@immutable
class ErrorBox extends StatelessWidget {
  final List<ErrorHandler>? handlers;
  final Object? error;
  final StackTrace? stackTrace;

  final WidgetBuilder? builder;

  const ErrorBox({
    super.key,
    this.handlers,
    this.error,
    this.stackTrace,
    this.builder,
  });

  @override
  Widget build(context) {
    if (error == null) {
      try {
        return builder?.call(context) ?? const SizedBox.shrink();
      } on Object catch (e, st) {
        return _ErrorBox(
          handlers: handlers,
          error: e,
          stackTrace: st,
        );
      }
    }

    return _ErrorBox(
      handlers: handlers,
      error: error!,
      stackTrace: stackTrace,
    );
  }
}

class _ErrorBox extends StatelessWidget {
  final List<ErrorHandler>? handlers;
  final Object error;
  final StackTrace? stackTrace;

  const _ErrorBox({
    required this.error,
    this.handlers,
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
