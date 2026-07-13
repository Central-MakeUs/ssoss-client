import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_edit_card.dart';
import 'package:ssoss_flutter/common/widgets/card/editor/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_event.dart';

typedef HomeTabAppBarBuilder = Widget Function(BuildContext context);

class ContentCreationTab extends StatefulWidget {
  const ContentCreationTab({super.key});

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '콘텐츠 생성');
  }

  @override
  State<ContentCreationTab> createState() => _ContentCreationTabState();
}

class _ContentCreationTabState extends State<ContentCreationTab> {
  late SsossContentsEditDocument _document;

  @override
  void initState() {
    super.initState();
    _document = _sampleDocument();
  }

  SsossContentsEditDocument _sampleDocument() {
    return const SsossContentsEditDocument(
      blocks: [
        SsossContentsEditTextBlock(
          id: 'text-before',
          text: '매장 소개글 앞부분입니다. ',
        ),
        SsossContentsEditRecommendationBlock(
          item: SsossRecommendationCardItem(
            id: 'rec-photo',
            label: '추천 사진',
            title: '매장의 분위기가 담긴 사진을 추천해요.',
            description: '방문하고 싶은 느낌을 전달하는 데 효과적이에요',
            dismissible: true,
          ),
        ),
        SsossContentsEditTextBlock(
          id: 'text-after',
          text: ' 이어지는 본문을 자유롭게 수정해 보세요.',
        ),
        SsossContentsEditRecommendationBlock(
          item: SsossRecommendationCardItem(
            id: 'rec-photo-2',
            label: '추천 사진',
            title: '매장의 분위기가 담긴 사진을 추천해요.',
            description: '방문하고 싶은 느낌을 전달하는 데 효과적이에요',
            dismissible: true,
          ),
        ),
        SsossContentsEditTextBlock(
          id: 'text-after-2',
          text: ' 이어지는 본문을 자유롭게 수정해 보세요.',
        ),
      ],
    );
  }

  Future<void> _handleRecommendationDelete(
    SsossRecommendationCardItem item,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  void _handleRecommendationDeleted(SsossRecommendationCardItem item) {
    showSsossToast(
      context,
      title: '추천 안내가 삭제되었어요. (${item.label})',
    );
  }

  void _resetDocument() {
    setState(() => _document = _sampleDocument());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppText('콘텐츠 편집 카드 테스트'),
          const SizedBox(height: 8),
          AppText(
            'AppFlowy Editor 기반으로 블록을 자유롭게 배치할 수 있어요.\n'
            'Enter로 줄을 나누고, 추천 카드는 원하는 위치에 둔 뒤 백스페이스/X로 삭제할 수 있어요.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          SsossContentsEditCard(
            document: _document,
            maxLength: 200,
            hintText: '콘텐츠를 입력해주세요',
            onDocumentChanged: (document) {
              setState(() => _document = document);
            },
            onRecommendationDelete: _handleRecommendationDelete,
            onRecommendationDeleted: _handleRecommendationDeleted,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: _resetDocument,
            child: const AppText('샘플 데이터 초기화'),
          ),
          const SizedBox(height: 12),
          AppText(
            '현재 텍스트: ${_document.plainText}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '대시보드');
  }

  @override
  Widget build(BuildContext context) {
    return const _HomeTabPlaceholder(title: '대시보드');
  }
}

class PlaceDiagnosisTab extends StatelessWidget {
  const PlaceDiagnosisTab({super.key});

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '플레이스 진단');
  }

  @override
  Widget build(BuildContext context) {
    return const _HomeTabPlaceholder(title: '플레이스 진단');
  }
}

class MyPageTab extends StatelessWidget {
  const MyPageTab({super.key});

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '마이페이지');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton.icon(
              onPressed: () {
                context
                    .read<LoginBloc>()
                    .add(const LoginEvent.withdrawRequested());
              },
              icon: const Icon(Icons.link_off),
              label: const AppText('회원 탈퇴'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                context
                    .read<LoginBloc>()
                    .add(const LoginEvent.logoutRequested());
              },
              child: const AppText('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabPlaceholder extends StatelessWidget {
  const _HomeTabPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }
}
