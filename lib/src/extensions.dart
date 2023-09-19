import 'package:error_manager/error_manager.dart';
import 'package:error_manager/src/error_handler_scope.dart';
import 'package:error_manager/src/error_view_scope.dart';
import 'package:flutter/cupertino.dart';

extension ErrorDispatcherExtension on BuildContext {
  Future<void> errorDisplay({
    required Object error,
    StackTrace? stackTrace,
    List<ErrorHandler>? handlers,
  }) async {
    final errorHandlerScope = ErrorHandlerScope.of(this);
    final handler = errorHandlerScope.findHandler(
      report: false,
      error: error,
      stackTrace: stackTrace,
      handlers: handlers,
    );
    final action = handler.action ?? errorHandlerScope.defaultErrorAction;

    return action.handle(
      this,
      ErrorViewScope(
        data: ErrorViewData(
          stackTrace: stackTrace,
          error: error,
          behavior: ErrorHandleBehavior.action,
        ),
        child: ErrorBox(
          error: error,
          stackTrace: stackTrace,
          handlers: handlers ?? const [],
        ),
      ),
    );
  }

  Future<void> errorHandle(
    VoidCallback callback, {
    List<ErrorHandler>? handlers,
  }) async {
    try {
      callback();
    } catch (error, stackTrace) {
      return errorDisplay(
        error: error,
        stackTrace: stackTrace,
        handlers: handlers,
      );
    }
  }
}
