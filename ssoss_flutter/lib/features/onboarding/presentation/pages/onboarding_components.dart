import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
    required this.imageBorderColor,
    this.backgroundGradient,
    this.copyWidth = 309,
    this.copyTopOffset = 6,
    this.imageTop = 170,
    this.imageHeightRatio = 0.72,
    this.imageSequencePaths = const [],
  });

  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;
  final Color imageBorderColor;
  final Gradient? backgroundGradient;
  final double copyWidth;
  final double copyTopOffset;
  final double imageTop;
  final double imageHeightRatio;
  final List<String> imageSequencePaths;

  List<String> get previewImagePaths {
    if (imageSequencePaths.isNotEmpty) {
      return imageSequencePaths;
    }
    return [imagePath];
  }
}

class OnboardingPages {
  const OnboardingPages._();

  static const items = [
    OnboardingPageData(
      title: '매장 홍보글, 더 이상 고민하지 마세요',
      description: '쏘쓰가 매장과 메뉴 정보를 바탕으로\n홍보 콘텐츠를 빠르게 만들어드려요',
      imagePath: AppAssets.imgOnboardingIntroHome,
      backgroundColor: AppColors.primary50,
      imageBorderColor: AppColors.primary100,
      backgroundGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primary100,
          AppColors.primary50,
        ],
        stops: [0, 0.64],
      ),
      copyWidth: 241,
      imageTop: 171,
    ),
    OnboardingPageData(
      title: '필요한 내용만\n간단히 알려주세요',
      description: '소개할 메뉴와 강조할 내용을 입력하고\n원치 않는 표현은 제외해보세요.',
      imagePath: AppAssets.imgOnboardingContentInput,
      backgroundColor: AppColors.neutral50,
      imageBorderColor: AppColors.neutral100,
      imageTop: 170,
      imageHeightRatio: 0.84,
      imageSequencePaths: [
        AppAssets.imgOnboardingContentInput,
        AppAssets.imgOnboardingContentInputFilled,
        AppAssets.imgOnboardingContentInputBlocked,
      ],
    ),
    OnboardingPageData(
      title: '제목부터 해시태그까지 한 번에',
      description: '입력한 내용을 바탕으로\n제목, 본문, 해시태그를 만들어드려요.',
      imagePath: AppAssets.imgOnboardingResultEmpty,
      backgroundColor: AppColors.neutral50,
      imageBorderColor: AppColors.neutral100,
      imageTop: 170,
      imageHeightRatio: 0.8,
      imageSequencePaths: [
        AppAssets.imgOnboardingResultEmpty,
        AppAssets.imgOnboardingResultWriting,
        AppAssets.imgOnboardingResultBody,
        AppAssets.imgOnboardingResultComplete,
      ],
    ),
    OnboardingPageData(
      title: '우리 가게에 맞게\n자유롭게 수정하세요',
      description: '생성된 초안을 취향에 맞게 편집해\n우리 가게만의 콘텐츠를 완성해보세요',
      imagePath: AppAssets.imgOnboardingEditStart,
      backgroundColor: AppColors.neutral50,
      imageBorderColor: AppColors.neutral100,
      imageTop: 170,
      imageHeightRatio: 0.8,
      imageSequencePaths: [
        AppAssets.imgOnboardingEditStart,
        AppAssets.imgOnboardingEditTitle,
        AppAssets.imgOnboardingEditBody,
        AppAssets.imgOnboardingEditComplete,
      ],
    ),
    OnboardingPageData(
      title: '복사 한 번으로\n업로드 준비 완료!',
      description: '복사한 콘텐츠를 원하는 SNS에\n바로 업로드해보세요.',
      imagePath: AppAssets.imgOnboardingCopyReady,
      backgroundColor: AppColors.neutral50,
      imageBorderColor: AppColors.neutral100,
      copyTopOffset: 0,
      imageTop: 171,
      imageHeightRatio: 0.8,
      imageSequencePaths: [
        AppAssets.imgOnboardingCopyReady,
        AppAssets.imgOnboardingCopyDone,
      ],
    ),
  ];
}

