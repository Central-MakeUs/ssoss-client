import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';

/// [CupertinoSliverRefreshControl.builder] 용 공용 당김 인디케이터.
Widget buildSsossPullRefreshIndicator(
  BuildContext context,
  RefreshIndicatorMode refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
) {
  if (pulledExtent < 28) {
    return const SizedBox.shrink();
  }

  final percentage =
      (pulledExtent / refreshTriggerPullDistance).clamp(0.0, 1.0);
  final isRefreshing = refreshState == RefreshIndicatorMode.refresh ||
      refreshState == RefreshIndicatorMode.done;

  return Center(
    child: SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: AppColors.primary400,
        value: isRefreshing ? null : percentage,
      ),
    ),
  );
}
