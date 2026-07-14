import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/create_content_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_generating_cubit.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_generating_state.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/content_generating_view.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// 콘텐츠 생성 API 호출 중 화면.
class ContentGeneratingPage extends StatelessWidget {
  const ContentGeneratingPage({
    required this.input,
    super.key,
  });

  static const String routeName = 'content-generating';
  static const String routePath = '/content/create/generating';

  final ContentCreateInput input;

  void _exitToHome(BuildContext context) {
    context.read<ContentGeneratingCubit>().cancel();
    context.go(HomePage.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ContentGeneratingCubit(
          createContentUseCase: context.read<CreateContentUseCase>(),
          contentRepository: context.read<ContentRepository>(),
        );
        unawaited(cubit.start(input));
        return cubit;
      },
      child: BlocListener<ContentGeneratingCubit, ContentGeneratingState>(
        listenWhen: (previous, current) => current.maybeWhen(
          failure: (_) => true,
          orElse: () => false,
        ),
        listener: (context, state) {
          state.maybeWhen(
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
            orElse: () {},
          );
        },
        child: Builder(
          builder: (context) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, _) {
                if (didPop) {
                  return;
                }
                _exitToHome(context);
              },
              child: Scaffold(
                backgroundColor: AppColors.white,
                body: SafeArea(
                  child: Column(
                    children: [
                      SsossAppBar.exitOnly(
                        onExit: () => _exitToHome(context),
                      ),
                      const Expanded(
                        child: ContentGeneratingView(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
