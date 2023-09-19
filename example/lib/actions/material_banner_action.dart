import 'package:error_manager/error_manager.dart';
import 'package:flutter/material.dart';

final class BannerErrorAction extends ErrorAction {
  @override
  Future<void> handle(context, child) async {
    final messenger = ScaffoldMessenger.of(context)
      ..removeCurrentMaterialBanner();

    messenger.showMaterialBanner(
      MaterialBanner(
        margin: const EdgeInsets.all(16),
        content: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 150),
          child: child,
        ),
        actions: [
          TextButton(
            onPressed: () => messenger.removeCurrentMaterialBanner(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
