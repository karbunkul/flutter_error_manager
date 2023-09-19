import 'package:flutter/widgets.dart';

import 'error_handler_scope.dart';
import 'error_layout_scope.dart';
import 'error_view_scope.dart';

@immutable
final class ErrorLayoutController {
  final Widget error;
  final bool debugMode;
  final StackTrace? stackTrace;

  const ErrorLayoutController({
    required this.error,
    required this.debugMode,
    this.stackTrace,
  });
}

@immutable
abstract base class ErrorLayoutWidget extends StatelessWidget {
  const ErrorLayoutWidget({super.key});

  Widget builder(BuildContext context, ErrorLayoutController controller);

  @override
  Widget build(BuildContext context) {
    final layoutScope = ErrorLayoutScope.of(context);
    final errorScope = ErrorHandlerScope.of(context);
    final viewScope = ErrorViewScope.of(context);

    final controller = ErrorLayoutController(
      error: layoutScope.error,
      debugMode: errorScope.debugMode,
      stackTrace: viewScope.data.stackTrace,
    );

    return builder(context, controller);
  }
}
