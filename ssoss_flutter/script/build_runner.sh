#!/usr/bin/env bash
#
# FVM Dart SDK로 build_runner 코드 생성 실행
#
# 사용법:
#   ./script/build_runner.sh [subcommand] [args...]
#
# 예시:
#   ./script/build_runner.sh
#   ./script/build_runner.sh watch
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_ROOT"

if ! command -v fvm >/dev/null 2>&1; then
  echo "error: fvm이 PATH에 없습니다. https://fvm.app 에서 설치하세요." >&2
  exit 1
fi

SUBCOMMAND="${1:-build}"
if [[ $# -gt 0 ]]; then
  shift
fi

exec fvm dart run build_runner "$SUBCOMMAND" "$@"
