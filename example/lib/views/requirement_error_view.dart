import 'package:error_manager/error_manager.dart';
import 'package:example/views/error_view.dart';
import 'package:flutter/material.dart';

class RequirementError extends Error {}

final class RequirementErrorView extends ErrorViewWidget<RequirementError> {
  const RequirementErrorView({super.key});

  @override
  Widget builder(context, controller) {
    return const ErrorView(
      icon: Icons.app_blocking,
      message: 'Ваша версия устарела, необходимо ее обновить',
    );
  }
}
