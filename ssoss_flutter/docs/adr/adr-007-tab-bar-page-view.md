# ADR-007 — SsossTabBar와 PageView 동기화 패턴

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 007 |
| 제목 | 다중 탭 화면은 `SsossTabBar` + `PageView`를 동일한 인덱스로 동기화한다 |
| 상태 | Accepted |
| 작성자 | 프로젝트 팀 |
| 작성일 | 2026-07-31 |
| 영향 범위 | 전체 프로젝트 (`presentation` 다중 탭 페이지 레이아웃) |

---

## 1. 맥락 (Context)

탭으로 섹션을 나누는 화면에서 탭 탭과 스와이프가 서로 어긋나면 UX가 깨진다. 초기에 탭만 `setState`로 바꾸고 `PageView`에 `PageController`를 두지 않거나, 탭 위젯을 헤더 컴포넌트 안에 묻어 두면 다음 문제가 생긴다.

- 탭을 눌러도 페이지가 애니메이션으로 이동하지 않거나, 스와이프와 선택 인덱스가 따로 논다.
- 탭별 전용 필터·리스트가 탭바와 페이지뷰 사이에 끼어 레이아웃 규칙이 화면마다 달라진다.
- `onTap` / `onPageChanged`에서 같은 인덱스를 반복 처리해 불필요한 rebuild가 난다.

**결정 유발 요인**

- 탭 ↔ 페이지 동기화 규칙을 프로젝트 전역에서 하나로 고정할 필요가 있다.
- `SsossTabBar`는 선택 UI만 담당하고, 페이지 전환은 `PageController`가 담당해야 한다.
- 콘텐츠 상세(`content_detail`)에서 검증된 패턴을 다른 다중 탭 화면에도 재사용해야 한다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — 탭만 전환 (PageView 없음)

**설명**: `SsossTabBar`의 `selectedIndex`만 바꾸고, 본문은 `if (index == 0) ... else ...`로 갈아끼운다.

| | 내용 |
|-|------|
| 장점 | 구현이 단순하고 컨트롤러 관리가 없다. |
| 단점 | 스와이프 전환이 없고, 탭 전환 애니메이션·제스처 UX가 없다. |
| 위험 | 화면마다 탭 전환 UX가 제각각이 된다. |

---

### 옵션 B — PageView만 두고 탭은 표시용

**설명**: `PageView`로만 넘기고, 탭은 `onPageChanged`로 하이라이트만 맞춘다. 탭 `onTap`은 인덱스만 바꾸거나 생략한다.

| | 내용 |
|-|------|
| 장점 | 스와이프는 자연스럽다. |
| 단점 | 탭을 눌렀을 때 페이지가 따라가지 않거나, `jumpToPage`만 쓰면 애니메이션이 없다. |
| 위험 | 탭·페이지 상태가 어긋나는 버그가 반복된다. |

---

### 옵션 C — SsossTabBar + PageController 동기화 (선택)

**설명**: `SsossTabBar`를 `PageView` 바로 위에 두고, 공유 `_selectedIndex`와 `PageController`로 양방향 동기화한다. 탭 탭 시 `animateToPage`, 스와이프 시 `onPageChanged`로 인덱스를 맞춘다.

| | 내용 |
|-|------|
| 장점 | 탭·스와이프 UX가 일치하고, 화면 간 구조가 통일된다. |
| 단점 | `PageController` lifecycle(`initState`/`dispose`) 보일러플레이트가 필요하다. |
| 위험 | 탭별 전용 UI를 탭바와 페이지뷰 사이에 다시 끼우면 패턴이 깨질 수 있다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 C — `SsossTabBar` + `PageController` 동기화

