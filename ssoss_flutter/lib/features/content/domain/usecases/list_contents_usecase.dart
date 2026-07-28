import 'package:ssoss_flutter/features/content/domain/entities/content_list_page.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class ListContentsUseCase {
  ListContentsUseCase(this._repository);

  final ContentRepository _repository;

  Future<ContentListPage> call({
    UploadChannel? channel,
    int page = 0,
    int size = 20,
  }) {
    return _repository.listContents(
      channel: channel,
      page: page,
      size: size,
    );
  }
}
