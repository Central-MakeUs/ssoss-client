import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/content/data/mappers/content_create_api_mapper.dart';
import 'package:ssoss_flutter/features/content/data/models/generation_channel_result_model.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';

part 'generation_detail_model.freezed.dart';
part 'generation_detail_model.g.dart';

@freezed
abstract class GenerationDetailModel with _$GenerationDetailModel {
  const factory GenerationDetailModel({
    required int generationId,
    required String status,
    required String purpose,
    required String tone,
    required List<String> keywords,
    required List<GenerationChannelResultModel> results,
  }) = _GenerationDetailModel;

  factory GenerationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GenerationDetailModelFromJson(json);
}

extension GenerationDetailModelX on GenerationDetailModel {
  GenerationDetail toEntity() => GenerationDetail(
        generationId: generationId,
        status: ContentCreateApiMapper.statusFromApi(status),
        purpose: ContentCreateApiMapper.purposeFromApi(purpose),
        tone: ContentCreateApiMapper.toneFromApi(tone),
        keywords: keywords,
        results: results.map((r) => r.toEntity()).toList(growable: false),
      );
}
