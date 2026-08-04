import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/new_style/presentation/cubit/new_style_detail_state.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';

class NewStyleDetailCubit extends Cubit<NewStyleDetailState> {
  NewStyleDetailCubit({required NewStyleDetailArgs args})
      : _args = args,
        super(const NewStyleDetailState());

  final NewStyleDetailArgs _args;

  NewStyleDetailArgs get args => _args;

  String get referenceRawText => _args.source.referenceRawText;

  void setHighlight(String value) {
    emit(state.copyWith(highlight: value));
  }

  void setForbidden(String value) {
    emit(state.copyWith(forbidden: value));
  }

  static const int maxKeywords = SsossHashtagLimits.maxCount;
  static const int maxKeywordLength = SsossHashtagLimits.maxLength;

  void addKeyword(String raw) {
    final text = SsossHashtagNormalizer.normalize(raw);
    if (text == null) {
      return;
    }
    if (state.keywords.contains(text)) {
      return;
    }
    if (state.keywords.length >= maxKeywords) {
      return;
    }
    emit(state.copyWith(keywords: [...state.keywords, text]));
  }

  void removeKeyword(String keyword) {
    emit(
      state.copyWith(
        keywords: state.keywords.where((k) => k != keyword).toList(),
      ),
    );
  }

  void togglePhotoGuide() {
    emit(state.copyWith(photoGuideEnabled: !state.photoGuideEnabled));
  }

  /// 추후 생성 API용 입력. 유효하지 않으면 `null`.
  ContentCreateInput? buildCreateInput() {
    final current = state;
    if (!current.canSubmit || _args.channels.isEmpty) {
      return null;
    }
    return ContentCreateInput(
      channels: List<UploadChannel>.unmodifiable(_args.channels),
      purpose: _args.source.purpose,
      tone: _args.source.tone,
      highlight: current.highlight,
      forbidden: current.forbidden.isEmpty ? null : current.forbidden,
      keywords: List<String>.unmodifiable(current.keywords),
      photoGuideEnabled: current.photoGuideEnabled,
      sourceContentId: _args.source.sourceContentId,
    );
  }
}
