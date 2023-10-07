import 'package:error_manager/error_manager.dart';

final class MultiErrorHandler extends ErrorHandler {
  final List<HandlerType> types;

  const MultiErrorHandler({
    required this.types,
    super.layout,
    super.action,
    super.report,
  });

  @override
  bool hasApply(err) {
    try {
      types.firstWhere((e) => e.hasApply(err));
      return true;
    } catch (e) {
      return false;
    }
  }
}

class HandlerType<T> {
  HandlerType() {
    if (null is T) {
      throw ArgumentError('T must be extends from Object');
    }
  }
  bool hasApply(Object data) {
    return data is T;
  }
}
