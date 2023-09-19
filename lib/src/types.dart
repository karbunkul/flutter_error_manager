import 'package:flutter/widgets.dart';

typedef ErrorBuilder = Widget Function(BuildContext context, Object error);
typedef ReportCallback = void Function(Object error, StackTrace? stackTrace);
