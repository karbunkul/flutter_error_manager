import 'package:flutter/widgets.dart';

@immutable
class ErrorLayoutScope extends InheritedWidget {
  final Widget error;

  const ErrorLayoutScope({
    super.key,
    required this.error,
    required Widget child,
  }) : super(child: child);

  static ErrorLayoutScope of(BuildContext context) {
    final ErrorLayoutScope? result =
        context.dependOnInheritedWidgetOfExactType<ErrorLayoutScope>();
    assert(result != null, 'No ErrorLayoutScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ErrorLayoutScope oldWidget) {
    return error != oldWidget.error;
  }
}
