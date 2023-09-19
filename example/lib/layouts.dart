part of 'main.dart';

final class RetryErrorLayout extends ErrorLayoutWidget {
  final VoidCallback onRetry;
  final String? label;

  const RetryErrorLayout({super.key, required this.onRetry, this.label});

  @override
  Widget builder(context, controller) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          controller.error,
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: onRetry, child: Text(label ?? 'Retry')),
                if (controller.debugMode)
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                      controller.stackTrace?.toString() ??
                                          StackTrace.current.toString()),
                                ),
                              );
                            });
                      },
                      child: Text('Info')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
