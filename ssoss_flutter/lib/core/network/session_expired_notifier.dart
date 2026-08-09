import 'dart:async';

/// 토큰 리프레시 실패로 세션이 만료됐을 때 UI/Bloc 에 알린다.
class SessionExpiredNotifier {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get stream => _controller.stream;

  /// 로그인 후 화면에서 세션 만료 토스트를 띄울 때 사용한다.
  void Function()? onSessionExpiredUi;

  void notify() {
    onSessionExpiredUi?.call();
    if (!_controller.isClosed) {
      _controller.add(null);
    }
  }

  void dispose() {
    unawaited(_controller.close());
  }
}
