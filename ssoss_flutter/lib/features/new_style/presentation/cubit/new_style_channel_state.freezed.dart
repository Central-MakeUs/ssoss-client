// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_style_channel_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewStyleChannelState {
  List<UploadChannel> get channels;

  /// Create a copy of NewStyleChannelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NewStyleChannelStateCopyWith<NewStyleChannelState> get copyWith =>
      _$NewStyleChannelStateCopyWithImpl<NewStyleChannelState>(
          this as NewStyleChannelState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NewStyleChannelState &&
            const DeepCollectionEquality().equals(other.channels, channels));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(channels));

  @override
  String toString() {
    return 'NewStyleChannelState(channels: $channels)';
  }
}

/// @nodoc
abstract mixin class $NewStyleChannelStateCopyWith<$Res> {
  factory $NewStyleChannelStateCopyWith(NewStyleChannelState value,
          $Res Function(NewStyleChannelState) _then) =
      _$NewStyleChannelStateCopyWithImpl;
  @useResult
  $Res call({List<UploadChannel> channels});
}

/// @nodoc
class _$NewStyleChannelStateCopyWithImpl<$Res>
    implements $NewStyleChannelStateCopyWith<$Res> {
  _$NewStyleChannelStateCopyWithImpl(this._self, this._then);

  final NewStyleChannelState _self;
  final $Res Function(NewStyleChannelState) _then;

  /// Create a copy of NewStyleChannelState
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
              as List<UploadChannel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [NewStyleChannelState].
extension NewStyleChannelStatePatterns on NewStyleChannelState {
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
    TResult Function(_NewStyleChannelState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NewStyleChannelState() when $default != null:
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
    TResult Function(_NewStyleChannelState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NewStyleChannelState():
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
    TResult? Function(_NewStyleChannelState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NewStyleChannelState() when $default != null:
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
    TResult Function(List<UploadChannel> channels)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NewStyleChannelState() when $default != null:
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
    TResult Function(List<UploadChannel> channels) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NewStyleChannelState():
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
    TResult? Function(List<UploadChannel> channels)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NewStyleChannelState() when $default != null:
        return $default(_that.channels);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NewStyleChannelState extends NewStyleChannelState {
  const _NewStyleChannelState(
      {final List<UploadChannel> channels = const <UploadChannel>[]})
      : _channels = channels,
        super._();

  final List<UploadChannel> _channels;
  @override
  @JsonKey()
  List<UploadChannel> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  /// Create a copy of NewStyleChannelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NewStyleChannelStateCopyWith<_NewStyleChannelState> get copyWith =>
      __$NewStyleChannelStateCopyWithImpl<_NewStyleChannelState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NewStyleChannelState &&
            const DeepCollectionEquality().equals(other._channels, _channels));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_channels));

  @override
  String toString() {
    return 'NewStyleChannelState(channels: $channels)';
  }
}

/// @nodoc
abstract mixin class _$NewStyleChannelStateCopyWith<$Res>
    implements $NewStyleChannelStateCopyWith<$Res> {
  factory _$NewStyleChannelStateCopyWith(_NewStyleChannelState value,
          $Res Function(_NewStyleChannelState) _then) =
      __$NewStyleChannelStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<UploadChannel> channels});
}

/// @nodoc
class __$NewStyleChannelStateCopyWithImpl<$Res>
    implements _$NewStyleChannelStateCopyWith<$Res> {
  __$NewStyleChannelStateCopyWithImpl(this._self, this._then);

  final _NewStyleChannelState _self;
  final $Res Function(_NewStyleChannelState) _then;

  /// Create a copy of NewStyleChannelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? channels = null,
  }) {
    return _then(_NewStyleChannelState(
      channels: null == channels
          ? _self._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<UploadChannel>,
    ));
  }
}

// dart format on
