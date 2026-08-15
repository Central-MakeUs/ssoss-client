/// API 본문에서 파싱한 photo-guide 한 덩어리.
class PhotoGuideSegment {
  const PhotoGuideSegment({
    required this.title,
    required this.description,
    required this.displayOffset,
    required this.startIndex,
    required this.endIndex,
  });

  final String title;
  final String description;

  /// 태그가 제거된 [ParsedPhotoGuideBody.displayBody] 기준 삽입 인덱스.
  final int displayOffset;

  /// 원본 [rawBody] 기준 태그 시작·끝 인덱스.
  final int startIndex;
  final int endIndex;
}

/// serialize / draft용 가이드 배치 정보.
class PhotoGuidePlacement {
  const PhotoGuidePlacement({
    required this.displayOffset,
    required this.title,
    required this.description,
  });

  final int displayOffset;
  final String title;
  final String description;

  PhotoGuidePlacement copyWith({
    int? displayOffset,
    String? title,
    String? description,
  }) {
    return PhotoGuidePlacement(
      displayOffset: displayOffset ?? this.displayOffset,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

/// `<photo-guide title="..." description="..."/>` 파싱 결과.
class ParsedPhotoGuideBody {
  const ParsedPhotoGuideBody({
    required this.displayBody,
    required this.segments,
  });

  /// 태그가 제거된 본문.
  final String displayBody;

  final List<PhotoGuideSegment> segments;

  List<PhotoGuidePlacement> get placements => [
        for (final segment in segments)
          PhotoGuidePlacement(
            displayOffset: segment.displayOffset,
            title: segment.title,
            description: segment.description,
          ),
      ];
}

/// API 본문의 photo-guide self-closing 태그를 파싱·직렬화한다.
class PhotoGuideParser {
  const PhotoGuideParser._();

  static final _tagPattern = RegExp(
    r'<photo-guide\s+title="([^"]*)"\s+description="([^"]*)"\s*/>',
  );

  static ParsedPhotoGuideBody parse(String rawBody) {
    final segments = <PhotoGuideSegment>[];
    final buffer = StringBuffer();
    var cursor = 0;

    for (final match in _tagPattern.allMatches(rawBody)) {
      buffer.write(rawBody.substring(cursor, match.start));
      segments.add(
        PhotoGuideSegment(
          title: match.group(1) ?? '',
          description: match.group(2) ?? '',
          displayOffset: buffer.length,
          startIndex: match.start,
          endIndex: match.end,
        ),
      );
      cursor = match.end;
    }
    buffer.write(rawBody.substring(cursor));

    return ParsedPhotoGuideBody(
      displayBody: buffer.toString(),
      segments: segments,
    );
  }

  /// [displayBody]에 남은 [placements]만 `<photo-guide />` 태그로 재삽입한다.
  static String serialize(
    String displayBody, {
    List<PhotoGuidePlacement> placements = const [],
  }) {
    if (placements.isEmpty) {
      return displayBody;
    }

    final sorted = List<PhotoGuidePlacement>.of(placements)
      ..sort((a, b) => a.displayOffset.compareTo(b.displayOffset));

    final buffer = StringBuffer();
    var cursor = 0;

    for (final placement in sorted) {
      final offset = placement.displayOffset.clamp(0, displayBody.length);
      if (offset > cursor) {
        buffer.write(displayBody.substring(cursor, offset));
      }
      buffer.write(_tag(placement.title, placement.description));
      cursor = offset;
    }

    if (cursor < displayBody.length) {
      buffer.write(displayBody.substring(cursor));
    }

    return buffer.toString();
  }

  static String _tag(String title, String description) {
    return '<photo-guide title="$title" description="$description"/>';
  }
}
