import 'package:error_manager/error_manager.dart';
import 'package:example/main.dart';
import 'package:example/views/network_error_view.dart';
import 'package:example/views/requirement_error_view.dart';
import 'package:example/views/timeout_error.dart';
import 'package:flutter/material.dart';

import 'actions/snackbar_error_action.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  _ErrorConstraint _constraint = _ErrorConstraint.normal;
  Object? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Manager'),
        actions: [
          IconButton(
              onPressed: _onBugChange,
              icon: const Icon(Icons.bug_report_outlined))
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text('Change constraints for display behavior'),
          ),
          _ConstraintPicker(
            value: _constraint,
            onChanged: (value) => setState(() => _constraint = value),
          ),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: ConstrainedBox(
              constraints: _constraints(),
              child: ErrorBox(
                error: _error,
                handlers: [
                  RetryErrorHandler<TimeoutError>(
                    onRetry: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return const Center(
                              child: Text('Ретрай мазафака'),
                            );
                          });
                    },
                  ),
                  const ErrorHandler<NotFoundError>()
                ],
              ),
            ),
          ),
          const Spacer(),
          SafeArea(
            bottom: true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _onRunAction,
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'errorDisplay',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxConstraints _constraints() {
    return switch (_constraint) {
      _ErrorConstraint.small => const BoxConstraints.expand(height: 100),
      _ErrorConstraint.normal => const BoxConstraints.expand(height: 200),
      _ErrorConstraint.large => const BoxConstraints.expand(height: 350),
    };
  }

  void _onBugChange() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          top: true,
          child: _BugPicker(
            onChanged: (value) {
              Navigator.of(context).maybePop();
              setState(() => _error = value);
            },
          ),
        );
      },
    );
  }

  void _onRunAction() {
    if (_error != null) {
      context.errorDisplay(error: _error!, handlers: [
        ErrorHandler<TimeoutError>(
          action: SnackBarErrorAction(),
          report: true,
        ),
        ErrorHandler<NotFoundError>(
          action: SnackBarErrorAction(),
          report: true,
        ),
      ]);
    }
  }
}

enum _ErrorConstraint {
  small(label: 'Small', iconData: Icons.photo_size_select_small_outlined),
  normal(label: 'Normal', iconData: Icons.width_normal_outlined),
  large(label: 'Large', iconData: Icons.photo_size_select_large_outlined);

  final String label;
  final IconData? iconData;

  const _ErrorConstraint({required this.label, this.iconData});
}

class _ConstraintPicker extends StatelessWidget {
  final _ErrorConstraint value;
  final ValueChanged<_ErrorConstraint> onChanged;

  const _ConstraintPicker({
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final items = _ErrorConstraint.values.map(
      (e) {
        return Expanded(
          child: TextButton.icon(
            icon: identical(value, e)
                ? const Icon(Icons.check)
                : const SizedBox.shrink(),
            label: Column(
              children: [
                Icon(e.iconData ?? Icons.info_outline),
                const SizedBox(height: 8),
                Text(e.label.toUpperCase()),
              ],
            ),
            onPressed: () => onChanged(e),
          ),
        );
      },
    ).toList();

    return Row(
      children: items,
    );
  }
}

class _BugPicker extends StatelessWidget {
  final ValueChanged<Object> onChanged;

  const _BugPicker({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final errors = <String, Object>{
      // глобально обрабатываемая ошибка
      'Устаревшая версия': RequirementError(),
      // Ошибки разные по отрисовке но
      'Не найдено': NotFoundError(),
      'Самый быстрый ковбой в сдворе': NetworkError(code: 429),
      'Повторение - мать учения': TimeoutError(),
    };

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final error = errors.values.elementAt(index);
              final label = errors.keys.elementAt(index);
              return ListTile(
                onTap: () => onChanged(error),
                title: Text(label),
              );
            },
            childCount: errors.keys.length,
          ),
        )
      ],
    );
  }
}
