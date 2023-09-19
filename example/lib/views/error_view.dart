import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String? message;
  final IconData? icon;

  const ErrorView({
    super.key,
    this.icon = Icons.error_outline_rounded,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double iconSize = switch (constraints.maxHeight) {
        <= 50 => 24,
        <= 250 => 64,
        _ => 96,
      };

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize),
            const SizedBox(height: 16),
            Text(
              message ?? '',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }
}
