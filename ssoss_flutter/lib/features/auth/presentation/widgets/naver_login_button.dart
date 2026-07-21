import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

/// 네이버 브랜드 로그인 버튼.
class NaverLoginButton extends StatelessWidget {
  const NaverLoginButton({
    required this.onPressed,
    super.key,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final bool enabled;

  /// 네이버 브랜드 그린 컬러.
  static const Color _naverGreen = Color(0xFF03C75A);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '네이버로 로그인',
      child: SizedBox(
        height: 52,
        child: FilledButton(
          onPressed: enabled ? onPressed : null,
          style: FilledButton.styleFrom(
            backgroundColor: _naverGreen,
            foregroundColor: Colors.white,
            disabledBackgroundColor: _naverGreen.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const AppText(
                  'N',
                  style: TextStyle(
                    color: _naverGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const AppText(
                '네이버로 로그인',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
