import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_info_components.dart';
import 'package:ssoss_flutter/core/constants/writing_tone.dart';

class StoreContentInfoForm extends StatelessWidget {
  const StoreContentInfoForm({
    required this.storeStrengthController,
    required this.prohibitedContentController,
    required this.keywords,
    required this.selectedTone,
    required this.onAddKeyword,
    required this.onRemoveKeyword,
    required this.onToneChanged,
    super.key,
  });

  final TextEditingController storeStrengthController;
  final TextEditingController prohibitedContentController;
  final List<String> keywords;
  final WritingTone selectedTone;
  final ValueChanged<String> onAddKeyword;
  final ValueChanged<String> onRemoveKeyword;
  final ValueChanged<WritingTone> onToneChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StoreInfoFormField(
          label: '매장 강점',
          controller: storeStrengthController,
          hintText: '입력해주세요',
          multiline: true,
        ),
        const SizedBox(height: 32),
        StoreInfoSectionTitle(
          title: '매장 키워드',
          helperText: SsossHashtagInput.defaultLimitHint,
        ),
        const SizedBox(height: 8),
        SsossHashtagInput(
          hashtags: keywords,
          hintText: 'ex) 디저트맛집',
          showHashPrefix: false,
          onAdd: onAddKeyword,
          onRemove: onRemoveKeyword,
        ),
        const SizedBox(height: 32),
        StoreInfoFormField(
          label: '금지 내용',
          controller: prohibitedContentController,
          hintText: '입력해주세요',
          multiline: true,
        ),
        const SizedBox(height: 32),
        const StoreInfoSectionTitle(title: '콘텐츠 작성 톤'),
        const SizedBox(height: 12),
        StoreContentToneList(
          selectedTone: selectedTone,
          onChanged: onToneChanged,
        ),
      ],
    );
  }
}
