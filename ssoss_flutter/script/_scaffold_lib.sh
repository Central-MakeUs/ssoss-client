#!/usr/bin/env bash
# 공통 스캐폴딩 함수 (create_feature.sh, add_feature_state.sh 에서 source)

PACKAGE_NAME="ssoss_flutter"
FEATURES_DIR="lib/features"

to_pascal_case() {
  local input="$1"
  local part
  local result=""

  IFS='_' read -ra parts <<< "$input"
  for part in "${parts[@]}"; do
    if [[ -z "$part" ]]; then
      echo "error: snake_case 이름에 연속 밑줄이나 빈 세그먼트가 있습니다." >&2
      exit 1
    fi
    local first_char="${part:0:1}"
    local rest="${part:1}"
    result+="$(printf '%s' "$first_char" | tr '[:lower:]' '[:upper:]')${rest}"
  done

  echo "$result"
}

validate_snake_name() {
  local name="$1"
  local label="${2:-name}"

  if [[ ! "$name" =~ ^[a-z][a-z0-9_]*$ ]]; then
    echo "error: ${label}은 snake_case여야 합니다. (예: auth, user_profile)" >&2
    exit 1
  fi

  if [[ "$name" =~ __ ]]; then
    echo "error: ${label}에 연속 밑줄(__)을 사용할 수 없습니다." >&2
    exit 1
  fi
}

write_gitkeep() {
  local dir="$1"
  mkdir -p "$dir"
  touch "$dir/.gitkeep"
}

cubit_exists() {
  local feature_dir="$1"
  local name="$2"
  [[ -f "$feature_dir/presentation/cubit/${name}_cubit.dart" ]]
}

bloc_exists() {
  local feature_dir="$1"
  local name="$2"
  [[ -f "$feature_dir/presentation/bloc/${name}_bloc.dart" ]]
}

assert_cubit_not_exists() {
  local feature_dir="$1"
  local name="$2"
  if cubit_exists "$feature_dir" "$name"; then
    echo "error: 이미 존재하는 Cubit입니다: presentation/cubit/${name}_cubit.dart" >&2
    exit 1
  fi
}

assert_bloc_not_exists() {
  local feature_dir="$1"
  local name="$2"
  if bloc_exists "$feature_dir" "$name"; then
    echo "error: 이미 존재하는 Bloc입니다: presentation/bloc/${name}_bloc.dart" >&2
    exit 1
  fi
}

create_repository() {
  local feature_dir="$1"
  local feature_name="$2"
  local pascal_name="$3"

  cat > "$feature_dir/domain/repositories/${feature_name}_repository.dart" <<EOF
/// ${pascal_name} 도메인 repository 계약.
abstract class ${pascal_name}Repository {
  // TODO: 도메인 메서드 정의
}
EOF

  cat > "$feature_dir/data/repositories/${feature_name}_repository_impl.dart" <<EOF
import 'package:${PACKAGE_NAME}/features/${feature_name}/domain/repositories/${feature_name}_repository.dart';

class ${pascal_name}RepositoryImpl implements ${pascal_name}Repository {
  ${pascal_name}RepositoryImpl();

  // TODO: datasource 연동 및 model → entity 변환
}
EOF
}

create_datasource() {
  local feature_dir="$1"
  local feature_name="$2"
  local pascal_name="$3"

  cat > "$feature_dir/data/datasources/${feature_name}_datasource.dart" <<EOF
class ${pascal_name}Datasource {
  ${pascal_name}Datasource();

  // TODO: API 호출 구현
}
EOF
}

create_page() {
  local feature_dir="$1"
  local feature_name="$2"
  local pascal_name="$3"

  cat > "$feature_dir/presentation/pages/${feature_name}_page.dart" <<EOF
import 'package:flutter/material.dart';

class ${pascal_name}Page extends StatelessWidget {
  const ${pascal_name}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${pascal_name}'),
      ),
      body: const Center(
        child: Text('${pascal_name}Page'),
      ),
    );
  }
}
EOF
}

create_cubit() {
  local feature_dir="$1"
  local feature_name="$2"
  local name="$3"
  local pascal_name="$4"

  mkdir -p "$feature_dir/presentation/cubit"

  cat > "$feature_dir/presentation/cubit/${name}_state.dart" <<EOF
import 'package:freezed_annotation/freezed_annotation.dart';

part '${name}_state.freezed.dart';

@freezed
abstract class ${pascal_name}State with _\$${pascal_name}State {
  const factory ${pascal_name}State.initial() = _Initial;
}
EOF

  cat > "$feature_dir/presentation/cubit/${name}_cubit.dart" <<EOF
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:${PACKAGE_NAME}/features/${feature_name}/presentation/cubit/${name}_state.dart';

class ${pascal_name}Cubit extends Cubit<${pascal_name}State> {
  ${pascal_name}Cubit() : super(const ${pascal_name}State.initial());
}
EOF
}

create_bloc() {
  local feature_dir="$1"
  local feature_name="$2"
  local name="$3"
  local pascal_name="$4"

  mkdir -p "$feature_dir/presentation/bloc"

  cat > "$feature_dir/presentation/bloc/${name}_event.dart" <<EOF
import 'package:freezed_annotation/freezed_annotation.dart';

part '${name}_event.freezed.dart';

@freezed
abstract class ${pascal_name}Event with _\$${pascal_name}Event {
  const factory ${pascal_name}Event.started() = _Started;
}
EOF

  cat > "$feature_dir/presentation/bloc/${name}_state.dart" <<EOF
import 'package:freezed_annotation/freezed_annotation.dart';

part '${name}_state.freezed.dart';

@freezed
abstract class ${pascal_name}State with _\$${pascal_name}State {
  const factory ${pascal_name}State.initial() = _Initial;
}
EOF

  cat > "$feature_dir/presentation/bloc/${name}_bloc.dart" <<EOF
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:${PACKAGE_NAME}/features/${feature_name}/presentation/bloc/${name}_event.dart';
import 'package:${PACKAGE_NAME}/features/${feature_name}/presentation/bloc/${name}_state.dart';

class ${pascal_name}Bloc extends Bloc<${pascal_name}Event, ${pascal_name}State> {
  ${pascal_name}Bloc() : super(const ${pascal_name}State.initial()) {
    on<_Started>(_onStarted);
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<${pascal_name}State> emit,
  ) async {
    // TODO: 이벤트 처리
  }
}
EOF
}

run_build_runner() {
  local script_dir="$1"
  echo ""
  echo "🔧 freezed 코드 생성 중..."
  "$script_dir/build_runner.sh"
}

create_state_templates() {
  local feature_dir="$1"
  local feature_name="$2"
  local name="$3"
  local mode="$4"
  local pascal_name
  pascal_name="$(to_pascal_case "$name")"

  case "$mode" in
    cubit)
      assert_cubit_not_exists "$feature_dir" "$name"
      create_cubit "$feature_dir" "$feature_name" "$name" "$pascal_name"
      ;;
    bloc)
      assert_bloc_not_exists "$feature_dir" "$name"
      create_bloc "$feature_dir" "$feature_name" "$name" "$pascal_name"
      ;;
    all)
      assert_cubit_not_exists "$feature_dir" "$name"
      assert_bloc_not_exists "$feature_dir" "$name"
      create_cubit "$feature_dir" "$feature_name" "$name" "$pascal_name"
      create_bloc "$feature_dir" "$feature_name" "$name" "$pascal_name"
      ;;
    *)
      echo "error: 지원하지 않는 상태 관리 모드: $mode" >&2
      exit 1
      ;;
  esac
}
