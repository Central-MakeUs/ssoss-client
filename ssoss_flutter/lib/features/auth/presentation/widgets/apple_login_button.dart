import 'dart:io';

import 'package:flutter/material.dart';

/// Apple 브랜드 로그인 버튼. iOS 에서만 노출한다.
class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({
    required this.onPressed,
    super.key,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return const SizedBox.shrink();
    }

    return Semantics(
      button: true,
      label: 'Apple로 로그인',
      child: SizedBox(
        height: 52,
        child: FilledButton(
          onPressed: enabled ? onPressed : null,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.black.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.apple, size: 24),
              SizedBox(width: 12),
              Text(
                'Apple로 로그인',
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
