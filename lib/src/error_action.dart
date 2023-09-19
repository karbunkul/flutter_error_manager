import 'package:flutter/cupertino.dart';

@immutable
abstract class ErrorAction {
  const ErrorAction();

  Future<void> handle(BuildContext context, Widget child);
}
