import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_edit_cubit.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_channel_merge.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_result.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';

void main() {
  ContentEditCubit bodyCubit(
    String initialBody, {
    List<String> initialHashtags = const [],
  }) {
    return ContentEditCubit(
      args: ContentEditArgs(
        channel: UploadChannel.blog,
        target: ContentEditTarget.body,
        initialBody: initialBody,
        initialHashtags: initialHashtags,
      ),
    );
  }

  test('newline-only edit marks dirty and keeps newlines on submit', () {
    final cubit = bodyCubit('Hello World');

    expect(cubit.canSubmit, isFalse);

    cubit.updateDocument(
      SsossContentsEditDocument.fromPlainText(plainText: 'Hello\nWorld'),
    );

    expect(cubit.state.isDirty, isTrue);
    expect(cubit.canSubmit, isTrue);
    expect(cubit.buildResult()?.body, 'Hello\nWorld');
  });

  test('text edit with newlines keeps line breaks in result body', () {
    final cubit = bodyCubit('원문 본문입니다');

    cubit.updateDocument(
      SsossContentsEditDocument.fromPlainText(
        plainText: '수정된\n본문입니다',
      ),
    );

    expect(cubit.buildResult()?.body, '수정된\n본문입니다');
  });

  test('blog body hashtag-only change marks dirty and includes hashtags', () {
    final cubit = bodyCubit(
      '본문입니다',
      initialHashtags: const ['기존태그'],
    );

    expect(cubit.canSubmit, isFalse);

    final added = cubit.addHashtag('신규태그');
    expect(added, isTrue);
    expect(cubit.state.isDirty, isTrue);
    expect(cubit.canSubmit, isTrue);

    final result = cubit.buildResult();
    expect(result?.body, '본문입니다');
    expect(result?.hashtags, ['기존태그', '신규태그']);
  });

  test('blog body submit without hashtag change still returns hashtags', () {
    final cubit = bodyCubit(
      '본문입니다',
      initialHashtags: const ['태그1', '태그2'],
    );

    cubit.updateDocument(
      SsossContentsEditDocument.fromPlainText(plainText: '수정된 본문'),
    );

    final result = cubit.buildResult();
    expect(result?.body, '수정된 본문');
    expect(result?.hashtags, ['태그1', '태그2']);
  });

  test('merge body edit with hashtags updates channel payload', () {
    final merged = mergeEditToChannelResult(
      channel: UploadChannel.blog,
      initialTitle: '제목',
      initialBody: '원문',
      initialHashtags: const ['기존'],
      editResult: const ContentEditResult(
        channel: UploadChannel.blog,
        target: ContentEditTarget.body,
        body: '수정본문',
        hashtags: ['새태그'],
      ),
    );

    expect(merged.body, '수정본문');
    expect(merged.hashtags, ['#새태그']);
  });

  test('merge title edit keeps initial hashtags', () {
    final merged = mergeEditToChannelResult(
      channel: UploadChannel.blog,
      initialTitle: '제목',
      initialBody: '본문',
      initialHashtags: const ['유지태그'],
      editResult: const ContentEditResult(
        channel: UploadChannel.blog,
        target: ContentEditTarget.title,
        title: '새제목',
      ),
    );

    expect(merged.title, '새제목');
    expect(merged.hashtags, ['#유지태그']);
  });
}
