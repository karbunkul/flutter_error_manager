part of 'main.dart';

final class RetryErrorHandler<T> extends ErrorHandler<T> {
  final VoidCallback onRetry;
  final String? label;

  RetryErrorHandler({required this.onRetry, this.label})
      : super(layout: RetryErrorLayout(onRetry: onRetry, label: label));
}
