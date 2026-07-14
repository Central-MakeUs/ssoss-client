# ADR-003 — 페이지 앱바는 body SafeArea 안에 배치

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 003 |
| 제목 | `SsossAppBar`는 inset을 갖지 않으며, 페이지 `body`의 `SafeArea` 안에서 배치한다 |
| 상태 | Accepted |
| 작성자 | 프로젝트 팀 |
| 작성일 | 2026-07-15 |
| 영향 범위 | 전체 프로젝트 (`presentation` 페이지 레이아웃, `common` 앱바) |

---

## 1. 맥락 (Context)

상태바·홈 인디케이터 등 시스템 inset을 처리하려면 `SafeArea`가 필요하다. 초기에 `SsossAppBar` 내부에 `SafeArea`를 넣거나, `Scaffold.appBar` + `preferredSize`에 top inset을 더하는 방식도 시도했다. 이 경우 다음 문제가 반복된다.

- `preferredSize`(고정 58)와 실제 그려진 높이(SafeArea + 58)가 어긋나 본문 영역이 밀리거나 겹친다.
- 화면마다 `PreferredSize` 래핑·`preferredSizeOf(context)` 같은 우회가 생기고, Home(외부 SafeArea)과 피처 페이지(`Scaffold.appBar`)가 다른 규칙을 쓴다.
- inset 책임이 앱바 컴포넌트·Scaffold·페이지에 분산되어 레이아웃이 중구난방이 된다.

**결정 유발 요인**

- 시스템 inset 처리 규칙을 프로젝트 전역에서 하나로 고정할 필요가 있다.
- `SsossAppBar`는 디자인 툴바(높이 58)만 담당해야 한다.
- Home 셸은 이미 `body` 쪽에서 SafeArea로 앱바를 감싸는 패턴을 쓰고 있어, 피처 페이지와도 맞출 수 있다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — `SsossAppBar` 내부에 `SafeArea` 포함

**설명**: 앱바 위젯이 스스로 top inset을 패딩한다. `Scaffold(appBar: ...)`에 그대로 연결한다.

| | 내용 |
|-|------|
| 장점 | 페이지마다 SafeArea를 신경 쓰지 않아도 된다. |
| 단점 | `preferredSize`와 실제 높이가 불일치한다. Scaffold body 레이아웃이 깨지기 쉽다. |
| 위험 | 화면마다 `PreferredSize` 보정 코드가 늘어난다. |

---

### 옵션 B — `Scaffold.appBar` + `preferredSize`에 top inset 합산

**설명**: 앱바에는 SafeArea를 두고, 페이지에서 `PreferredSize(preferredSize: 58 + padding.top, child: SsossAppBar)`로 보정한다.

| | 내용 |
|-|------|
| 장점 | Scaffold의 `appBar` 슬롯을 계속 쓸 수 있다. |
| 단점 | 모든 페이지가 MediaQuery·PreferredSize 보일러플레이트를 반복한다. |
| 위험 | Home(외부 SafeArea)과 규칙이 갈라져 유지보수가 어렵다. |

---

### 옵션 C — 앱바는 inset 없음, 페이지 `body`의 `SafeArea` 안에 배치 (선택)

**설명**: `SsossAppBar`는 높이 58 툴바만 렌더한다. 페이지는 `Scaffold(body: SafeArea(child: Column(앱바, 본문, …)))` 형태로 inset을 페이지에서 한 번 처리한다. 하단 네비게이션이 있는 Home처럼 셸이 앱바만 `SafeArea(bottom: false)`로 감싸는 변형도 허용한다.

| | 내용 |
|-|------|
| 장점 | inset 책임이 페이지(또는 셸)에만 있고, 앱바·preferredSize 우회가 없다. Home과 피처 페이지 규칙이 일치한다. |
| 단점 | `Scaffold.appBar` 슬롯을 기본으로 쓰지 않는다. 페이지 보일러플레이트가 Column 한 단 늘 수 있다. |
| 위험 | 신규 화면이 실수로 `Scaffold.appBar` + 내부 SafeArea 패턴으로 되돌아갈 수 있다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 C — 앱바는 inset 없음, 페이지 `body`의 `SafeArea` 안에 배치

