part of 'main.dart';

final class DefaultErrorView extends ErrorViewWidget<Object> {
  const DefaultErrorView({super.key});

  @override
  Widget builder(context, controller) {
    return ListTile(
      leading: const Icon(
        Icons.error_outline_outlined,
        color: Colors.red,
      ),
      title: const Text('Error'),
      subtitle: controller.debugMode
          ? Text(controller.error.toString())
          : const Text('OOPs'),
    );
  }
}
