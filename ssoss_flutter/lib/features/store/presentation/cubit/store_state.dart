import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';

class StoreState {
  const StoreState({
    required this.info,
    this.isLoading = false,
    this.isBootstrapped = false,
    this.isNetworkUnavailable = false,
    this.isSavingBasic = false,
    this.isSavingOperation = false,
    this.isSavingContent = false,
    this.hasCompletedOnboarding = false,
    this.errorMessage,
  });

  factory StoreState.initial() => StoreState(info: StoreInfo.empty());

  final StoreInfo info;
  final bool isLoading;
  final bool isBootstrapped;
  final bool isNetworkUnavailable;
  final bool isSavingBasic;
  final bool isSavingOperation;
  final bool isSavingContent;
  final bool hasCompletedOnboarding;
  final String? errorMessage;

  bool get shouldShowOnboarding => !hasCompletedOnboarding;

  StoreState copyWith({
    StoreInfo? info,
    bool? isLoading,
    bool? isBootstrapped,
    bool? isNetworkUnavailable,
    bool? isSavingBasic,
    bool? isSavingOperation,
    bool? isSavingContent,
    bool? hasCompletedOnboarding,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return StoreState(
      info: info ?? this.info,
      isLoading: isLoading ?? this.isLoading,
      isBootstrapped: isBootstrapped ?? this.isBootstrapped,
      isNetworkUnavailable: isNetworkUnavailable ?? this.isNetworkUnavailable,
      isSavingBasic: isSavingBasic ?? this.isSavingBasic,
      isSavingOperation: isSavingOperation ?? this.isSavingOperation,
      isSavingContent: isSavingContent ?? this.isSavingContent,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }
}