1. **`SsossAppBar`는 SafeArea를 포함하지 않는다.** 고정 높이 툴바(58)와 액션만 담당한다.
2. **페이지는 `Scaffold.appBar`에 `SsossAppBar`를 넣지 않는 것을 기본으로 한다.** 대신 `body`에서 SafeArea와 Column으로 앱바를 배치한다.
3. **시스템 inset은 페이지(또는 Home 같은 셸)의 `SafeArea`가 담당한다.**
4. 하단 고정 CTA·스크롤 본문 등은 SafeArea 안 Column의 나머지 자식으로 구성한다.

**선택 근거**

preferredSize 보정 없이 inset을 한곳에서 처리하면 레이아웃 버그와 화면별 예외가 줄어든다. Home의 기존 패턴과도 맞추어, “앱바는 순수 UI, inset은 페이지”로 책임을 나눈다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- 앱바 높이·SafeArea·본문 중앙 정렬 이슈가 단순해진다.
- Home·콘텐츠 생성·생성 중 등 화면 레이아웃 규칙이 동일하다.
- `preferredSize`/`PreferredSize` 우회 코드가 필요 없다.

### 부정적 결과 / 감수한 트레이드오프

- Flutter 기본 `Scaffold.appBar` 슬롯을 쓰지 않으므로, Material AppBar 전용 API(`automaticallyImplyLeading` 등)에 의존하지 않는다. (이미 커스텀 앱바라 실영향은 작다.)
- 신규 페이지마다 `SafeArea` + `Column` 구조를 의식적으로 맞춰야 한다.

### 후속 조치 필요 사항

- [x] `SsossAppBar`에서 SafeArea 제거
- [x] 콘텐츠 생성·생성 중 페이지를 body SafeArea 패턴으로 전환
- [ ] 이후 신규/기존 페이지가 `Scaffold.appBar` + SafeArea 앱바 패턴을 쓰면 이 ADR에 맞게 수정

---

## 5. 구현 준수 사항 (AI 에이전트용)

> 이 ADR을 읽는 AI 에이전트가 구현 시 반드시 준수해야 할 규칙을 명시한다.

**반드시 해야 할 것**

- 앱바가 있는 페이지는 기본적으로 다음 구조를 따른다.

```dart
Scaffold(
  body: SafeArea(
    child: Column(
      children: [
        SsossAppBar.back(...), // 또는 exitOnly / defaultTitle / withBell
        // 고정 헤더(진행 바 등) — 필요 시
        Expanded(child: /* 스크롤 또는 본문 */),
        // 하단 CTA — 필요 시
      ],
    ),
  ),
);
```

- Home처럼 하단 네비가 있는 셸은 앱바만 `SafeArea(bottom: false)`로 감싸고, 탭 본문은 별도 `Expanded`로 둘 수 있다.
- `SsossAppBar`는 inset·SafeArea 없이 툴바 UI만 구현한다.
- SafeArea는 페이지(또는 셸)에서 한 번만 체계적으로 적용한다.

**절대 하지 말아야 할 것**

- `SsossAppBar` 내부에 `SafeArea`를 넣지 않는다.
- `Scaffold(appBar: SsossAppBar(...))`를 기본 패턴으로 쓰지 않는다.
- top inset을 맞추려고 `PreferredSize` / `preferredSizeOf`로 앱바 높이를 보정하지 않는다.

**참고 파일**

- `lib/common/widgets/app_bar/ssoss_app_bar.dart` — inset 없는 앱바
- `lib/features/home/presentation/pages/home_page.dart` — 셸에서 SafeArea로 앱바 배치
- `lib/features/content/presentation/pages/content_create_page.dart` — 피처 페이지 표준 구조
- `lib/features/content/presentation/pages/content_generating_page.dart` — 앱바 + 중앙 본문 예시

---

## 6. 관련 링크

- 공식 문서: https://api.flutter.dev/flutter/widgets/SafeArea-class.html
- 참고 자료: N/A
