import 'dart:async';

/// 토큰 리프레시 실패로 세션이 만료됐을 때 UI/Bloc 에 알린다.
class SessionExpiredNotifier {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get stream => _controller.stream;

  void notify() {
    if (!_controller.isClosed) {
      _controller.add(null);
    }
  }

  void dispose() {
    unawaited(_controller.close());
  }
}
