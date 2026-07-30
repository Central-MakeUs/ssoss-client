import 'package:flutter/material.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// Ssoss light [ThemeData] composed from design tokens.
class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTextStyles.fontFamily,
      scaffoldBackgroundColor: AppColors.white,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary400,
        selectionColor: AppColors.primary200.withValues(alpha: 0.45),
        selectionHandleColor: AppColors.primary400,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary400,
      ),
    );
  }
}
