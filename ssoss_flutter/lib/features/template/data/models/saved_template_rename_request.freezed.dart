// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_template_rename_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedTemplateRenameRequest {
  String get title;

  /// Create a copy of SavedTemplateRenameRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedTemplateRenameRequestCopyWith<SavedTemplateRenameRequest>
      get copyWith =>
          _$SavedTemplateRenameRequestCopyWithImpl<SavedTemplateRenameRequest>(
              this as SavedTemplateRenameRequest, _$identity);

  /// Serializes this SavedTemplateRenameRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedTemplateRenameRequest &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @override
  String toString() {
    return 'SavedTemplateRenameRequest(title: $title)';
  }
}

/// @nodoc
abstract mixin class $SavedTemplateRenameRequestCopyWith<$Res> {
  factory $SavedTemplateRenameRequestCopyWith(SavedTemplateRenameRequest value,
          $Res Function(SavedTemplateRenameRequest) _then) =
      _$SavedTemplateRenameRequestCopyWithImpl;
  @useResult
  $Res call({String title});
}

/// @nodoc
class _$SavedTemplateRenameRequestCopyWithImpl<$Res>
    implements $SavedTemplateRenameRequestCopyWith<$Res> {
  _$SavedTemplateRenameRequestCopyWithImpl(this._self, this._then);

  final SavedTemplateRenameRequest _self;
  final $Res Function(SavedTemplateRenameRequest) _then;

  /// Create a copy of SavedTemplateRenameRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedTemplateRenameRequest].
extension SavedTemplateRenameRequestPatterns on SavedTemplateRenameRequest {
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
    TResult Function(_SavedTemplateRenameRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateRenameRequest() when $default != null:
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
    TResult Function(_SavedTemplateRenameRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateRenameRequest():
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
    TResult? Function(_SavedTemplateRenameRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateRenameRequest() when $default != null:
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
    TResult Function(String title)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateRenameRequest() when $default != null:
        return $default(_that.title);
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
    TResult Function(String title) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateRenameRequest():
        return $default(_that.title);
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
    TResult? Function(String title)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateRenameRequest() when $default != null:
        return $default(_that.title);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SavedTemplateRenameRequest implements SavedTemplateRenameRequest {
  const _SavedTemplateRenameRequest({required this.title});
  factory _SavedTemplateRenameRequest.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateRenameRequestFromJson(json);

  @override
  final String title;

  /// Create a copy of SavedTemplateRenameRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedTemplateRenameRequestCopyWith<_SavedTemplateRenameRequest>
      get copyWith => __$SavedTemplateRenameRequestCopyWithImpl<
          _SavedTemplateRenameRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SavedTemplateRenameRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedTemplateRenameRequest &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @override
  String toString() {
    return 'SavedTemplateRenameRequest(title: $title)';
  }
}

/// @nodoc
abstract mixin class _$SavedTemplateRenameRequestCopyWith<$Res>
    implements $SavedTemplateRenameRequestCopyWith<$Res> {
  factory _$SavedTemplateRenameRequestCopyWith(
          _SavedTemplateRenameRequest value,
          $Res Function(_SavedTemplateRenameRequest) _then) =
      __$SavedTemplateRenameRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$SavedTemplateRenameRequestCopyWithImpl<$Res>
    implements _$SavedTemplateRenameRequestCopyWith<$Res> {
  __$SavedTemplateRenameRequestCopyWithImpl(this._self, this._then);

  final _SavedTemplateRenameRequest _self;
  final $Res Function(_SavedTemplateRenameRequest) _then;

  /// Create a copy of SavedTemplateRenameRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
  }) {
    return _then(_SavedTemplateRenameRequest(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
