// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmarked_templates_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookmarkedTemplatesState {
  List<RecommendedTemplate> get items;
  bool get hasLoaded;
  bool get isLoading;
  Set<int> get pendingUnbookmarkIds;
  String? get errorMessage;

  /// Create a copy of BookmarkedTemplatesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookmarkedTemplatesStateCopyWith<BookmarkedTemplatesState> get copyWith =>
      _$BookmarkedTemplatesStateCopyWithImpl<BookmarkedTemplatesState>(
          this as BookmarkedTemplatesState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookmarkedTemplatesState &&
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
    return 'BookmarkedTemplatesState(items: $items, hasLoaded: $hasLoaded, isLoading: $isLoading, pendingUnbookmarkIds: $pendingUnbookmarkIds, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $BookmarkedTemplatesStateCopyWith<$Res> {
  factory $BookmarkedTemplatesStateCopyWith(BookmarkedTemplatesState value,
          $Res Function(BookmarkedTemplatesState) _then) =
      _$BookmarkedTemplatesStateCopyWithImpl;
  @useResult
  $Res call(
      {List<RecommendedTemplate> items,
      bool hasLoaded,
      bool isLoading,
      Set<int> pendingUnbookmarkIds,
      String? errorMessage});
}

/// @nodoc
class _$BookmarkedTemplatesStateCopyWithImpl<$Res>
    implements $BookmarkedTemplatesStateCopyWith<$Res> {
  _$BookmarkedTemplatesStateCopyWithImpl(this._self, this._then);

  final BookmarkedTemplatesState _self;
  final $Res Function(BookmarkedTemplatesState) _then;

  /// Create a copy of BookmarkedTemplatesState
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
              as List<RecommendedTemplate>,
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

/// Adds pattern-matching-related methods to [BookmarkedTemplatesState].
extension BookmarkedTemplatesStatePatterns on BookmarkedTemplatesState {
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
    TResult Function(_BookmarkedTemplatesState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplatesState() when $default != null:
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
    TResult Function(_BookmarkedTemplatesState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplatesState():
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
    TResult? Function(_BookmarkedTemplatesState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplatesState() when $default != null:
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
            List<RecommendedTemplate> items,
            bool hasLoaded,
            bool isLoading,
            Set<int> pendingUnbookmarkIds,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplatesState() when $default != null:
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
    TResult Function(List<RecommendedTemplate> items, bool hasLoaded,
            bool isLoading, Set<int> pendingUnbookmarkIds, String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplatesState():
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
    TResult? Function(
            List<RecommendedTemplate> items,
            bool hasLoaded,
            bool isLoading,
            Set<int> pendingUnbookmarkIds,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplatesState() when $default != null:
        return $default(_that.items, _that.hasLoaded, _that.isLoading,
            _that.pendingUnbookmarkIds, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BookmarkedTemplatesState implements BookmarkedTemplatesState {
  const _BookmarkedTemplatesState(
      {final List<RecommendedTemplate> items = const <RecommendedTemplate>[],
      this.hasLoaded = false,
      this.isLoading = false,
      final Set<int> pendingUnbookmarkIds = const <int>{},
      this.errorMessage})
      : _items = items,
        _pendingUnbookmarkIds = pendingUnbookmarkIds;

  final List<RecommendedTemplate> _items;
  @override
  @JsonKey()
  List<RecommendedTemplate> get items {
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

  /// Create a copy of BookmarkedTemplatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookmarkedTemplatesStateCopyWith<_BookmarkedTemplatesState> get copyWith =>
      __$BookmarkedTemplatesStateCopyWithImpl<_BookmarkedTemplatesState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookmarkedTemplatesState &&
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
    return 'BookmarkedTemplatesState(items: $items, hasLoaded: $hasLoaded, isLoading: $isLoading, pendingUnbookmarkIds: $pendingUnbookmarkIds, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$BookmarkedTemplatesStateCopyWith<$Res>
    implements $BookmarkedTemplatesStateCopyWith<$Res> {
  factory _$BookmarkedTemplatesStateCopyWith(_BookmarkedTemplatesState value,
          $Res Function(_BookmarkedTemplatesState) _then) =
      __$BookmarkedTemplatesStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<RecommendedTemplate> items,
      bool hasLoaded,
      bool isLoading,
      Set<int> pendingUnbookmarkIds,
      String? errorMessage});
}

/// @nodoc
class __$BookmarkedTemplatesStateCopyWithImpl<$Res>
    implements _$BookmarkedTemplatesStateCopyWith<$Res> {
  __$BookmarkedTemplatesStateCopyWithImpl(this._self, this._then);

  final _BookmarkedTemplatesState _self;
  final $Res Function(_BookmarkedTemplatesState) _then;

  /// Create a copy of BookmarkedTemplatesState
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
    return _then(_BookmarkedTemplatesState(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RecommendedTemplate>,
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
