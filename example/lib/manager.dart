part of 'main.dart';

class _ErrorManager extends StatelessWidget {
  final Widget child;

  const _ErrorManager({required this.child});

  @override
  Widget build(BuildContext context) {
    return ErrorManager(
      debugMode: true,
      onReport: (err, st) {
        log('on report', error: err, stackTrace: st);
      },
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
