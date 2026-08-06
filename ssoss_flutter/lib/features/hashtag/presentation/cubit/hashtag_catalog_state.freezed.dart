// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hashtag_catalog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HashtagCatalogState {
  List<HashtagBundle> get items;
  String get keyword;
  int get page;
  bool get hasNext;
  bool get hasLoaded;
  bool get isLoading;
  bool get isLoadingMore;
  Set<int> get pendingBookmarkIds;
  String? get errorMessage;

  /// Create a copy of HashtagCatalogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HashtagCatalogStateCopyWith<HashtagCatalogState> get copyWith =>
      _$HashtagCatalogStateCopyWithImpl<HashtagCatalogState>(
          this as HashtagCatalogState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HashtagCatalogState &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.keyword, keyword) || other.keyword == keyword) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality()
                .equals(other.pendingBookmarkIds, pendingBookmarkIds) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(items),
      keyword,
      page,
      hasNext,
      hasLoaded,
      isLoading,
      isLoadingMore,
      const DeepCollectionEquality().hash(pendingBookmarkIds),
      errorMessage);

  @override
  String toString() {
    return 'HashtagCatalogState(items: $items, keyword: $keyword, page: $page, hasNext: $hasNext, hasLoaded: $hasLoaded, isLoading: $isLoading, isLoadingMore: $isLoadingMore, pendingBookmarkIds: $pendingBookmarkIds, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $HashtagCatalogStateCopyWith<$Res> {
  factory $HashtagCatalogStateCopyWith(
          HashtagCatalogState value, $Res Function(HashtagCatalogState) _then) =
      _$HashtagCatalogStateCopyWithImpl;
  @useResult
  $Res call(
      {List<HashtagBundle> items,
      String keyword,
      int page,
      bool hasNext,
      bool hasLoaded,
      bool isLoading,
      bool isLoadingMore,
      Set<int> pendingBookmarkIds,
      String? errorMessage});
}

