import 'package:flutter/widgets.dart';

import 'error_handle_behavior.dart';

@immutable
final class ErrorViewData {
  final Object error;
  final StackTrace? stackTrace;
  final ErrorHandleBehavior behavior;

  const ErrorViewData({
    required this.error,
    this.stackTrace,
    this.behavior = ErrorHandleBehavior.display,
  });

  ErrorViewData copyWith({ErrorHandleBehavior? behavior}) {
    return ErrorViewData(
      error: error,
      stackTrace: stackTrace,
      behavior: behavior ?? this.behavior,
    );
  }
}

@immutable
class ErrorViewScope extends InheritedWidget {
  final ErrorViewData data;

  const ErrorViewScope({
    super.key,
    required this.data,
    required Widget child,
  }) : super(child: child);

  static ErrorViewScope of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No ErrorViewScope found in context');
    return result!;
  }

  static ErrorViewScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ErrorViewScope>();
  }

  @override
  bool updateShouldNotify(ErrorViewScope oldWidget) {
    return data != oldWidget.data;
  }
}
