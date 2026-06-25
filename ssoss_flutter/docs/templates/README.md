# 문서 템플릿 워크플로우

이 폴더에는 새로운 기능을 **구현하기 전에** 반드시 작성해야 하는 문서 템플릿이 있다.

AI 에이전트와 개발자 모두 구현을 시작하기 전에 아래 순서대로 문서를 작성하고 숙지해야 한다.

---

## 문서 종류와 위치

### 프로젝트 전역 — `docs/adr/`

**ADR (Architecture Decision Record)** 은 프레임워크·라이브러리·아키텍처 패턴 선택처럼
**프로젝트 전체에 영향을 미치는 기술 결정**을 기록한다. 특정 기능과는 무관하다.

```
docs/adr/
├── adr-001-clean-architecture.md   # 왜 클린 아키텍처를 선택했는가
├── adr-002-flutter-bloc.md         # 왜 flutter_bloc을 선택했는가
└── adr-NNN-{title}.md
```

> ADR은 한 번 Accepted 되면 수정하지 않는다. 번복 시 새 ADR을 작성하고 이전 ADR을 Superseded 처리한다.

---

### 기능별 — `docs/specs/{feature}/`

기능 구현 전 **무엇을 왜 어떻게 만드는지** 합의하기 위한 문서다.

| 순서 | 문서 | 목적 |
|------|------|------|
| 1 | **PRD** (`prd.md`) | 요구사항, UX 흐름, 범위(in/out) 정의 |
| 2 | **TDD** (`tdd.md`) | 클린 아키텍처 레이어별 설계, 기능 범위 설계 결정 |
| 3 | **Task List** (`tasks.md`) | 구현 단계별 체크리스트 |

```
docs/specs/{feature_name}/
├── prd.md
├── tdd.md
└── tasks.md
```

---

## 전체 문서 구조

```
docs/
├── architecture/          # 프로젝트 아키텍처 가이드 (수정 금지)
├── adr/                   # 프로젝트 전역 기술 결정 기록
│   └── adr-NNN-{title}.md
├── templates/             # 이 폴더 — 빈 템플릿 모음
│   ├── README.md
│   ├── prd-template.md
│   ├── adr-template.md
│   ├── tdd-template.md
│   └── task-list-template.md
└── specs/                 # 기능별 실제 작성 문서
    └── {feature_name}/
        ├── prd.md
        ├── tdd.md
        └── tasks.md
```

---

## AI 에이전트를 위한 지침

구현을 요청받은 경우 다음 순서를 따른다.

1. `docs/adr/` 의 ADR 목록을 확인하고 **관련된 프로젝트 기술 결정**을 파악한다.
2. `docs/specs/{feature}/prd.md` 를 읽고 **요구사항과 범위**를 파악한다.
3. `docs/specs/{feature}/tdd.md` 를 읽고 **레이어별 설계와 기능 설계 결정**을 따른다.
4. `docs/specs/{feature}/tasks.md` 를 읽고 **체크리스트 순서대로** 구현한다.
5. 아키텍처 문서(`docs/architecture/`)와 충돌이 있으면 아키텍처 문서를 우선한다.

---

## 템플릿 사용법

### ADR 작성 (프로젝트 전역 기술 결정 시)

```bash
mkdir -p docs/adr
cp docs/templates/adr-template.md docs/adr/adr-NNN-{title}.md
```

### 기능 문서 작성

```bash
mkdir -p docs/specs/{feature_name}
cp docs/templates/prd-template.md       docs/specs/{feature_name}/prd.md
cp docs/templates/tdd-template.md       docs/specs/{feature_name}/tdd.md
cp docs/templates/task-list-template.md docs/specs/{feature_name}/tasks.md
```
