import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

/// 생성 결과 화면용 더미 텍스트.
class ContentResultDummy {
  const ContentResultDummy._();

  static const String blogTitle = '을지로 크루아상 맛집 | 겹겹이 살아있는 결, 보니스커피';

  static const String blogBody = '''
을지로에서 크루아상 하나를 제대로 먹고 싶다면, 보니스커피를 추천드려요.

매일 아침 6시부터 직접 반죽을 밀고, 버터를 켜켜이 발라 구워내는 크루아상은 겉은 바삭, 속은 결결이 살아있는 식감이 특징이에요. 프랑스산 에쉬레 버터를 사용해서 고소함이 남다릅니다.

【 보니스커피 정보 】
📍 위치: 서울 중구 을지로
⏰ 영업시간: 월-금 08:00~20:00 / 주말 09:00~19:00
🅿️ 인근 공영주차장 이용 가능 (30분 무료)
📦 포장 가능 | 예약 가능

【 시그니처 메뉴 】
• 버터 크루아상 (3,800원)
• 아몬드 크루아상 (4,500원)
• 크루아상 샌드위치 (7,500원)

오전 10시 이전 방문하면 갓 구운 크루아상을 만나실 수 있어요. 주말에는 조기 완판되는 경우가 많으니 일찍 오시는 걸 추천드려요!

을지로 산책 후 들르기 딱 좋은 을지로 베이커리로 자리 잡은 보니스커피, 한 번 오시면 단골 되실 거예요 😊
''';

  static const List<String> instagramHashtags = [
    '#을지로카페',
    '#을지로크루아상',
    '#을지로베이커리',
    '#크루아상맛집',
    '#을지로맛집',
    '#보니스커피',
    '#을지로디저트',
    '#서울카페',
    '#베이커리추천',
  ];

  static const String snsBody = '''
을지로에서 크루아상 하나를 제대로 먹고 싶다면, 보니스커피를 추천드려요.

매일 아침 6시부터 직접 반죽을 밀고, 버터를 켜켜이 발라 구워내는 크루아상은 겉은 바삭, 속은 결결이 살아있는 식감이 특징이에요. 프랑스산 에쉬레 버터를 사용해서 고소함이 남다릅니다.

【 보니스커피 정보 】
📍 위치: 서울 중구 을지로
⏰ 영업시간: 월-금 08:00~20:00 / 주말 09:00~19:00
🅿️ 인근 공영주차장 이용 가능 (30분 무료)
📦 포장 가능 | 예약 가능

【 시그니처 메뉴 】
• 버터 크루아상 (3,800원)
• 아몬드 크루아상 (4,500원)
• 크루아상 샌드위치 (7,500원)

오전 10시 이전 방문하면 갓 구운 크루아상을 만나실 수 있어요. 주말에는 조기 완판되는 경우가 많으니 일찍 오시는 걸 추천드려요!

을지로 산책 후 들르기 딱 좋은 을지로 베이커리로 자리 잡은 보니스커피, 한 번 오시면 단골 되실 거예요 😊
''';

  static const String shortSnsBody = '''
겹겹이 살아있는 결 🥐

매일 아침 직접 구워내는 을지로 크루아상 맛집, 홍이네 베이커리예요. 에쉬레 버터의 고소함이 한 입에 가득 퍼져요.

오전 10시 전 방문하면 갓 구운 크루아상 만나실 수 있어요!

📍 서울 중구 을지로
⏰ 평일 08:00-20:00 / 주말 09:00-19:00
''';

  static const String carrotBody = '''
을지로에서 크루아상 찾으신다면 저희 가게로 오세요 🥐

매일 새벽부터 직접 만드는 버터 크루아상인데, 오늘도 오전에 다 팔렸어요. 내일은 조금 더 만들어볼게요!
''';

  static const String threadBody = '''
매일 새벽부터 만드는 버터 크루아상, 오늘도 오전에 완판됐어요.

을지로 산책 후 들르기 좋은 보니스커피에서 갓 구운 결을 만나보세요 🥐
''';

  static String bodyFor(UploadChannel channel, {required bool compact}) {
    return switch (channel) {
      UploadChannel.blog => blogBody,
      UploadChannel.instagram => compact ? shortSnsBody : snsBody,
      UploadChannel.carrot => carrotBody,
      UploadChannel.thread => threadBody,
    };
  }
}