class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    required this.data,
    required this.topBar,
    required this.pageView,
    required this.bottomBar,
    super.key,
  });

  final OnboardingPageData data;
  final Widget topBar;
  final Widget pageView;
  final Widget bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: data.backgroundColor,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: data.backgroundColor,
          gradient: data.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              topBar,
              Expanded(child: pageView),
              bottomBar,
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingTopBar extends StatelessWidget {
  const OnboardingTopBar({
    required this.showBackButton,
    required this.onBack,
    super.key,
  });

  final bool showBackButton;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              height: 58,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeOutCubic,
                child: showBackButton
                    ? GestureDetector(
                        key: const ValueKey('onboarding-back'),
                        onTap: onBack,
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.icChevronLeft,
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                              AppColors.neutral400,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(
                        key: ValueKey('onboarding-back-empty'),
                        width: 32,
                        height: 58,
                      ),
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            const SizedBox(width: 32, height: 58),
          ],
        ),
      ),
    );
  }
}

class OnboardingAnimatedPage extends StatefulWidget {
  const OnboardingAnimatedPage({
    required this.data,
    required this.isActive,
    super.key,
  });

  final OnboardingPageData data;
  final bool isActive;

  @override
  State<OnboardingAnimatedPage> createState() => _OnboardingAnimatedPageState();
}

class _OnboardingAnimatedPageState extends State<OnboardingAnimatedPage> {
  @override
  Widget build(BuildContext context) {
    return OnboardingPageLayout(
      data: widget.data,
      copy: OnboardingCopy(data: widget.data),
      preview: OnboardingPreviewImage(
        data: widget.data,
        isActive: widget.isActive,
      ),
    );
  }
}

class OnboardingPageLayout extends StatelessWidget {
  const OnboardingPageLayout({
    required this.data,
    required this.copy,
    required this.preview,
    super.key,
  });

  final OnboardingPageData data;
  final Widget copy;
  final Widget preview;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: data.backgroundColor,
        gradient: data.backgroundGradient,
      ),
      child: Stack(
        children: [
          Positioned.fill(child: preview),
          Padding(
            padding: EdgeInsets.fromLTRB(24, data.copyTopOffset, 24, 0),
            child: copy,
          ),
        ],
      ),
    );
  }
}

class OnboardingCopy extends StatelessWidget {
  const OnboardingCopy({
    required this.data,
    super.key,
  });

  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: data.copyWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            data.title,
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 8),
          AppText(
            data.description,
            style: AppTextStyles.b4.copyWith(color: AppColors.neutral500),
          ),
        ],
      ),
    );
  }
}

class OnboardingPreviewImage extends StatelessWidget {
  const OnboardingPreviewImage({
    required this.data,
    required this.isActive,
    super.key,
  });

  final OnboardingPageData data;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    if (data.imagePath == AppAssets.imgOnboardingResultEmpty) {
      return OnboardingResultPreview(isActive: isActive);
    }
    if (data.imagePath == AppAssets.imgOnboardingEditStart) {
      return OnboardingEditPreview(isActive: isActive);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight =
            (constraints.maxHeight * data.imageHeightRatio).clamp(360.0, 457.0);
        final isCopyPreview =
            data.imagePath == AppAssets.imgOnboardingCopyReady;
        final imageWidth =
            imageHeight * (isCopyPreview ? 223 / 469 : 211 / 457);
        final image = data.imagePath == AppAssets.imgOnboardingContentInput
            ? Image.asset(
                data.imagePath,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              )
            : OnboardingImageSequence(
                imagePaths: data.previewImagePaths,
                width: imageWidth,
                height: imageHeight,
                isActive: isActive,
                fit: isCopyPreview ? BoxFit.fill : BoxFit.cover,
              );

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: data.imageTop,
              child: isCopyPreview
                  ? image
                  : Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: data.imageBorderColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: image,
                      ),
                    ),
            ),
            if (data.imagePath == AppAssets.imgOnboardingContentInput)
              OnboardingContentInputOverlay(isActive: isActive),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 112,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      data.backgroundColor.withValues(alpha: 0),
                      data.backgroundColor,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OnboardingResultPreview extends StatefulWidget {
  const OnboardingResultPreview({
    required this.isActive,
    super.key,
  });

  final bool isActive;

  @override
  State<OnboardingResultPreview> createState() =>
      _OnboardingResultPreviewState();
}

