#!/usr/bin/env bash
#
# 기존 피처에 Cubit / Bloc 템플릿 추가
#
# 사용법:
#   ./script/add_feature_state.sh <feature_name> <name> [--cubit|--bloc|--all]
#
# 예시:
#   ./script/add_feature_state.sh auth profile --cubit
#   ./script/add_feature_state.sh auth login --bloc
#   ./script/add_feature_state.sh auth session --all
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./_scaffold_lib.sh
source "$SCRIPT_DIR/_scaffold_lib.sh"

STATE_MODE="cubit"

usage() {
  cat <<'EOF'
Usage: add_feature_state.sh <feature_name> <name> [--cubit|--bloc|--all]

Arguments:
  feature_name  대상 피처 (snake_case)
  name          Cubit/Bloc 파일 접두사 (snake_case, 예: login, profile)

Options:
  --cubit   Cubit 템플릿 추가 (기본)
  --bloc    Bloc(Event/State) 템플릿 추가
  --all     Cubit + Bloc 템플릿 모두 추가
  -h, --help  도움말 출력

동일한 name 으로 이미 존재하는 Cubit/Bloc 은 생성할 수 없다.
EOF
}

main() {
  local feature_name=""
  local name=""
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
        if [[ -z "$feature_name" ]]; then
          feature_name="$1"
        elif [[ -z "$name" ]]; then
          name="$1"
        else
          echo "error: 인자가 너무 많습니다." >&2
          usage
          exit 1
        fi
        shift
        ;;
    esac
  done

  if [[ -z "$feature_name" || -z "$name" ]]; then
    echo "error: feature_name과 name이 필요합니다." >&2
    usage
    exit 1
  fi

  validate_snake_name "$feature_name" "feature_name"
  validate_snake_name "$name" "name"

  local project_root
  project_root="$(cd "$SCRIPT_DIR/.." && pwd)"
  cd "$project_root"

  local feature_dir="${FEATURES_DIR}/${feature_name}"
  if [[ ! -d "$feature_dir" ]]; then
    echo "error: 피처가 존재하지 않습니다: $feature_dir" >&2
    exit 1
  fi

  create_state_templates "$feature_dir" "$feature_name" "$name" "$STATE_MODE"
  run_build_runner "$SCRIPT_DIR"

  cat <<EOF

✅ 상태 관리 템플릿 추가 완료: $feature_dir
   name: ${name}
   타입: ${STATE_MODE}

EOF
}

main "$@"
