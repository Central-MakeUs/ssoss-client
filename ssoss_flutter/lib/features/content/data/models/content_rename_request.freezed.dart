// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_rename_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentRenameRequest {
  String get name;

  /// Create a copy of ContentRenameRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentRenameRequestCopyWith<ContentRenameRequest> get copyWith =>
      _$ContentRenameRequestCopyWithImpl<ContentRenameRequest>(
          this as ContentRenameRequest, _$identity);

  /// Serializes this ContentRenameRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentRenameRequest &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'ContentRenameRequest(name: $name)';
  }
}

/// @nodoc
abstract mixin class $ContentRenameRequestCopyWith<$Res> {
  factory $ContentRenameRequestCopyWith(ContentRenameRequest value,
          $Res Function(ContentRenameRequest) _then) =
      _$ContentRenameRequestCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$ContentRenameRequestCopyWithImpl<$Res>
    implements $ContentRenameRequestCopyWith<$Res> {
  _$ContentRenameRequestCopyWithImpl(this._self, this._then);

  final ContentRenameRequest _self;
  final $Res Function(ContentRenameRequest) _then;

  /// Create a copy of ContentRenameRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentRenameRequest].
extension ContentRenameRequestPatterns on ContentRenameRequest {
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
    TResult Function(_ContentRenameRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentRenameRequest() when $default != null:
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
    TResult Function(_ContentRenameRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentRenameRequest():
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
    TResult? Function(_ContentRenameRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentRenameRequest() when $default != null:
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
    TResult Function(String name)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentRenameRequest() when $default != null:
        return $default(_that.name);
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
    TResult Function(String name) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentRenameRequest():
        return $default(_that.name);
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
    TResult? Function(String name)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentRenameRequest() when $default != null:
        return $default(_that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentRenameRequest implements ContentRenameRequest {
  const _ContentRenameRequest({required this.name});
  factory _ContentRenameRequest.fromJson(Map<String, dynamic> json) =>
      _$ContentRenameRequestFromJson(json);

  @override
  final String name;

  /// Create a copy of ContentRenameRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentRenameRequestCopyWith<_ContentRenameRequest> get copyWith =>
      __$ContentRenameRequestCopyWithImpl<_ContentRenameRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentRenameRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentRenameRequest &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'ContentRenameRequest(name: $name)';
  }
}

/// @nodoc
abstract mixin class _$ContentRenameRequestCopyWith<$Res>
    implements $ContentRenameRequestCopyWith<$Res> {
  factory _$ContentRenameRequestCopyWith(_ContentRenameRequest value,
          $Res Function(_ContentRenameRequest) _then) =
      __$ContentRenameRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$ContentRenameRequestCopyWithImpl<$Res>
    implements _$ContentRenameRequestCopyWith<$Res> {
  __$ContentRenameRequestCopyWithImpl(this._self, this._then);

  final _ContentRenameRequest _self;
  final $Res Function(_ContentRenameRequest) _then;

  /// Create a copy of ContentRenameRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
  }) {
    return _then(_ContentRenameRequest(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
