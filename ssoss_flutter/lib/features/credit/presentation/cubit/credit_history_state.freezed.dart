// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreditHistoryState {
  CreditLedgerFilter get filter;
  List<CreditLedger> get items;
  int get page;
  bool get hasNext;
  bool get isLoading;
  bool get isLoadingMore;
  String? get errorMessage;

  /// Create a copy of CreditHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreditHistoryStateCopyWith<CreditHistoryState> get copyWith =>
      _$CreditHistoryStateCopyWithImpl<CreditHistoryState>(
          this as CreditHistoryState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreditHistoryState &&
            (identical(other.filter, filter) || other.filter == filter) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      filter,
      const DeepCollectionEquality().hash(items),
      page,
      hasNext,
      isLoading,
      isLoadingMore,
      errorMessage);

  @override
  String toString() {
    return 'CreditHistoryState(filter: $filter, items: $items, page: $page, hasNext: $hasNext, isLoading: $isLoading, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $CreditHistoryStateCopyWith<$Res> {
  factory $CreditHistoryStateCopyWith(
          CreditHistoryState value, $Res Function(CreditHistoryState) _then) =
      _$CreditHistoryStateCopyWithImpl;
  @useResult
  $Res call(
      {CreditLedgerFilter filter,
      List<CreditLedger> items,
      int page,
      bool hasNext,
      bool isLoading,
      bool isLoadingMore,
      String? errorMessage});
}

/// @nodoc
class _$CreditHistoryStateCopyWithImpl<$Res>
    implements $CreditHistoryStateCopyWith<$Res> {
  _$CreditHistoryStateCopyWithImpl(this._self, this._then);

  final CreditHistoryState _self;
  final $Res Function(CreditHistoryState) _then;

  /// Create a copy of CreditHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
    Object? items = null,
    Object? page = null,
    Object? hasNext = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      filter: null == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as CreditLedgerFilter,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CreditLedger>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreditHistoryState].
extension CreditHistoryStatePatterns on CreditHistoryState {
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
    TResult Function(_CreditHistoryState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditHistoryState() when $default != null:
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
    TResult Function(_CreditHistoryState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditHistoryState():
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
    TResult? Function(_CreditHistoryState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditHistoryState() when $default != null:
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
            CreditLedgerFilter filter,
            List<CreditLedger> items,
            int page,
            bool hasNext,
            bool isLoading,
            bool isLoadingMore,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditHistoryState() when $default != null:
        return $default(_that.filter, _that.items, _that.page, _that.hasNext,
            _that.isLoading, _that.isLoadingMore, _that.errorMessage);
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
            CreditLedgerFilter filter,
            List<CreditLedger> items,
            int page,
            bool hasNext,
            bool isLoading,
            bool isLoadingMore,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditHistoryState():
        return $default(_that.filter, _that.items, _that.page, _that.hasNext,
            _that.isLoading, _that.isLoadingMore, _that.errorMessage);
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
            CreditLedgerFilter filter,
            List<CreditLedger> items,
            int page,
            bool hasNext,
            bool isLoading,
            bool isLoadingMore,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditHistoryState() when $default != null:
        return $default(_that.filter, _that.items, _that.page, _that.hasNext,
            _that.isLoading, _that.isLoadingMore, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CreditHistoryState implements CreditHistoryState {
  const _CreditHistoryState(
      {this.filter = CreditLedgerFilter.all,
      final List<CreditLedger> items = const <CreditLedger>[],
      this.page = 0,
      this.hasNext = false,
      this.isLoading = false,
      this.isLoadingMore = false,
      this.errorMessage})
      : _items = items;

  @override
  @JsonKey()
  final CreditLedgerFilter filter;
  final List<CreditLedger> _items;
  @override
  @JsonKey()
  List<CreditLedger> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final bool hasNext;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final String? errorMessage;

  /// Create a copy of CreditHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreditHistoryStateCopyWith<_CreditHistoryState> get copyWith =>
      __$CreditHistoryStateCopyWithImpl<_CreditHistoryState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreditHistoryState &&
            (identical(other.filter, filter) || other.filter == filter) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      filter,
      const DeepCollectionEquality().hash(_items),
      page,
      hasNext,
      isLoading,
      isLoadingMore,
      errorMessage);

  @override
  String toString() {
    return 'CreditHistoryState(filter: $filter, items: $items, page: $page, hasNext: $hasNext, isLoading: $isLoading, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$CreditHistoryStateCopyWith<$Res>
    implements $CreditHistoryStateCopyWith<$Res> {
  factory _$CreditHistoryStateCopyWith(
          _CreditHistoryState value, $Res Function(_CreditHistoryState) _then) =
      __$CreditHistoryStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {CreditLedgerFilter filter,
      List<CreditLedger> items,
      int page,
      bool hasNext,
      bool isLoading,
      bool isLoadingMore,
      String? errorMessage});
}

/// @nodoc
class __$CreditHistoryStateCopyWithImpl<$Res>
    implements _$CreditHistoryStateCopyWith<$Res> {
  __$CreditHistoryStateCopyWithImpl(this._self, this._then);

  final _CreditHistoryState _self;
  final $Res Function(_CreditHistoryState) _then;

  /// Create a copy of CreditHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filter = null,
    Object? items = null,
    Object? page = null,
    Object? hasNext = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_CreditHistoryState(
      filter: null == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as CreditLedgerFilter,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CreditLedger>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
