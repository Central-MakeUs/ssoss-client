import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';

/// 콜드 스타트 세션 검증 중 표시하는 스플래시 화면.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String routeName = 'splash';
  static const String routePath = '/';

  /// Figma 스플래시 그라데이션 (221.75°, primary300 → primary500).
  static const LinearGradient _backgroundGradient = LinearGradient(
    begin: Alignment(0.67, -0.75),
    end: Alignment(-0.67, 0.75),
    colors: <Color>[
      AppColors.primary300,
      AppColors.primary500,
    ],
    stops: <double>[0.003, 0.65],
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(gradient: _backgroundGradient),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/app_icon_white.svg',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
