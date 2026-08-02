import 'package:ssoss_flutter/features/content/domain/entities/content_list_page.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_sort.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';

class ListContentsUseCase {
  ListContentsUseCase(this._repository);

  final ContentRepository _repository;

  Future<ContentListPage> call({
    UploadChannel? channel,
    ContentSort sort = ContentSort.latest,
    int page = 0,
    int size = 20,
  }) {
    return _repository.listContents(
      channel: channel,
      sort: sort,
      page: page,
      size: size,
    );
  }
}