1. **다중 탭 본문은 `SsossTabBar` 바로 아래 `Expanded` + `PageView.builder`로 구성한다.**
2. **`PageController`를 페이지 State에서 생성·dispose하고, `initialPage`는 초기 선택 인덱스와 맞춘다.**
3. **탭 `onTap`은 `_onTabTap`에서 인덱스가 바뀔 때만 `setState` 후 `animateToPage`(250ms, `Curves.easeOut`)를 호출한다.**
4. **`onPageChanged`는 `_onPageChanged`에서 인덱스가 바뀔 때만 `setState`로 `_selectedIndex`를 맞춘다.**
5. **탭에 종속된 필터·리스트 등 본문 UI는 해당 `PageView` 페이지 안에 둔다.** 탭바과 페이지뷰 사이에는 공통 헤더만 둔다(검색·요약 패널 등).

**선택 근거**

탭과 스와이프를 한 인덱스로 묶으면 UX가 안정되고, `content_detail`과 같은 구조를 재사용해 신규·수정 화면에서 예외 패턴이 줄어든다. 탭별 UI를 페이지 안으로 넣으면 탭바–페이지뷰 인접 규칙도 유지된다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- 탭 탭·스와이프가 항상 같은 페이지를 가리킨다.
- 다중 탭 화면의 레이아웃·동기화 코드가 동일하다.
- 같은 인덱스 재선택의 불필요한 rebuild를 피할 수 있다.

### 부정적 결과 / 감수한 트레이드오프

- 모든 다중 탭 화면에 `PageController` lifecycle이 필요하다.
- 탭별 필터를 탭바 아래에 고정하고 싶어도, 패턴 유지를 위해 페이지 내부로 옮긴다.

### 후속 조치 필요 사항

- [x] `content_detail`의 TabBar + PageView 패턴을 기준으로 문서화
- [x] `recommend_source`를 동일 패턴으로 정렬
- [ ] 이후 신규/기존 다중 탭 화면이 탭만 전환하거나 컨트롤러 없이 PageView를 쓰면 이 ADR에 맞게 수정

---

## 5. 구현 준수 사항 (AI 에이전트용)

> 이 ADR을 읽는 AI 에이전트가 구현 시 반드시 준수해야 할 규칙을 명시한다.

**반드시 해야 할 것**

- 다중 탭 본문은 다음 구조를 기본으로 한다.

```dart
SsossTabBar(
  width: double.infinity,
  selectedIndex: _selectedIndex,
  items: [/* SsossTabItem */],
  onTap: _onTabTap,
),
Expanded(
  child: PageView.builder(
    controller: _pageController,
    itemCount: /* 탭 수 */,
    onPageChanged: _onPageChanged,
    itemBuilder: (context, index) {
      // 탭별 본문
    },
  ),
),
```

- `PageController`는 State의 `initState`에서 생성하고 `dispose`에서 해제한다.
- `_onTabTap` / `_onPageChanged`는 현재 인덱스와 같으면 early return 한다.
- 탭 탭 시 `animateToPage(index, duration: 250ms, curve: Curves.easeOut)`를 사용한다 (`unawaited` 허용).
- 탭에만 해당하는 UI(필터 칩, 섹션 리스트 등)는 해당 페이지 `itemBuilder` 안에 둔다.

**절대 하지 말아야 할 것**

- `PageController` 없이 `PageView`와 `SsossTabBar`를 따로 인덱싱하지 않는다.
- 탭 `onTap`에서 인덱스만 바꾸고 `animateToPage`/`jumpToPage`를 생략하지 않는다.
- `SsossTabBar`를 헤더 컴포넌트 깊숙이 숨긴 채 페이지와 동기화 경로를 끊지 않는다.
- Material `TabBar`/`TabBarView`를 기본 패턴으로 쓰지 않는다. (`SsossTabBar` + `PageView`를 사용한다.)

**참고 파일**

- `lib/features/dashboard/presentation/pages/content_detail/content_detail_page.dart` — 기준 구현
- `lib/features/recommend_source/presentation/pages/recommend_source/recommend_source_page.dart` — 동일 패턴 적용 예
- `lib/common/widgets/tab/ssoss_tab_bar.dart` — 탭바 컴포넌트

---

## 6. 관련 링크

- 공식 문서: https://api.flutter.dev/flutter/widgets/PageView-class.html
- 참고 자료: [ADR-003 — 페이지 앱바 SafeArea](adr-003-page-app-bar-safe-area.md)
