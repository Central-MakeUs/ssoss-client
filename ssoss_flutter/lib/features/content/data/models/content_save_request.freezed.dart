// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_save_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentSaveRequest {
  int get generationId;
  List<GenerationChannelResultModel> get contents;

  /// Create a copy of ContentSaveRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentSaveRequestCopyWith<ContentSaveRequest> get copyWith =>
      _$ContentSaveRequestCopyWithImpl<ContentSaveRequest>(
          this as ContentSaveRequest, _$identity);

  /// Serializes this ContentSaveRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentSaveRequest &&
            (identical(other.generationId, generationId) ||
                other.generationId == generationId) &&
            const DeepCollectionEquality().equals(other.contents, contents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, generationId, const DeepCollectionEquality().hash(contents));

  @override
  String toString() {
    return 'ContentSaveRequest(generationId: $generationId, contents: $contents)';
  }
}

/// @nodoc
abstract mixin class $ContentSaveRequestCopyWith<$Res> {
  factory $ContentSaveRequestCopyWith(
          ContentSaveRequest value, $Res Function(ContentSaveRequest) _then) =
      _$ContentSaveRequestCopyWithImpl;
  @useResult
  $Res call({int generationId, List<GenerationChannelResultModel> contents});
}

/// @nodoc
class _$ContentSaveRequestCopyWithImpl<$Res>
    implements $ContentSaveRequestCopyWith<$Res> {
  _$ContentSaveRequestCopyWithImpl(this._self, this._then);

  final ContentSaveRequest _self;
  final $Res Function(ContentSaveRequest) _then;

  /// Create a copy of ContentSaveRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generationId = null,
    Object? contents = null,
  }) {
    return _then(_self.copyWith(
      generationId: null == generationId
          ? _self.generationId
          : generationId // ignore: cast_nullable_to_non_nullable
              as int,
      contents: null == contents
          ? _self.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<GenerationChannelResultModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentSaveRequest].
extension ContentSaveRequestPatterns on ContentSaveRequest {
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
    TResult Function(_ContentSaveRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentSaveRequest() when $default != null:
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
    TResult Function(_ContentSaveRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveRequest():
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
    TResult? Function(_ContentSaveRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveRequest() when $default != null:
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
    TResult Function(
            int generationId, List<GenerationChannelResultModel> contents)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentSaveRequest() when $default != null:
        return $default(_that.generationId, _that.contents);
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
    TResult Function(
            int generationId, List<GenerationChannelResultModel> contents)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveRequest():
        return $default(_that.generationId, _that.contents);
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
    TResult? Function(
            int generationId, List<GenerationChannelResultModel> contents)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentSaveRequest() when $default != null:
        return $default(_that.generationId, _that.contents);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ContentSaveRequest extends ContentSaveRequest {
  const _ContentSaveRequest(
      {required this.generationId,
      required final List<GenerationChannelResultModel> contents})
      : _contents = contents,
        super._();
  factory _ContentSaveRequest.fromJson(Map<String, dynamic> json) =>
      _$ContentSaveRequestFromJson(json);

  @override
  final int generationId;
  final List<GenerationChannelResultModel> _contents;
  @override
  List<GenerationChannelResultModel> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  /// Create a copy of ContentSaveRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentSaveRequestCopyWith<_ContentSaveRequest> get copyWith =>
      __$ContentSaveRequestCopyWithImpl<_ContentSaveRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentSaveRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentSaveRequest &&
            (identical(other.generationId, generationId) ||
                other.generationId == generationId) &&
            const DeepCollectionEquality().equals(other._contents, _contents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, generationId,
      const DeepCollectionEquality().hash(_contents));

  @override
  String toString() {
    return 'ContentSaveRequest(generationId: $generationId, contents: $contents)';
  }
}

/// @nodoc
abstract mixin class _$ContentSaveRequestCopyWith<$Res>
    implements $ContentSaveRequestCopyWith<$Res> {
  factory _$ContentSaveRequestCopyWith(
          _ContentSaveRequest value, $Res Function(_ContentSaveRequest) _then) =
      __$ContentSaveRequestCopyWithImpl;
  @override
  @useResult
  $Res call({int generationId, List<GenerationChannelResultModel> contents});
}

/// @nodoc
class __$ContentSaveRequestCopyWithImpl<$Res>
    implements _$ContentSaveRequestCopyWith<$Res> {
  __$ContentSaveRequestCopyWithImpl(this._self, this._then);

  final _ContentSaveRequest _self;
  final $Res Function(_ContentSaveRequest) _then;

  /// Create a copy of ContentSaveRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? generationId = null,
    Object? contents = null,
  }) {
    return _then(_ContentSaveRequest(
      generationId: null == generationId
          ? _self.generationId
          : generationId // ignore: cast_nullable_to_non_nullable
              as int,
      contents: null == contents
          ? _self._contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<GenerationChannelResultModel>,
    ));
  }
}

// dart format on
