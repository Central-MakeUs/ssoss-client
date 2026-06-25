#!/usr/bin/env bash
#
# Clean Architecture 피처 스캐폴딩 스크립트
#
# 사용법:
#   ./script/create_feature.sh <feature_name> [--cubit|--bloc|--all]
#
# 예시:
#   ./script/create_feature.sh auth              # Cubit (기본)
#   ./script/create_feature.sh auth --bloc
#   ./script/create_feature.sh auth --all
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_scaffold_lib.sh
source "$SCRIPT_DIR/_scaffold_lib.sh"

STATE_MODE="cubit"

usage() {
  cat <<'EOF'
Usage: create_feature.sh <feature_name> [--cubit|--bloc|--all]

Options:
  --cubit   Cubit 템플릿 생성 (기본)
  --bloc    Bloc(Event/State) 템플릿 생성
  --all     Cubit + Bloc 템플릿 모두 생성
  -h, --help  도움말 출력

feature_name 규칙:
  - snake_case (예: auth, user_profile)
  - 소문자, 숫자, 밑줄만 허용

추가 Cubit/Bloc은 add_feature_state.sh 로 생성할 수 있다.
EOF
}

main() {
  local feature_name=""
  local state_mode_set=false

  if [[ $# -eq 0 ]]; then
    usage
    exit 1
  fi

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        usage
        exit 0
        ;;
      --cubit|--bloc|--all)
        if [[ "$state_mode_set" == true ]]; then
          echo "error: --cubit, --bloc, --all 은 동시에 사용할 수 없습니다." >&2
          exit 1
        fi
        STATE_MODE="${1#--}"
        state_mode_set=true
        shift
        ;;
      -*)
        echo "error: 알 수 없는 옵션: $1" >&2
        usage
        exit 1
        ;;
      *)
        if [[ -n "$feature_name" ]]; then
          echo "error: feature_name은 하나만 지정할 수 있습니다." >&2
          usage
          exit 1
        fi
        feature_name="$1"
        shift
        ;;
    esac
  done

  if [[ -z "$feature_name" ]]; then
    echo "error: feature_name이 필요합니다." >&2
    usage
    exit 1
  fi

  validate_snake_name "$feature_name" "feature_name"

  local project_root
  project_root="$(cd "$SCRIPT_DIR/.." && pwd)"
  cd "$project_root"

  local feature_dir="${FEATURES_DIR}/${feature_name}"
  if [[ -e "$feature_dir" ]]; then
    echo "error: 이미 존재하는 피처입니다: $feature_dir" >&2
    exit 1
  fi

  local pascal_name
  pascal_name="$(to_pascal_case "$feature_name")"

  mkdir -p \
    "$feature_dir/data/datasources" \
    "$feature_dir/data/models" \
    "$feature_dir/data/repositories" \
    "$feature_dir/domain/entities" \
    "$feature_dir/domain/repositories" \
    "$feature_dir/domain/usecases" \
    "$feature_dir/presentation/pages" \
    "$feature_dir/presentation/widgets" \
    "$feature_dir/presentation/util"

  write_gitkeep "$feature_dir/data/models"
  write_gitkeep "$feature_dir/domain/entities"
  write_gitkeep "$feature_dir/domain/usecases"
  write_gitkeep "$feature_dir/presentation/widgets"
  write_gitkeep "$feature_dir/presentation/util"

  create_repository "$feature_dir" "$feature_name" "$pascal_name"
  create_datasource "$feature_dir" "$feature_name" "$pascal_name"
  create_page "$feature_dir" "$feature_name" "$pascal_name"
  create_state_templates "$feature_dir" "$feature_name" "$feature_name" "$STATE_MODE"

  run_build_runner "$SCRIPT_DIR"

  cat <<EOF

✅ 피처 생성 완료: $feature_dir
   상태 관리: ${STATE_MODE}

EOF
}

main "$@"
