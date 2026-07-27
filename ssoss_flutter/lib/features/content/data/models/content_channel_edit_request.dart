/// PUT `/v1/contents/{contentId}/channels/{contentChannelId}` 요청 본문.
class ContentChannelEditRequest {
  const ContentChannelEditRequest({
    required this.body,
    this.title,
    this.hashtags = const [],
  });

  final String? title;
  final String body;
  final List<String> hashtags;

  /// null title 키는 제외한다.
  Map<String, dynamic> toApiJson() => {
        'body': body,
        'hashtags': hashtags,
        if (title != null) 'title': title,
      };
}
