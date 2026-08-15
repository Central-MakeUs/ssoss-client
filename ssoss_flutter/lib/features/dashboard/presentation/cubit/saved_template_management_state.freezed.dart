// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_template_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedTemplateManagementState {
  List<SavedContentTemplateManagementItem> get items;
  SavedTemplateSort get sort;
  int get totalCount;
  int get page;
  bool get hasNext;
  String? get openedMenuItemId;
  bool get isLoading;
  bool get isLoadingMore;
  bool get isRefreshing;
  String? get errorMessage;

  /// Create a copy of SavedTemplateManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedTemplateManagementStateCopyWith<SavedTemplateManagementState>
      get copyWith => _$SavedTemplateManagementStateCopyWithImpl<
              SavedTemplateManagementState>(
          this as SavedTemplateManagementState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedTemplateManagementState &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.openedMenuItemId, openedMenuItemId) ||
                other.openedMenuItemId == openedMenuItemId) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(items),
      sort,
      totalCount,
      page,
      hasNext,
      openedMenuItemId,
      isLoading,
      isLoadingMore,
      isRefreshing,
      errorMessage);

  @override
  String toString() {
    return 'SavedTemplateManagementState(items: $items, sort: $sort, totalCount: $totalCount, page: $page, hasNext: $hasNext, openedMenuItemId: $openedMenuItemId, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $SavedTemplateManagementStateCopyWith<$Res> {
  factory $SavedTemplateManagementStateCopyWith(
          SavedTemplateManagementState value,
          $Res Function(SavedTemplateManagementState) _then) =
      _$SavedTemplateManagementStateCopyWithImpl;
  @useResult
  $Res call(
      {List<SavedContentTemplateManagementItem> items,
      SavedTemplateSort sort,
      int totalCount,
      int page,
      bool hasNext,
      String? openedMenuItemId,
      bool isLoading,
      bool isLoadingMore,
      bool isRefreshing,
      String? errorMessage});
}

/// @nodoc
class _$SavedTemplateManagementStateCopyWithImpl<$Res>
    implements $SavedTemplateManagementStateCopyWith<$Res> {
  _$SavedTemplateManagementStateCopyWithImpl(this._self, this._then);

  final SavedTemplateManagementState _self;
  final $Res Function(SavedTemplateManagementState) _then;

  /// Create a copy of SavedTemplateManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? sort = null,
    Object? totalCount = null,
    Object? page = null,
    Object? hasNext = null,
    Object? openedMenuItemId = freezed,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? isRefreshing = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SavedContentTemplateManagementItem>,
      sort: null == sort
          ? _self.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as SavedTemplateSort,
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      openedMenuItemId: freezed == openedMenuItemId
          ? _self.openedMenuItemId
          : openedMenuItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefreshing: null == isRefreshing
          ? _self.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedTemplateManagementState].