class _OnboardingResultPreviewState extends State<OnboardingResultPreview> {
  static const Duration _frameDuration = Duration(milliseconds: 1100);
  static const Duration _transitionDuration = Duration(milliseconds: 520);
  static const List<_OnboardingResultFrame> _frames = [
    _OnboardingResultFrame(
      imagePath: AppAssets.imgOnboardingResultEmpty,
      top: 170,
    ),
    _OnboardingResultFrame(
      imagePath: AppAssets.imgOnboardingResultWriting,
      top: 38,
    ),
    _OnboardingResultFrame(
      imagePath: AppAssets.imgOnboardingResultBody,
      top: 170,
    ),
    _OnboardingResultFrame(
      imagePath: AppAssets.imgOnboardingResultComplete,
      top: 19,
    ),
  ];

  Timer? _timer;
  int _frameIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingResultPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isActive && widget.isActive) {
      _frameIndex = 0;
      _startTimer();
      return;
    }
    if (oldWidget.isActive && !widget.isActive) {
      _timer?.cancel();
      _frameIndex = 0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(_frameDuration, (_) {
      if (!mounted) {
        return;
      }
      setState(() => _frameIndex = (_frameIndex + 1) % _frames.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final frame = _frames[_frameIndex];

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 170,
          left: 0,
          right: 0,
          bottom: 0,
          child: ClipRect(
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                AnimatedPositioned(
                  duration: _transitionDuration,
                  curve: Curves.easeInOutCubic,
                  top: frame.top - 170,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 260),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeOutCubic,
                    child: Image.asset(
                      frame.imagePath,
                      key: ValueKey(frame.imagePath),
                      width: 223,
                      height: 522,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 170,
          height: 36,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.neutral50,
                    AppColors.neutral50.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 112,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.neutral50.withValues(alpha: 0),
                  AppColors.neutral50,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingResultFrame {
  const _OnboardingResultFrame({
    required this.imagePath,
    required this.top,
  });

  final String imagePath;
  final double top;
}

class OnboardingEditPreview extends StatefulWidget {
  const OnboardingEditPreview({
    required this.isActive,
    super.key,
  });

  final bool isActive;

  @override
  State<OnboardingEditPreview> createState() => _OnboardingEditPreviewState();
}

class _OnboardingEditPreviewState extends State<OnboardingEditPreview> {
  static const Duration _frameDuration = Duration(milliseconds: 1000);
  static const Duration _transitionDuration = Duration(milliseconds: 260);
  static const List<String> _imagePaths = [
    AppAssets.imgOnboardingEditStart,
    AppAssets.imgOnboardingEditTitle,
    AppAssets.imgOnboardingEditBody,
    AppAssets.imgOnboardingEditComplete,
  ];

  Timer? _timer;
  int _frameIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingEditPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isActive && widget.isActive) {
      _frameIndex = 0;
      _startTimer();
      return;
    }
    if (oldWidget.isActive && !widget.isActive) {
      _timer?.cancel();
      _frameIndex = 0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(_frameDuration, (_) {
      if (!mounted) {
        return;
      }
      setState(() => _frameIndex = (_frameIndex + 1) % _imagePaths.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = _imagePaths[_frameIndex];
    final showTouchPoint = _frameIndex == 1;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 170,
          child: AnimatedSwitcher(
            duration: _transitionDuration,
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeOutCubic,
            child: Image.asset(
              imagePath,
              key: ValueKey(imagePath),
              width: 223,
              height: 469,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        Positioned(
          left: 272,
          top: 298,
          child: AnimatedOpacity(
            duration: _transitionDuration,
            curve: Curves.easeOutCubic,
            opacity: showTouchPoint ? 1 : 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0x7FFFE1D3),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 112,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.neutral50.withValues(alpha: 0),
                  AppColors.neutral50,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingContentInputOverlay extends StatefulWidget {
  const OnboardingContentInputOverlay({
    required this.isActive,
    super.key,
  });

  final bool isActive;

  @override
  State<OnboardingContentInputOverlay> createState() =>
      _OnboardingContentInputOverlayState();
}

class _OnboardingContentInputOverlayState
    extends State<OnboardingContentInputOverlay> {
  static const Duration _frameDuration = Duration(milliseconds: 1200);
  static const Duration _transitionDuration = Duration(milliseconds: 360);

  Timer? _timer;
  int _frameIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingContentInputOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isActive && widget.isActive) {
      _frameIndex = 0;
      _startTimer();
      return;
    }
    if (oldWidget.isActive && !widget.isActive) {
      _timer?.cancel();
      _frameIndex = 0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(_frameDuration, (_) {
      if (!mounted) {
        return;
      }
      setState(() => _frameIndex = (_frameIndex + 1) % 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasHighlight = _frameIndex >= 1;
    final hasForbidden = _frameIndex >= 2;

    return Positioned(
      top: 226,
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedContainer(
          duration: _transitionDuration,
          curve: Curves.easeOutCubic,
          width: hasHighlight ? 255 : 249,
          padding: EdgeInsets.all(hasHighlight ? 11 : 10.5),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(hasHighlight ? 16.4 : 16),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.2),
                blurRadius: hasHighlight ? 13 : 12.5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _OnboardingOverlayField(
                label: '강조 내용',
                isRequired: true,
                text: hasHighlight
                    ? '신메뉴 수박주스를 소개하고 당도 높은 수박을 사용했다는 점을 강조해줘'
                    : null,
              ),
              AnimatedContainer(
                duration: _transitionDuration,
                curve: Curves.easeOutCubic,
                height: hasHighlight ? 24.5 : 24,
              ),
              _OnboardingOverlayField(
                label: '금지 내용',
                optionalLabel: '선택',
                text: hasForbidden ? '이모티콘은 사용하지 말고 과장된 표현은 사용하지 말아줘' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingOverlayField extends StatelessWidget {
  const _OnboardingOverlayField({
    required this.label,
    this.isRequired = false,
    this.optionalLabel,
    this.text,
  });

  final String label;
  final bool isRequired;
  final String? optionalLabel;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final hasText = text != null && text!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              label,
              style: AppTextStyles.h8.copyWith(
                color: AppColors.black.withValues(alpha: 0.2),
                fontSize: 12,
              ),
            ),
            if (isRequired)
              AppText(
                '*',
                style: AppTextStyles.h8.copyWith(
                  color: AppColors.primary600,
                  fontSize: 12,
                ),
              ),
            if (optionalLabel != null) ...[
              const SizedBox(width: 5),
              AppText(
                optionalLabel!,
                style: AppTextStyles.b5.copyWith(
                  color: AppColors.neutral400,
                  fontSize: 8,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 9.5, vertical: 6.8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5.4),
            border: Border.all(color: AppColors.neutral200, width: 0.7),
          ),
          alignment: Alignment.topLeft,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 240),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeOutCubic,
            child: hasText
                ? AppText(
                    key: ValueKey(text),
                    text!,
                    style: AppTextStyles.b5.copyWith(
                      color: AppColors.neutral800,
                      fontSize: 11,
                    ),
                  )
                : const SizedBox(
                    key: ValueKey('empty'),
                    width: double.infinity,
                  ),
          ),
        ),
      ],
    );
  }
}

class OnboardingImageSequence extends StatefulWidget {
  const OnboardingImageSequence({
    required this.imagePaths,
    required this.width,
    required this.height,
    required this.isActive,
    super.key,
    this.fit = BoxFit.cover,
    this.repeat = true,
  });

  final List<String> imagePaths;
  final double width;
  final double height;
  final bool isActive;
  final BoxFit fit;
  final bool repeat;

  @override
  State<OnboardingImageSequence> createState() =>
      _OnboardingImageSequenceState();
}

class _OnboardingImageSequenceState extends State<OnboardingImageSequence> {
  static const Duration _frameDuration = Duration(milliseconds: 920);
  static const Duration _transitionDuration = Duration(milliseconds: 420);

  Timer? _timer;
  int _frameIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingImageSequence oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePaths != widget.imagePaths) {
      _frameIndex = 0;
    }
    if (!oldWidget.isActive && widget.isActive) {
      _frameIndex = 0;
      _startTimer();
      return;
    }
    if (oldWidget.isActive && !widget.isActive) {
      _timer?.cancel();
      _frameIndex = 0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    if (widget.imagePaths.length < 2) {
      return;
    }
    _timer = Timer.periodic(_frameDuration, (_) {
      if (!mounted) {
        return;
      }
      if (!widget.repeat && _frameIndex == widget.imagePaths.length - 1) {
        _timer?.cancel();
        return;
      }
      setState(() {
        final nextFrameIndex = _frameIndex + 1;
        _frameIndex = widget.repeat
            ? nextFrameIndex % widget.imagePaths.length
            : nextFrameIndex.clamp(0, widget.imagePaths.length - 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = widget.imagePaths[_frameIndex];
    final isSvg = imagePath.toLowerCase().endsWith('.svg');

    return AnimatedSwitcher(
      duration: _transitionDuration,
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: isSvg
          ? SvgPicture.asset(
              imagePath,
              key: ValueKey(imagePath),
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
            )
          : Image.asset(
              imagePath,
              key: ValueKey(imagePath),
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              filterQuality: FilterQuality.high,
            ),
    );
  }
}

class OnboardingBottomBar extends StatelessWidget {
  const OnboardingBottomBar({
    required this.currentIndex,
    required this.indicatorCount,
    required this.primaryLabel,
    required this.showSkipButton,
    required this.onPrimaryTap,
    required this.onSkipTap,
    super.key,
    this.isLoading = false,
  });

  final int currentIndex;
  final int indicatorCount;
  final String primaryLabel;
  final bool showSkipButton;
  final VoidCallback onPrimaryTap;
  final VoidCallback onSkipTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.neutral50,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeOutCubic,
                child: showSkipButton
                    ? Padding(
                        key: const ValueKey('onboarding-dots'),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: OnboardingDots(
                          currentIndex: currentIndex,
                          count: indicatorCount,
                        ),
                      )
                    : const SizedBox(
                        key: ValueKey('onboarding-dots-empty'),
                        height: 0,
                      ),
              ),
              SsossButton(
                label: primaryLabel,
                size: SsossButtonSize.large,
                type: SsossButtonType.primary,
                width: double.infinity,
                isLoading: isLoading,
                onPressed: onPrimaryTap,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: showSkipButton
                    ? SsossButton(
                        label: '건너뛰기',
                        size: SsossButtonSize.large,
                        type: SsossButtonType.ghost,
                        width: double.infinity,
                        onPressed: onSkipTap,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingActionBar extends StatelessWidget {
  const OnboardingActionBar({
    required this.primaryLabel,
    required this.showSkipButton,
    required this.onPrimaryTap,
    required this.onSkipTap,
    super.key,
    this.isLoading = false,
  });

  final String primaryLabel;
  final bool showSkipButton;
  final VoidCallback onPrimaryTap;
  final VoidCallback onSkipTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.neutral50,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SsossButton(
                label: primaryLabel,
                size: SsossButtonSize.large,
                type: SsossButtonType.primary,
                width: double.infinity,
                isLoading: isLoading,
                onPressed: onPrimaryTap,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: showSkipButton
                    ? SsossButton(
                        label: '건너뛰기',
                        size: SsossButtonSize.large,
                        type: SsossButtonType.ghost,
                        width: double.infinity,
                        onPressed: onSkipTap,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingDots extends StatelessWidget {
  const OnboardingDots({
    required this.currentIndex,
    required this.count,
    super.key,
  });

  final int currentIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < count; index++) ...[
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            width: index == currentIndex ? 12 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: index == currentIndex
                  ? AppColors.primary400
                  : AppColors.neutral200,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          if (index != count - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}
