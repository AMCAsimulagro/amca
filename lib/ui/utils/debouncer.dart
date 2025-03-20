/// {@category Utils}
///
/// A debouncer class to debounce function calls.
library;
import 'dart:async';
import 'dart:ui';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  /// Constructs a Debouncer with the specified [milliseconds] duration.
  Debouncer({required this.milliseconds});

  /// Runs the provided [action] after the specified [milliseconds] have passed
  /// since the last call to this method.
  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
