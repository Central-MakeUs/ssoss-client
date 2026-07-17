import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';

import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_label_mapper.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_result_dummy.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/result/content_result_hashtag_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/result/content_result_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/result/content_result_summary.dart';

/// 단일 채널 결과 (스크롤 가능).
class ContentResultSingleBody extends StatelessWidget {
  const ContentResultSingleBody({
    required this.input,
    super.key,
  });

  final ContentCreateInput input;

  @override
  Widget build(BuildContext context) {
    final channel = ContentLabelMapper.orderedChannels(input.channels).first;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContentResultSummary(input: input),
          const SizedBox(height: 32),
          _ChannelResultSections(
            channel: channel,
            compact: false,
          ),
        ],
      ),
    );
  }
}

/// 다중 채널 결과 — 탭 + 좌우 스와이프.
class ContentResultMultiBody extends StatefulWidget {
  const ContentResultMultiBody({
    required this.input,
    super.key,
  });

  final ContentCreateInput input;

  @override
  State<ContentResultMultiBody> createState() => _ContentResultMultiBodyState();
}

class _ContentResultMultiBodyState extends State<ContentResultMultiBody> {
  late final List<UploadChannel> _orderedChannels =
      ContentLabelMapper.orderedChannels(widget.input.channels);
  late final PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() => _selectedIndex = index);
    unawaited(
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      ),
    );
  }

  void _onPageChanged(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: ContentResultSummary(input: widget.input),
        ),
        const SizedBox(height: 12),
        SsossTabBar(
          width: double.infinity,
          selectedIndex: _selectedIndex,
          items: [
            for (final channel in _orderedChannels)
              SsossTabItem(label: ContentLabelMapper.channel(channel)),
          ],
          onTap: _onTabTap,
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _orderedChannels.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: _ChannelResultSections(
                  channel: _orderedChannels[index],
                  compact: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ChannelResultSections extends StatelessWidget {
  const _ChannelResultSections({
    required this.channel,
    required this.compact,
  });

  final UploadChannel channel;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (channel == UploadChannel.blog) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ContentResultSection(
            title: '제목',
            content: ContentResultDummy.blogTitle,
          ),
          const SizedBox(height: 32),
          ContentResultSection(
            title: '본문',
            content: ContentResultDummy.bodyFor(channel, compact: compact),
          ),
          const SizedBox(height: 32),
          const ContentResultHashtagSection(
            hashtags: ContentResultDummy.blogHashtags,
          ),
        ],
      );
    }

    return ContentResultSection(
      title: '본문',
      content: ContentResultDummy.bodyFor(channel, compact: compact),
    );
  }
}
