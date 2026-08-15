import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/utils/photo_guide_parser.dart';

void main() {
  group('PhotoGuideParser.parse', () {
    test('returns displayBody unchanged when no tags', () {
      const raw = '본문만 있습니다.';
      final parsed = PhotoGuideParser.parse(raw);

      expect(parsed.displayBody, raw);
      expect(parsed.segments, isEmpty);
    });

    test('records displayOffset at tag position', () {
      const raw = '앞부분 <photo-guide title="제목" description="설명"/> 뒷부분';
      final parsed = PhotoGuideParser.parse(raw);

      expect(parsed.displayBody, '앞부분  뒷부분');
      expect(parsed.segments, hasLength(1));
      expect(parsed.segments.single.displayOffset, '앞부분 '.length);
      expect(parsed.segments.single.title, '제목');
      expect(parsed.segments.single.description, '설명');
    });

    test('parses multiple tags with correct offsets', () {
      const raw = 'A<photo-guide title="t1" description="d1"/>B'
          '<photo-guide title="t2" description="d2"/>C';
      final parsed = PhotoGuideParser.parse(raw);

      expect(parsed.displayBody, 'ABC');
      expect(parsed.segments, hasLength(2));
      expect(parsed.segments[0].displayOffset, 1);
      expect(parsed.segments[1].displayOffset, 2);
    });
  });

  group('PhotoGuideParser.serialize', () {
    test('returns displayBody when placements empty', () {
      expect(
        PhotoGuideParser.serialize('본문', placements: const []),
        '본문',
      );
    });

    test('reinserts tags at offsets', () {
      const display = '앞부분  뒷부분';
      final serialized = PhotoGuideParser.serialize(
        display,
        placements: [
          const PhotoGuidePlacement(
            displayOffset: 4,
            title: '제목',
            description: '설명',
          ),
        ],
      );

      expect(
        serialized,
        '앞부분 <photo-guide title="제목" description="설명"/> 뒷부분',
      );
    });

    test('omits deleted placements', () {
      const display = 'ABC';
      final serialized = PhotoGuideParser.serialize(
        display,
        placements: [
          const PhotoGuidePlacement(
            displayOffset: 2,
            title: 't2',
            description: 'd2',
          ),
        ],
      );

      expect(
        serialized,
        'AB<photo-guide title="t2" description="d2"/>C',
      );
    });

    test('round-trips with parse', () {
      const raw = '앞<photo-guide title="t1" description="d1"/>중'
          '<photo-guide title="t2" description="d2"/>끝';
      final parsed = PhotoGuideParser.parse(raw);
      final again = PhotoGuideParser.serialize(
        parsed.displayBody,
        placements: parsed.placements,
      );

      expect(again, raw);
    });
  });
}
