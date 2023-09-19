import 'package:error_manager/error_manager.dart';
import 'package:example/views/error_view.dart';
import 'package:flutter/material.dart';

class NetworkError extends Error {
  final int code;

  NetworkError({required this.code});
}

class NotFoundError extends NetworkError {
  NotFoundError() : super(code: 404);
}

class ManyRequestError extends NetworkError {
  ManyRequestError() : super(code: 429);
}

final class NetworkErrorView extends ErrorViewWidget<NetworkError> {
  const NetworkErrorView({super.key});

  @override
  bool hasApply(Object error) {
    return error is NetworkError;
  }

  @override
  Widget builder(context, controller) {
    final icon = switch (controller.error.code) {
      429 => Icons.warning_amber,
      404 => Icons.hourglass_empty,
      _ => Icons.network_check,
    };

    final message = switch (controller.error.code) {
      404 => 'Ищу, ищу и не найду, простите меня, попробуйте уточнить запрос',
      429 => 'У нас сервер не такой быстрый как ваши руки',
      _ => 'Упс на сервере проблема, но мы уже знаем о ней и чиним',
    };

    return ErrorView(
      icon: icon,
      message: message,
    );
  }
}
