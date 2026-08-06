class HashtagBundle {
  const HashtagBundle({
    required this.id,
    required this.name,
    required this.hashtags,
    required this.bookmarked,
  });

  final int id;
  final String name;
  final List<String> hashtags;
  final bool bookmarked;

  HashtagBundle copyWith({bool? bookmarked}) {
    return HashtagBundle(
      id: id,
      name: name,
      hashtags: hashtags,
      bookmarked: bookmarked ?? this.bookmarked,
    );
  }
}
