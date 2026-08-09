import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_edit_cubit.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';

void main() {
  ContentEditCubit bodyCubit(String initialBody) {
    return ContentEditCubit(
      args: ContentEditArgs(
        channel: UploadChannel.blog,
        target: ContentEditTarget.body,
        initialBody: initialBody,
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
}
