// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmarked_hashtag_bundles_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookmarkedHashtagBundlesState {
  List<HashtagBundle> get items;
  bool get hasLoaded;
  bool get isLoading;
  Set<int> get pendingUnbookmarkIds;
  String? get errorMessage;

  /// Create a copy of BookmarkedHashtagBundlesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookmarkedHashtagBundlesStateCopyWith<BookmarkedHashtagBundlesState>
      get copyWith => _$BookmarkedHashtagBundlesStateCopyWithImpl<
              BookmarkedHashtagBundlesState>(
          this as BookmarkedHashtagBundlesState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookmarkedHashtagBundlesState &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other.pendingUnbookmarkIds, pendingUnbookmarkIds) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(items),
      hasLoaded,
      isLoading,
      const DeepCollectionEquality().hash(pendingUnbookmarkIds),
      errorMessage);

  @override
  String toString() {
    return 'BookmarkedHashtagBundlesState(items: $items, hasLoaded: $hasLoaded, isLoading: $isLoading, pendingUnbookmarkIds: $pendingUnbookmarkIds, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $BookmarkedHashtagBundlesStateCopyWith<$Res> {
  factory $BookmarkedHashtagBundlesStateCopyWith(
          BookmarkedHashtagBundlesState value,
          $Res Function(BookmarkedHashtagBundlesState) _then) =
      _$BookmarkedHashtagBundlesStateCopyWithImpl;
  @useResult
  $Res call(
      {List<HashtagBundle> items,
      bool hasLoaded,
      bool isLoading,
      Set<int> pendingUnbookmarkIds,
      String? errorMessage});
}

/// @nodoc
class _$BookmarkedHashtagBundlesStateCopyWithImpl<$Res>
    implements $BookmarkedHashtagBundlesStateCopyWith<$Res> {
  _$BookmarkedHashtagBundlesStateCopyWithImpl(this._self, this._then);

  final BookmarkedHashtagBundlesState _self;
  final $Res Function(BookmarkedHashtagBundlesState) _then;

  /// Create a copy of BookmarkedHashtagBundlesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasLoaded = null,
    Object? isLoading = null,
    Object? pendingUnbookmarkIds = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HashtagBundle>,
      hasLoaded: null == hasLoaded
          ? _self.hasLoaded
          : hasLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingUnbookmarkIds: null == pendingUnbookmarkIds
          ? _self.pendingUnbookmarkIds
          : pendingUnbookmarkIds // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BookmarkedHashtagBundlesState].
extension BookmarkedHashtagBundlesStatePatterns
    on BookmarkedHashtagBundlesState {
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
    TResult Function(_BookmarkedHashtagBundlesState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundlesState() when $default != null:
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
    TResult Function(_BookmarkedHashtagBundlesState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundlesState():
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
    TResult? Function(_BookmarkedHashtagBundlesState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundlesState() when $default != null:
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
    TResult Function(List<HashtagBundle> items, bool hasLoaded, bool isLoading,
            Set<int> pendingUnbookmarkIds, String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundlesState() when $default != null:
        return $default(_that.items, _that.hasLoaded, _that.isLoading,
            _that.pendingUnbookmarkIds, _that.errorMessage);
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
    TResult Function(List<HashtagBundle> items, bool hasLoaded, bool isLoading,
            Set<int> pendingUnbookmarkIds, String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundlesState():
        return $default(_that.items, _that.hasLoaded, _that.isLoading,
            _that.pendingUnbookmarkIds, _that.errorMessage);
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
    TResult? Function(List<HashtagBundle> items, bool hasLoaded, bool isLoading,
            Set<int> pendingUnbookmarkIds, String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundlesState() when $default != null:
        return $default(_that.items, _that.hasLoaded, _that.isLoading,
            _that.pendingUnbookmarkIds, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BookmarkedHashtagBundlesState implements BookmarkedHashtagBundlesState {
  const _BookmarkedHashtagBundlesState(
      {final List<HashtagBundle> items = const <HashtagBundle>[],
      this.hasLoaded = false,
      this.isLoading = false,
      final Set<int> pendingUnbookmarkIds = const <int>{},
      this.errorMessage})
      : _items = items,
        _pendingUnbookmarkIds = pendingUnbookmarkIds;

  final List<HashtagBundle> _items;
  @override
  @JsonKey()
  List<HashtagBundle> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final bool hasLoaded;
  @override
  @JsonKey()
  final bool isLoading;
  final Set<int> _pendingUnbookmarkIds;
  @override
  @JsonKey()
  Set<int> get pendingUnbookmarkIds {
    if (_pendingUnbookmarkIds is EqualUnmodifiableSetView)
      return _pendingUnbookmarkIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_pendingUnbookmarkIds);
  }

  @override
  final String? errorMessage;

  /// Create a copy of BookmarkedHashtagBundlesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookmarkedHashtagBundlesStateCopyWith<_BookmarkedHashtagBundlesState>
      get copyWith => __$BookmarkedHashtagBundlesStateCopyWithImpl<
          _BookmarkedHashtagBundlesState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookmarkedHashtagBundlesState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._pendingUnbookmarkIds, _pendingUnbookmarkIds) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      hasLoaded,
      isLoading,
      const DeepCollectionEquality().hash(_pendingUnbookmarkIds),
      errorMessage);

  @override
  String toString() {
    return 'BookmarkedHashtagBundlesState(items: $items, hasLoaded: $hasLoaded, isLoading: $isLoading, pendingUnbookmarkIds: $pendingUnbookmarkIds, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$BookmarkedHashtagBundlesStateCopyWith<$Res>
    implements $BookmarkedHashtagBundlesStateCopyWith<$Res> {
  factory _$BookmarkedHashtagBundlesStateCopyWith(
          _BookmarkedHashtagBundlesState value,
          $Res Function(_BookmarkedHashtagBundlesState) _then) =
      __$BookmarkedHashtagBundlesStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<HashtagBundle> items,
      bool hasLoaded,
      bool isLoading,
      Set<int> pendingUnbookmarkIds,
      String? errorMessage});
}

/// @nodoc
class __$BookmarkedHashtagBundlesStateCopyWithImpl<$Res>
    implements _$BookmarkedHashtagBundlesStateCopyWith<$Res> {
  __$BookmarkedHashtagBundlesStateCopyWithImpl(this._self, this._then);

  final _BookmarkedHashtagBundlesState _self;
  final $Res Function(_BookmarkedHashtagBundlesState) _then;

  /// Create a copy of BookmarkedHashtagBundlesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? hasLoaded = null,
    Object? isLoading = null,
    Object? pendingUnbookmarkIds = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_BookmarkedHashtagBundlesState(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HashtagBundle>,
      hasLoaded: null == hasLoaded
          ? _self.hasLoaded
          : hasLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingUnbookmarkIds: null == pendingUnbookmarkIds
          ? _self._pendingUnbookmarkIds
          : pendingUnbookmarkIds // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
