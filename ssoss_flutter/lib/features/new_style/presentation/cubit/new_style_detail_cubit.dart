import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/style_reuse_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/new_style/presentation/cubit/new_style_detail_state.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';

class NewStyleDetailCubit extends Cubit<NewStyleDetailState> {
  NewStyleDetailCubit({
    required NewStyleArgs args,
    ContentCreateInput? restoredInput,
  })  : _args = args,
        super(
          NewStyleDetailState(
            highlight: restoredInput?.highlight ?? '',
            forbidden: restoredInput?.forbidden ?? '',
            keywords: restoredInput?.keywords ?? const [],
            photoGuideEnabled: restoredInput?.photoGuideEnabled ?? false,
          ),
        );

  final NewStyleArgs _args;

  NewStyleArgs get args => _args;

  String get referenceRawText => _args.referenceRawText;

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

  ContentCreateInput? buildCreateInput() {
    final current = state;
    if (!current.canSubmit) {
      return null;
    }
    return ContentCreateInput(
      channels: List<UploadChannel>.unmodifiable([_args.referenceChannel]),
      purpose: _args.purpose,
      tone: _args.tone,
      highlight: current.highlight,
      forbidden: current.forbidden.isEmpty ? null : current.forbidden,
      keywords: List<String>.unmodifiable(current.keywords),
      photoGuideEnabled: current.photoGuideEnabled,
      sourceContentId: _args.sourceContentId,
    );
  }

  StyleReuseInput? buildStyleReuseInput() {
    final input = buildCreateInput();
    if (input == null) {
      return null;
    }
    final contentId = int.tryParse(_args.sourceContentId);
    if (contentId == null) {
      return null;
    }
    return StyleReuseInput(
      contentId: contentId,
      contentChannelId: _args.contentChannelId,
      highlight: input.highlight,
      forbidden: input.forbidden,
      keywords: input.keywords,
      photoGuideEnabled: input.photoGuideEnabled,
    );
  }
}
