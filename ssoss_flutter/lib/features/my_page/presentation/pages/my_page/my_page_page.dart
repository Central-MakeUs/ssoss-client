import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_balance_cubit.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_balance_state.dart';
import 'package:ssoss_flutter/features/credit/presentation/pages/credit_history/credit_history_page.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/my_page/my_page_components.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/saved_content_sources/saved_content_sources_page.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/settings/settings_page.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_info_components.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/store_info_management/store_info_management_page.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/store_profile/store_profile_page.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';

class MyPagePage extends StatefulWidget {
  const MyPagePage({super.key});

  static const String routeName = 'my-page';
  static const String routePath = '/my-page';

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '마이페이지');
  }

  @override
  State<MyPagePage> createState() => _MyPagePageState();
}

class _MyPagePageState extends State<MyPagePage> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<CreditBalanceCubit>().load());
  }

  @override
  Widget build(BuildContext context) {
    final storeInfo = context.watch<StoreCubit>().state.info;
    final storeName = storeInfo.basic.name?.trim().isNotEmpty == true
        ? storeInfo.basic.name!
        : '[매장명]';
    final storeType = storeInfo.basic.type?.label ?? '[매장유형]';
    final menuItems = [
      MyPageMenuItem(
        label: '저장한 콘텐츠 소스',
        onTap: () => _openSavedContentSources(context),
      ),
      // TODO: 공지사항 기능 추가 시 주석 해제
      // const MyPageMenuItem(label: '공지사항'),
      MyPageMenuItem(
        label: '설정',
        onTap: () => _openSettings(context),
      ),
    ];
    final storeInfoItems = [
      StoreInfoManagementItem(
        title: '기본 정보',
        description: '매장명, 매장 유형, 주소, 매장 한 줄 소개',
        iconPath: AppAssets.icStore,
        statusLabel: storeInfo.basic.status.label,
        isCompleted: storeInfo.basic.status.isCompleted,
        onTap: () => _openStoreInfo(context, StoreInfoTab.basic),
      ),
      StoreInfoManagementItem(
        title: '운영 정보',
        description: '영업 시간, 대표 메뉴, 편의 시설',
        iconPath: AppAssets.icTimeSquare,
        statusLabel: storeInfo.operation.status.label,
        isCompleted: storeInfo.operation.status.isCompleted,
        onTap: () => _openStoreInfo(context, StoreInfoTab.operation),
      ),
      StoreInfoManagementItem(
        title: '콘텐츠 정보',
        description: '매장 강점, 자주 쓰는 키워드, 금지 내용 등',
        iconPath: AppAssets.icDocument,
        statusLabel: storeInfo.content.status.label,
        isCompleted: storeInfo.content.status.isCompleted,
        onTap: () => _openStoreInfo(context, StoreInfoTab.content),
      ),
    ];

    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: MyPagePage.buildAppBar(context),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 3, 16, 32),
                children: [
                  BlocBuilder<CreditBalanceCubit, CreditBalanceState>(
                    builder: (context, creditState) {
                      return MyPageStoreSummaryCard(
                        storeName: storeName,
                        storeType: storeType,
                        description: storeInfo.basic.introduction,
                        credit: creditState.balance,
                        isCreditLoading: creditState.isLoading,
                        onStoreTap: () => _openStoreProfile(context),
                        onDetailTap: () => _openCreditHistory(context),
                      );
                    },
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

  void _openCreditHistory(BuildContext context) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => const CreditHistoryPage(),
        ),
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

  void _openStoreProfile(BuildContext context) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => const StoreProfilePage(),
        ),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => const SettingsPage(),
        ),
      ),
    );
  }

  void _openSavedContentSources(BuildContext context) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => const SavedContentSourcesPage(),
        ),
      ),
    );
  }
}
