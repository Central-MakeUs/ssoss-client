enum TemplateCategory {
  all('전체'),
  newMenu('신메뉴'),
  event('이벤트'),
  storeIntro('매장 소개'),
  notice('공지');

  const TemplateCategory(this.label);

  final String label;
}

class TemplateItem {
  const TemplateItem({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.channels,
    this.isSaved = false,
  });

  final String id;
  final TemplateCategory category;
  final String title;
  final String description;
  final List<String> channels;
  final bool isSaved;

  TemplateItem copyWith({bool? isSaved}) {
    return TemplateItem(
      id: id,
      category: category,
      title: title,
      description: description,
      channels: channels,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
