import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/frequent_phrases/frequent_phrases_components.dart';

class FrequentPhrasesPage extends StatefulWidget {
  const FrequentPhrasesPage({super.key});

  static const String routeName = 'frequent-phrases';
  static const String routePath = '/frequent-phrases';

  @override
  State<FrequentPhrasesPage> createState() => _FrequentPhrasesPageState();
}

class _FrequentPhrasesPageState extends State<FrequentPhrasesPage> {
  final List<TextEditingController> _controllers = [
    TextEditingController(text: '오늘도 기다리고 있겠습니다 :)'),
  ];

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SsossAppBar.backWithLabel(
        title: '자주 쓰는 문구',
        label: '저장',
        onBack: () => Navigator.of(context).pop(),
        onDone: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 3, 16, 34),
          children: [
            for (var index = 0; index < _controllers.length; index++) ...[
              FrequentPhraseField(
                label: '문구 ${index + 1}',
                controller: _controllers[index],
              ),
              SizedBox(height: index == _controllers.length - 1 ? 16 : 36),
            ],
            FrequentPhraseAddButton(onTap: _addPhrase),
          ],
        ),
      ),
    );
  }

  void _addPhrase() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }
}
