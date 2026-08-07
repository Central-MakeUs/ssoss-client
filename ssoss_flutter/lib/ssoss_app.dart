import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common/widgets/modal/ssoss_modal.dart';
import 'core/colors/app_colors.dart';
import 'core/config/app_config.dart';
import 'core/constants/app_urls.dart';
import 'core/network/network_providers.dart';
import 'core/network/session_expired_notifier.dart';
import 'core/theme/app_theme.dart';
import 'features/app_version/domain/usecases/check_app_version_usecase.dart';
import 'features/app_version/presentation/app_version_providers.dart';
import 'features/app_version/presentation/cubit/app_version_cubit.dart';
import 'features/app_version/presentation/cubit/app_version_state.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_with_apple_usecase.dart';
import 'features/auth/domain/usecases/login_with_naver_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/restore_session_usecase.dart';
import 'features/auth/domain/usecases/withdraw_usecase.dart';
import 'features/auth/presentation/auth_providers.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/auth/presentation/bloc/login_event.dart';
import 'features/auth/presentation/bloc/login_state.dart';
import 'features/content/presentation/content_providers.dart';
import 'features/credit/domain/usecases/get_credit_balance_usecase.dart';
import 'features/credit/presentation/credit_providers.dart';
import 'features/credit/presentation/cubit/credit_balance_cubit.dart';
import 'features/hashtag/presentation/hashtag_providers.dart';
import 'features/store/domain/usecases/check_store_onboarding_usecase.dart';
import 'features/store/domain/usecases/complete_store_onboarding_usecase.dart';
import 'features/store/domain/usecases/get_my_store_usecase.dart';
import 'features/store/domain/usecases/save_store_basic_info_usecase.dart';
import 'features/store/domain/usecases/save_store_content_info_usecase.dart';
import 'features/store/domain/usecases/save_store_operation_info_usecase.dart';
import 'features/store/presentation/cubit/store_cubit.dart';
import 'features/store/presentation/store_providers.dart';
import 'router/app_router.dart';

class SsossApp extends StatefulWidget {
  const SsossApp({super.key});

  @override
  State<SsossApp> createState() => _SsossAppState();
}

