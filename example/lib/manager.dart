part of 'main.dart';

class _ErrorManager extends StatelessWidget {
  final Widget child;

  const _ErrorManager({required this.child});

  @override
  Widget build(BuildContext context) {
    return ErrorManager(
      debugMode: true,
      onReport: (err, _) => print(err),
      handlers: [
        const ErrorHandler<RequirementError>(),
        const ErrorHandler<NetworkError>(),
        ErrorHandler<NotFoundError>(action: BannerErrorAction()),
      ],
      errors: const [
        TimeoutErrorView(),
        RequirementErrorView(),
        NetworkErrorView(),
      ],
      defaultErrorView: const DefaultErrorView(),
      child: child,
    );
  }
}