extension SavedTemplateManagementStatePatterns on SavedTemplateManagementState {
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
    TResult Function(_SavedTemplateManagementState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateManagementState() when $default != null:
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
    TResult Function(_SavedTemplateManagementState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateManagementState():
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
    TResult? Function(_SavedTemplateManagementState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateManagementState() when $default != null:
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
            List<SavedContentTemplateManagementItem> items,
            SavedTemplateSort sort,
            int totalCount,
            int page,
            bool hasNext,
            String? openedMenuItemId,
            bool isLoading,
            bool isLoadingMore,
            bool isRefreshing,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateManagementState() when $default != null:
        return $default(
            _that.items,
            _that.sort,
            _that.totalCount,
            _that.page,
            _that.hasNext,
            _that.openedMenuItemId,
            _that.isLoading,
            _that.isLoadingMore,
            _that.isRefreshing,
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
            List<SavedContentTemplateManagementItem> items,
            SavedTemplateSort sort,
            int totalCount,
            int page,
            bool hasNext,
            String? openedMenuItemId,
            bool isLoading,
            bool isLoadingMore,
            bool isRefreshing,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateManagementState():
        return $default(
            _that.items,
            _that.sort,
            _that.totalCount,
            _that.page,
            _that.hasNext,
            _that.openedMenuItemId,
            _that.isLoading,
            _that.isLoadingMore,
            _that.isRefreshing,
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
            List<SavedContentTemplateManagementItem> items,
            SavedTemplateSort sort,
            int totalCount,
            int page,
            bool hasNext,
            String? openedMenuItemId,
            bool isLoading,
            bool isLoadingMore,
            bool isRefreshing,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateManagementState() when $default != null:
        return $default(
            _that.items,
            _that.sort,
            _that.totalCount,
            _that.page,
            _that.hasNext,
            _that.openedMenuItemId,
            _that.isLoading,
            _that.isLoadingMore,
            _that.isRefreshing,
            _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SavedTemplateManagementState extends SavedTemplateManagementState {
  const _SavedTemplateManagementState(
      {final List<SavedContentTemplateManagementItem> items =
          const <SavedContentTemplateManagementItem>[],
      this.sort = SavedTemplateSort.latest,
      this.totalCount = 0,
      this.page = 0,
      this.hasNext = false,
      this.openedMenuItemId,
      this.isLoading = false,
      this.isLoadingMore = false,
      this.isRefreshing = false,
      this.errorMessage})
      : _items = items,
        super._();

  final List<SavedContentTemplateManagementItem> _items;
  @override
  @JsonKey()
  List<SavedContentTemplateManagementItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final SavedTemplateSort sort;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final bool hasNext;
  @override
  final String? openedMenuItemId;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool isRefreshing;
  @override
  final String? errorMessage;

  /// Create a copy of SavedTemplateManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedTemplateManagementStateCopyWith<_SavedTemplateManagementState>
      get copyWith => __$SavedTemplateManagementStateCopyWithImpl<
          _SavedTemplateManagementState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedTemplateManagementState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.openedMenuItemId, openedMenuItemId) ||
                other.openedMenuItemId == openedMenuItemId) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      sort,
      totalCount,
      page,
      hasNext,
      openedMenuItemId,
      isLoading,
      isLoadingMore,
      isRefreshing,
      errorMessage);

  @override
  String toString() {
    return 'SavedTemplateManagementState(items: $items, sort: $sort, totalCount: $totalCount, page: $page, hasNext: $hasNext, openedMenuItemId: $openedMenuItemId, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$SavedTemplateManagementStateCopyWith<$Res>
    implements $SavedTemplateManagementStateCopyWith<$Res> {
  factory _$SavedTemplateManagementStateCopyWith(
          _SavedTemplateManagementState value,
          $Res Function(_SavedTemplateManagementState) _then) =
      __$SavedTemplateManagementStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<SavedContentTemplateManagementItem> items,
      SavedTemplateSort sort,
      int totalCount,
      int page,
      bool hasNext,
      String? openedMenuItemId,
      bool isLoading,
      bool isLoadingMore,
      bool isRefreshing,
      String? errorMessage});
}

/// @nodoc
class __$SavedTemplateManagementStateCopyWithImpl<$Res>
    implements _$SavedTemplateManagementStateCopyWith<$Res> {
  __$SavedTemplateManagementStateCopyWithImpl(this._self, this._then);

  final _SavedTemplateManagementState _self;
  final $Res Function(_SavedTemplateManagementState) _then;

  /// Create a copy of SavedTemplateManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? sort = null,
    Object? totalCount = null,
    Object? page = null,
    Object? hasNext = null,
    Object? openedMenuItemId = freezed,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? isRefreshing = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_SavedTemplateManagementState(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SavedContentTemplateManagementItem>,
      sort: null == sort
          ? _self.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as SavedTemplateSort,
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      openedMenuItemId: freezed == openedMenuItemId
          ? _self.openedMenuItemId
          : openedMenuItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefreshing: null == isRefreshing
          ? _self.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
