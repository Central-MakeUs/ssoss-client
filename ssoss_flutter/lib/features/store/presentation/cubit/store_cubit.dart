import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/check_store_onboarding_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/complete_store_onboarding_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/get_my_store_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/save_store_basic_info_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/save_store_content_info_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/save_store_operation_info_usecase.dart';
import 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit({
    required GetMyStoreUseCase getMyStore,
    required SaveStoreBasicInfoUseCase saveBasicInfo,
    required SaveStoreOperationInfoUseCase saveOperationInfo,
    required SaveStoreContentInfoUseCase saveContentInfo,
    required CheckStoreOnboardingUseCase checkOnboarding,
    required CompleteStoreOnboardingUseCase completeOnboarding,
  })  : _getMyStore = getMyStore,
        _saveBasicInfo = saveBasicInfo,
        _saveOperationInfo = saveOperationInfo,
        _saveContentInfo = saveContentInfo,
        _checkOnboarding = checkOnboarding,
        _completeOnboarding = completeOnboarding,
        super(StoreState.initial());

  final GetMyStoreUseCase _getMyStore;
  final SaveStoreBasicInfoUseCase _saveBasicInfo;
  final SaveStoreOperationInfoUseCase _saveOperationInfo;
  final SaveStoreContentInfoUseCase _saveContentInfo;
  final CheckStoreOnboardingUseCase _checkOnboarding;
  final CompleteStoreOnboardingUseCase _completeOnboarding;

  Future<void> bootstrap() async {
    emit(state.copyWith(isLoading: true, clearErrorMessage: true));
    try {
      final info = await _getMyStore();
      final completed = await _checkOnboarding();
      emit(
        state.copyWith(
          info: info,
          hasCompletedOnboarding: completed,
          isLoading: false,
          isBootstrapped: true,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isBootstrapped: true,
          errorMessage: e.message,
        ),
      );
      rethrow;
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          isBootstrapped: true,
          errorMessage: '매장 정보를 불러오지 못했습니다.',
        ),
      );
      rethrow;
    }
  }

  Future<void> refresh() async {
    final info = await _getMyStore();
    emit(state.copyWith(info: info, clearErrorMessage: true));
  }

  Future<void> saveBasic(StoreBasicInfoInput input) async {
    emit(state.copyWith(isSavingBasic: true, clearErrorMessage: true));
    try {
      await _saveBasicInfo(input);
      final info = await _getMyStore();
      emit(state.copyWith(info: info, isSavingBasic: false));
    } on AppException catch (e) {
      emit(state.copyWith(isSavingBasic: false, errorMessage: e.message));
      rethrow;
    } catch (_) {
      emit(
        state.copyWith(
          isSavingBasic: false,
          errorMessage: '매장 기본 정보를 저장하지 못했습니다.',
        ),
      );
      rethrow;
    }
  }

  Future<void> saveOperation(StoreOperationInfoInput input) async {
    emit(state.copyWith(isSavingOperation: true, clearErrorMessage: true));
    try {
      await _saveOperationInfo(input);
      final info = await _getMyStore();
      emit(state.copyWith(info: info, isSavingOperation: false));
    } on AppException catch (e) {
      emit(state.copyWith(isSavingOperation: false, errorMessage: e.message));
      rethrow;
    } catch (_) {
      emit(
        state.copyWith(
          isSavingOperation: false,
          errorMessage: '매장 운영 정보를 저장하지 못했습니다.',
        ),
      );
      rethrow;
    }
  }

  Future<void> saveContent(StoreContentInfoInput input) async {
    emit(state.copyWith(isSavingContent: true, clearErrorMessage: true));
    try {
      await _saveContentInfo(input);
      final info = await _getMyStore();
      emit(state.copyWith(info: info, isSavingContent: false));
    } on AppException catch (e) {
      emit(state.copyWith(isSavingContent: false, errorMessage: e.message));
      rethrow;
    } catch (_) {
      emit(
        state.copyWith(
          isSavingContent: false,
          errorMessage: '매장 콘텐츠 정보를 저장하지 못했습니다.',
        ),
      );
      rethrow;
    }
  }

  Future<void> completeOnboarding() async {
    await _completeOnboarding();
    emit(state.copyWith(hasCompletedOnboarding: true));
  }

  void reset() {
    emit(StoreState.initial());
  }
}
