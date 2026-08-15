// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generation_start_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenerationStartResponse {
  int get generationId;

  /// Create a copy of GenerationStartResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenerationStartResponseCopyWith<GenerationStartResponse> get copyWith =>
      _$GenerationStartResponseCopyWithImpl<GenerationStartResponse>(
          this as GenerationStartResponse, _$identity);

  /// Serializes this GenerationStartResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenerationStartResponse &&
            (identical(other.generationId, generationId) ||
                other.generationId == generationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, generationId);

  @override
  String toString() {
    return 'GenerationStartResponse(generationId: $generationId)';
  }
}

/// @nodoc
abstract mixin class $GenerationStartResponseCopyWith<$Res> {
  factory $GenerationStartResponseCopyWith(GenerationStartResponse value,
          $Res Function(GenerationStartResponse) _then) =
      _$GenerationStartResponseCopyWithImpl;
  @useResult
  $Res call({int generationId});
}

/// @nodoc
class _$GenerationStartResponseCopyWithImpl<$Res>
    implements $GenerationStartResponseCopyWith<$Res> {
  _$GenerationStartResponseCopyWithImpl(this._self, this._then);

  final GenerationStartResponse _self;
  final $Res Function(GenerationStartResponse) _then;

  /// Create a copy of GenerationStartResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generationId = null,
  }) {
    return _then(_self.copyWith(
      generationId: null == generationId
          ? _self.generationId
          : generationId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [GenerationStartResponse].
extension GenerationStartResponsePatterns on GenerationStartResponse {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GenerationStartResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerationStartResponse() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GenerationStartResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationStartResponse():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GenerationStartResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationStartResponse() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int generationId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerationStartResponse() when $default != null:
        return $default(_that.generationId);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int generationId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationStartResponse():
        return $default(_that.generationId);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int generationId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationStartResponse() when $default != null:
        return $default(_that.generationId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GenerationStartResponse implements GenerationStartResponse {
  const _GenerationStartResponse({required this.generationId});
  factory _GenerationStartResponse.fromJson(Map<String, dynamic> json) =>
      _$GenerationStartResponseFromJson(json);

  @override
  final int generationId;

  /// Create a copy of GenerationStartResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenerationStartResponseCopyWith<_GenerationStartResponse> get copyWith =>
      __$GenerationStartResponseCopyWithImpl<_GenerationStartResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GenerationStartResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenerationStartResponse &&
            (identical(other.generationId, generationId) ||
                other.generationId == generationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, generationId);

  @override
  String toString() {
    return 'GenerationStartResponse(generationId: $generationId)';
  }
}

/// @nodoc
abstract mixin class _$GenerationStartResponseCopyWith<$Res>
    implements $GenerationStartResponseCopyWith<$Res> {
  factory _$GenerationStartResponseCopyWith(_GenerationStartResponse value,
          $Res Function(_GenerationStartResponse) _then) =
      __$GenerationStartResponseCopyWithImpl;
  @override
  @useResult
  $Res call({int generationId});
}

/// @nodoc
class __$GenerationStartResponseCopyWithImpl<$Res>
    implements _$GenerationStartResponseCopyWith<$Res> {
  __$GenerationStartResponseCopyWithImpl(this._self, this._then);

  final _GenerationStartResponse _self;
  final $Res Function(_GenerationStartResponse) _then;

  /// Create a copy of GenerationStartResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? generationId = null,
  }) {
    return _then(_GenerationStartResponse(
      generationId: null == generationId
          ? _self.generationId
          : generationId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
