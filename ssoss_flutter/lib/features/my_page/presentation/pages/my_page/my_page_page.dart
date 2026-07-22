import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/my_page/my_page_components.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/settings/settings_page.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/store_info_management/store_info_management_components.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/store_info_management/store_info_management_page.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/store_profile/store_profile_components.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/store_profile/store_profile_page.dart';

class MyPagePage extends StatelessWidget {
  const MyPagePage({super.key});

  static const String routeName = 'my-page';
  static const String routePath = '/my-page';

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '마이페이지');
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      const MyPageMenuItem(label: '공지사항'),
      MyPageMenuItem(
        label: '설정',
        onTap: () => _openSettings(context),
      ),
    ];
    final storeInfoItems = [
      StoreInfoManagementItem(
        title: '기본 정보',
        description: '매장명, 매장 유형, 주소, 매장 한 줄 소개',
        icon: Icons.storefront_outlined,
        onTap: () => _openStoreInfo(context, StoreInfoTab.basic),
      ),
      StoreInfoManagementItem(
        title: '운영 정보',
        description: '영업 시간, 대표 메뉴, 편의 시설',
        icon: Icons.access_time_rounded,
        onTap: () => _openStoreInfo(context, StoreInfoTab.operation),
      ),
      StoreInfoManagementItem(
        title: '콘텐츠 정보',
        description: '매장 강점, 자주 쓰는 키워드, 금지 내용 등',
        icon: Icons.article_outlined,
        onTap: () => _openStoreInfo(context, StoreInfoTab.content),
      ),
    ];

    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: buildAppBar(context),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 3, 16, 32),
                children: [
                  MyPageStoreSummaryCard(
                    storeName: '보니스커피',
                    storeType: '카페',
                    credit: 1000,
                    onStoreTap: () => _openStoreProfile(
                      context,
                      StoreProfileStatus.partial,
                    ),
                  ),
                  const SizedBox(height: 32),
                  StoreInfoManagementSection(items: storeInfoItems),
                  const SizedBox(height: 32),
                  MyPageMenuList(items: menuItems),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openStoreInfo(BuildContext context, StoreInfoTab initialTab) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => StoreInfoManagementPage(initialTab: initialTab),
        ),
      ),
    );
  }

  void _openStoreProfile(BuildContext context, StoreProfileStatus status) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => StoreProfilePage(status: status),
        ),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    unawaited(
      Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (_) => const SettingsPage(),
        ),
      ),
    );
  }
}