/// @nodoc
class _$HashtagCatalogStateCopyWithImpl<$Res>
    implements $HashtagCatalogStateCopyWith<$Res> {
  _$HashtagCatalogStateCopyWithImpl(this._self, this._then);

  final HashtagCatalogState _self;
  final $Res Function(HashtagCatalogState) _then;

  /// Create a copy of HashtagCatalogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? keyword = null,
    Object? page = null,
    Object? hasNext = null,
    Object? hasLoaded = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? pendingBookmarkIds = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HashtagBundle>,
      keyword: null == keyword
          ? _self.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      hasLoaded: null == hasLoaded
          ? _self.hasLoaded
          : hasLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingBookmarkIds: null == pendingBookmarkIds
          ? _self.pendingBookmarkIds
          : pendingBookmarkIds // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HashtagCatalogState].
extension HashtagCatalogStatePatterns on HashtagCatalogState {
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
    TResult Function(_HashtagCatalogState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HashtagCatalogState() when $default != null:
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
    TResult Function(_HashtagCatalogState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagCatalogState():
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
    TResult? Function(_HashtagCatalogState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagCatalogState() when $default != null:
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
            List<HashtagBundle> items,
            String keyword,
            int page,
            bool hasNext,
            bool hasLoaded,
            bool isLoading,
            bool isLoadingMore,
            Set<int> pendingBookmarkIds,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HashtagCatalogState() when $default != null:
        return $default(
            _that.items,
            _that.keyword,
            _that.page,
            _that.hasNext,
            _that.hasLoaded,
            _that.isLoading,
            _that.isLoadingMore,
            _that.pendingBookmarkIds,
            _that.errorMessage);
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
            List<HashtagBundle> items,
            String keyword,
            int page,
            bool hasNext,
            bool hasLoaded,
            bool isLoading,
            bool isLoadingMore,
            Set<int> pendingBookmarkIds,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagCatalogState():
        return $default(
            _that.items,
            _that.keyword,
            _that.page,
            _that.hasNext,
            _that.hasLoaded,
            _that.isLoading,
            _that.isLoadingMore,
            _that.pendingBookmarkIds,
            _that.errorMessage);
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
            List<HashtagBundle> items,
            String keyword,
            int page,
            bool hasNext,
            bool hasLoaded,
            bool isLoading,
            bool isLoadingMore,
            Set<int> pendingBookmarkIds,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HashtagCatalogState() when $default != null:
        return $default(
            _that.items,
            _that.keyword,
            _that.page,
            _that.hasNext,
            _that.hasLoaded,
            _that.isLoading,
            _that.isLoadingMore,
            _that.pendingBookmarkIds,
            _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HashtagCatalogState implements HashtagCatalogState {
  const _HashtagCatalogState(
      {final List<HashtagBundle> items = const <HashtagBundle>[],
      this.keyword = '',
      this.page = 0,
      this.hasNext = false,
      this.hasLoaded = false,
      this.isLoading = false,
      this.isLoadingMore = false,
      final Set<int> pendingBookmarkIds = const <int>{},
      this.errorMessage})
      : _items = items,
        _pendingBookmarkIds = pendingBookmarkIds;

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
  final String keyword;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final bool hasNext;
  @override
  @JsonKey()
  final bool hasLoaded;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  final Set<int> _pendingBookmarkIds;
  @override
  @JsonKey()
  Set<int> get pendingBookmarkIds {
    if (_pendingBookmarkIds is EqualUnmodifiableSetView)
      return _pendingBookmarkIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_pendingBookmarkIds);
  }

  @override
  final String? errorMessage;

  /// Create a copy of HashtagCatalogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HashtagCatalogStateCopyWith<_HashtagCatalogState> get copyWith =>
      __$HashtagCatalogStateCopyWithImpl<_HashtagCatalogState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HashtagCatalogState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.keyword, keyword) || other.keyword == keyword) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality()
                .equals(other._pendingBookmarkIds, _pendingBookmarkIds) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      keyword,
      page,
      hasNext,
      hasLoaded,
      isLoading,
      isLoadingMore,
      const DeepCollectionEquality().hash(_pendingBookmarkIds),
      errorMessage);

  @override
  String toString() {
    return 'HashtagCatalogState(items: $items, keyword: $keyword, page: $page, hasNext: $hasNext, hasLoaded: $hasLoaded, isLoading: $isLoading, isLoadingMore: $isLoadingMore, pendingBookmarkIds: $pendingBookmarkIds, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$HashtagCatalogStateCopyWith<$Res>
    implements $HashtagCatalogStateCopyWith<$Res> {
  factory _$HashtagCatalogStateCopyWith(_HashtagCatalogState value,
          $Res Function(_HashtagCatalogState) _then) =
      __$HashtagCatalogStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<HashtagBundle> items,
      String keyword,
      int page,
      bool hasNext,
      bool hasLoaded,
      bool isLoading,
      bool isLoadingMore,
      Set<int> pendingBookmarkIds,
      String? errorMessage});
}

/// @nodoc
class __$HashtagCatalogStateCopyWithImpl<$Res>
    implements _$HashtagCatalogStateCopyWith<$Res> {
  __$HashtagCatalogStateCopyWithImpl(this._self, this._then);

  final _HashtagCatalogState _self;
  final $Res Function(_HashtagCatalogState) _then;

  /// Create a copy of HashtagCatalogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? keyword = null,
    Object? page = null,
    Object? hasNext = null,
    Object? hasLoaded = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? pendingBookmarkIds = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_HashtagCatalogState(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HashtagBundle>,
      keyword: null == keyword
          ? _self.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      hasLoaded: null == hasLoaded
          ? _self.hasLoaded
          : hasLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingBookmarkIds: null == pendingBookmarkIds
          ? _self._pendingBookmarkIds
          : pendingBookmarkIds // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
