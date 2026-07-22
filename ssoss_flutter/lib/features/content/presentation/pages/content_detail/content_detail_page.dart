import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_detail/content_detail_components.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generation_management/content_generation_management_components.dart';

class ContentDetailPage extends StatelessWidget {
  const ContentDetailPage({
    required this.item,
    super.key,
  });

  static const String routeName = 'content-detail';
  static const String routePath = '/content-detail';

  final ContentManagementItem item;

  ContentDetailData get _detailData => ContentDetailData(
        item: item,
        title: '을지로 크루아상 맛집 | 겹겹이 살아있는 결, 보니스커피',
        keywords: const ['디저트', '크루아상', '을지로베이커리'],
        body: _sampleBody,
        hashtags: const [
          '#을지로카페',
          '#을지로크루아상',
          '#을지로베이커리',
          '#크루아상맛집',
          '#을지로맛집',
          '#보니스커피',
          '#을지로디저트',
          '#서울카페',
          '#베이커리추천',
        ],
      );

  @override
  Widget build(BuildContext context) {
    final detail = _detailData;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SsossAppBar.back(
              title: '콘텐츠 상세 내역',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 3, 16, 34),
                children: [
                  ContentDetailInfoPanel(
                    item: detail.item,
                    keywords: detail.keywords,
                  ),
                  const SizedBox(height: 32),
                  ContentDetailSection(
                    title: '제목',
                    onEditTap: () {},
                    child: ContentDetailTextCard(text: detail.title),
                  ),
                  const SizedBox(height: 32),
                  ContentDetailSection(
                    title: '본문',
                    onEditTap: () {},
                    child: ContentDetailTextCard(text: detail.body),
                  ),
                  const SizedBox(height: 32),
                  ContentDetailSection(
                    title: '해시태그',
                    onEditTap: () {},
                    child: ContentDetailHashtagCard(hashtags: detail.hashtags),
                  ),
                  const SizedBox(height: 27),
                  ContentDetailActionButtons(
                    onCreateOtherChannel: () {},
                    onReuse: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _sampleBody = '''
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
