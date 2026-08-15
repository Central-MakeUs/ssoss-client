/// 네트워크 연결 실패를 UI에 알린다.
class NetworkErrorNotifier {
  void Function()? onNetworkUnavailable;

  void notify() {
    onNetworkUnavailable?.call();
  }
}
