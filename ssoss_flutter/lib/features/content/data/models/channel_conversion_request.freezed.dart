// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel_conversion_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChannelConversionRequest {
  List<String> get channels;

  /// Create a copy of ChannelConversionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChannelConversionRequestCopyWith<ChannelConversionRequest> get copyWith =>
      _$ChannelConversionRequestCopyWithImpl<ChannelConversionRequest>(
          this as ChannelConversionRequest, _$identity);

  /// Serializes this ChannelConversionRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChannelConversionRequest &&
            const DeepCollectionEquality().equals(other.channels, channels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(channels));

  @override
  String toString() {
    return 'ChannelConversionRequest(channels: $channels)';
  }
}

/// @nodoc
abstract mixin class $ChannelConversionRequestCopyWith<$Res> {
  factory $ChannelConversionRequestCopyWith(ChannelConversionRequest value,
          $Res Function(ChannelConversionRequest) _then) =
      _$ChannelConversionRequestCopyWithImpl;
  @useResult
  $Res call({List<String> channels});
}

/// @nodoc
class _$ChannelConversionRequestCopyWithImpl<$Res>
    implements $ChannelConversionRequestCopyWith<$Res> {
  _$ChannelConversionRequestCopyWithImpl(this._self, this._then);

  final ChannelConversionRequest _self;
  final $Res Function(ChannelConversionRequest) _then;

  /// Create a copy of ChannelConversionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channels = null,
  }) {
    return _then(_self.copyWith(
      channels: null == channels
          ? _self.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChannelConversionRequest].
extension ChannelConversionRequestPatterns on ChannelConversionRequest {
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
    TResult Function(_ChannelConversionRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelConversionRequest() when $default != null:
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
    TResult Function(_ChannelConversionRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelConversionRequest():
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
    TResult? Function(_ChannelConversionRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelConversionRequest() when $default != null:
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
    TResult Function(List<String> channels)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelConversionRequest() when $default != null:
        return $default(_that.channels);
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
    TResult Function(List<String> channels) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelConversionRequest():
        return $default(_that.channels);
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
    TResult? Function(List<String> channels)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelConversionRequest() when $default != null:
        return $default(_that.channels);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChannelConversionRequest implements ChannelConversionRequest {
  const _ChannelConversionRequest({required final List<String> channels})
      : _channels = channels;
  factory _ChannelConversionRequest.fromJson(Map<String, dynamic> json) =>
      _$ChannelConversionRequestFromJson(json);

  final List<String> _channels;
  @override
  List<String> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  /// Create a copy of ChannelConversionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChannelConversionRequestCopyWith<_ChannelConversionRequest> get copyWith =>
      __$ChannelConversionRequestCopyWithImpl<_ChannelConversionRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChannelConversionRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChannelConversionRequest &&
            const DeepCollectionEquality().equals(other._channels, _channels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_channels));

  @override
  String toString() {
    return 'ChannelConversionRequest(channels: $channels)';
  }
}

/// @nodoc
abstract mixin class _$ChannelConversionRequestCopyWith<$Res>
    implements $ChannelConversionRequestCopyWith<$Res> {
  factory _$ChannelConversionRequestCopyWith(_ChannelConversionRequest value,
          $Res Function(_ChannelConversionRequest) _then) =
      __$ChannelConversionRequestCopyWithImpl;
  @override
  @useResult
  $Res call({List<String> channels});
}

/// @nodoc
class __$ChannelConversionRequestCopyWithImpl<$Res>
    implements _$ChannelConversionRequestCopyWith<$Res> {
  __$ChannelConversionRequestCopyWithImpl(this._self, this._then);

  final _ChannelConversionRequest _self;
  final $Res Function(_ChannelConversionRequest) _then;

  /// Create a copy of ChannelConversionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? channels = null,
  }) {
    return _then(_ChannelConversionRequest(
      channels: null == channels
          ? _self._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
