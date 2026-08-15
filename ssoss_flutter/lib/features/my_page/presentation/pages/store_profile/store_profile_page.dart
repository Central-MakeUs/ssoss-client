import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_info_components.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/store_info_management/store_info_management_page.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/store_profile/store_profile_components.dart';
import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';

class StoreProfilePage extends StatelessWidget {
  const StoreProfilePage({super.key});

  static const String routeName = 'store-profile';
  static const String routePath = '/store-profile';

  @override
  Widget build(BuildContext context) {
    final storeInfo = context.watch<StoreCubit>().state.info;
    final status = StoreProfileStatus.fromStoreInfo(storeInfo);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const _StoreProfileAppBar(),
            Expanded(
              child: status == StoreProfileStatus.empty
                  ? _StoreProfileEmptyBody(
                      onInputTap: () =>
                          _openStoreInfo(context, StoreInfoTab.basic),
                    )
                  : _StoreProfileInfoBody(
                      status: status,
                      storeInfo: storeInfo,
                      onBasicEditTap: () =>
                          _openStoreInfo(context, StoreInfoTab.basic),
                      onOperationEditTap: () =>
                          _openStoreInfo(context, StoreInfoTab.operation),
                      onContentEditTap: () =>
                          _openStoreInfo(context, StoreInfoTab.content),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _openStoreInfo(BuildContext context, StoreInfoTab initialTab) {
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => StoreInfoManagementPage(initialTab: initialTab),
        ),
      ),
    );
  }
}

class _StoreProfileAppBar extends StatelessWidget {
  const _StoreProfileAppBar();

  @override
  Widget build(BuildContext context) {
    return SsossAppBar.back(
      title: '매장 정보',
      onBack: () => Navigator.of(context).pop(),
    );
  }
}

class _StoreProfileEmptyBody extends StatelessWidget {
  const _StoreProfileEmptyBody({
    required this.onInputTap,
  });

  final VoidCallback onInputTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 34),
      children: [
        StoreProfileEmptyCard(onInputTap: onInputTap),
      ],
    );
  }
}

class _StoreProfileInfoBody extends StatelessWidget {
  const _StoreProfileInfoBody({
    required this.status,
    required this.storeInfo,
    required this.onBasicEditTap,
    required this.onOperationEditTap,
    required this.onContentEditTap,
  });

  final StoreProfileStatus status;
  final StoreInfo storeInfo;
  final VoidCallback onBasicEditTap;
  final VoidCallback onOperationEditTap;
  final VoidCallback onContentEditTap;

  @override
  Widget build(BuildContext context) {
    final isPartial = status == StoreProfileStatus.partial;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, isPartial ? 8 : 12, 16, 34),
      children: [
        if (isPartial) ...[
          const StoreProfileTipCard(),
          const SizedBox(height: 32),
        ],
        StoreProfileSection(
          title: '기본 정보',
          onEditTap: onBasicEditTap,
          children: [
            StoreBasicInfoBlock(
              status: status,
              info: storeInfo.basic,
            ),
          ],
        ),
        const SizedBox(height: 32),
        const StoreProfileDivider(),
        const SizedBox(height: 36),
        StoreProfileSection(
          title: '운영 정보',
          onEditTap: onOperationEditTap,
          children: [
            StoreOperationInfoBlock(
              status: status,
              info: storeInfo.operation,
            ),
          ],
        ),
        const SizedBox(height: 36),
        const StoreProfileDivider(),
        const SizedBox(height: 36),
        StoreProfileSection(
          title: '콘텐츠 정보',
          onEditTap: onContentEditTap,
          children: [
            StoreContentInfoBlock(
              status: status,
              info: storeInfo.content,
            ),
          ],
        ),
      ],
    );
  }
}