class _SsossAppState extends State<SsossApp> {
  static const SystemUiOverlayStyle _systemUiOverlayStyle =
      SystemUiOverlayStyle(
    statusBarColor: AppColors.white,
    // iOS: light = 어두운(검정) 상태바 글자, Android: dark 아이콘
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: AppColors.white,
  );

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  late final GoRouter _router;
  bool _isSessionExpiredModalVisible = false;
  bool _isForceUpdateModalVisible = false;
  bool _didRequestSessionRestore = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(_systemUiOverlayStyle);
    _router = createAppRouter(
      context.read<LoginBloc>(),
      storeCubit: context.read<StoreCubit>(),
      navigatorKey: _rootNavigatorKey,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(context.read<AppVersionCubit>().check());
    });
  }

  BuildContext? get _navigatorContext => _rootNavigatorKey.currentContext;

  Future<void> _showSessionExpiredModal() async {
    if (_isSessionExpiredModalVisible) return;
    final dialogContext = _navigatorContext;
    if (dialogContext == null || !dialogContext.mounted) {
      // Navigator 준비 전이면 다음 프레임에 재시도한다.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          unawaited(_showSessionExpiredModal());
        }
      });
      return;
    }

    _isSessionExpiredModalVisible = true;

    try {
      await showSsossModal(
        dialogContext,
        title: '세션이 만료되었습니다. 다시 로그인해 주세요.',
        showButtonIcons: false,
        showSecondaryButton: false,
        barrierDismissible: false,
        primaryButtonLabel: '확인',
        onPrimaryPressed: () {},
      );
    } finally {
      _isSessionExpiredModalVisible = false;
      if (mounted) {
        context.read<LoginBloc>().add(
              const LoginEvent.sessionExpiredAcknowledged(),
            );
      }
    }
  }

  Future<void> _showForceUpdateModal() async {
    if (_isForceUpdateModalVisible) return;
    final dialogContext = _navigatorContext;
    if (dialogContext == null || !dialogContext.mounted) {
      // Navigator 준비 전이면 다음 프레임에 재시도한다.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          unawaited(_showForceUpdateModal());
        }
      });
      return;
    }

    _isForceUpdateModalVisible = true;

    await showSsossModal(
      dialogContext,
      title: '업데이트 필요',
      message: '원활한 서비스 이용을 위해 최신 버전으로 업데이트해 주세요.',
      primaryButtonLabel: '업데이트 하기',
      showButtonIcons: false,
      showCloseButton: false,
      showSecondaryButton: false,
      dismissOnPrimaryPressed: false,
      barrierDismissible: false,
      onPrimaryPressed: () {
        unawaited(_openStore());
      },
    );
  }

  Future<void> _openStore() async {
    final url = Platform.isIOS ? AppUrls.iosAppStore : AppUrls.androidPlayStore;
    await launchUrl(Uri.parse(url));
  }

  void _requestSessionRestoreIfNeeded() {
    if (_didRequestSessionRestore) return;
    _didRequestSessionRestore = true;
    context.read<LoginBloc>().add(const LoginEvent.sessionRestoreRequested());
  }

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return MaterialApp.router(
      title: config.flavor.displayName,
      theme: AppTheme.light,
      routerConfig: _router,
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: _systemUiOverlayStyle,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: MultiBlocListener(
              listeners: [
                BlocListener<AppVersionCubit, AppVersionState>(
                  listenWhen: (previous, current) =>
                      current is AppVersionUpdateRequired ||
                      current is AppVersionAllowed,
                  listener: (context, state) {
                    if (state is AppVersionUpdateRequired) {
                      unawaited(_showForceUpdateModal());
                      return;
                    }
                    if (state is AppVersionAllowed) {
                      _requestSessionRestoreIfNeeded();
                    }
                  },
                ),
                BlocListener<LoginBloc, LoginState>(
                  listenWhen: (previous, current) =>
                      current is LoginAuthenticated ||
                      current is LoginUnauthenticated ||
                      current is LoginSessionExpired,
                  listener: (context, state) {
                    if (state is LoginAuthenticated) {
                      unawaited(
                        context.read<StoreCubit>().bootstrap().catchError(
                              (_) {},
                            ),
                      );
                      return;
                    }
                    context.read<StoreCubit>().reset();
                    if (state is LoginSessionExpired) {
                      unawaited(_showSessionExpiredModal());
                    }
                  },
                ),
              ],
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
      // 선택 툴바(잘라내기/복사 등) 라벨은 Material/Cupertino 로컬라이제이션을
      // 사용한다. AppFlowy 로케일만 두면 한국어가 빠져 영어로 표시된다.
      locale: const Locale('ko'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
      ],
    );
  }
}

class SsossAppScope extends StatelessWidget {
  const SsossAppScope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...NetworkProviders.build(),
        ...AuthProviders.build(),
        ...ContentProviders.build(),
        ...CreditProviders.build(),
        ...HashtagProviders.build(),
        ...StoreProviders.build(),
        ...AppVersionProviders.build(),
      ],
      child: BlocProvider<LoginBloc>(
        create: (context) {
          final repository = context.read<AuthRepository>();
          return LoginBloc(
            loginWithNaver: LoginWithNaverUseCase(repository),
            loginWithApple: LoginWithAppleUseCase(repository),
            withdraw: WithdrawUseCase(repository),
            logout: LogoutUseCase(repository),
            restoreSession: RestoreSessionUseCase(repository),
            sessionExpiredNotifier: context.read<SessionExpiredNotifier>(),
          );
        },
        child: BlocProvider<AppVersionCubit>(
          create: (context) => AppVersionCubit(
            checkAppVersion: context.read<CheckAppVersionUseCase>(),
          ),
          child: BlocProvider<CreditBalanceCubit>(
            create: (context) => CreditBalanceCubit(
              getCreditBalance: context.read<GetCreditBalanceUseCase>(),
            ),
            child: BlocProvider<StoreCubit>(
              create: (context) => StoreCubit(
                getMyStore: context.read<GetMyStoreUseCase>(),
                saveBasicInfo: context.read<SaveStoreBasicInfoUseCase>(),
                saveOperationInfo:
                    context.read<SaveStoreOperationInfoUseCase>(),
                saveContentInfo: context.read<SaveStoreContentInfoUseCase>(),
                checkOnboarding: context.read<CheckStoreOnboardingUseCase>(),
                completeOnboarding:
                    context.read<CompleteStoreOnboardingUseCase>(),
              ),
              child: const SsossApp(),
            ),
          ),
        ),
      ),
    );
  }
}
