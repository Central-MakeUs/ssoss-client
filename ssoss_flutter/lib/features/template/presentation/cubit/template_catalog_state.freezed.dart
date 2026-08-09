// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_catalog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplateCatalogState {
  List<RecommendedTemplate> get items;
  RecommendedTemplateCategory? get category;
  int get page;
  bool get hasNext;
  bool get hasLoaded;
  bool get isLoading;
  bool get isLoadingMore;
  String? get errorMessage;

  /// Create a copy of TemplateCatalogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TemplateCatalogStateCopyWith<TemplateCatalogState> get copyWith =>
      _$TemplateCatalogStateCopyWithImpl<TemplateCatalogState>(
          this as TemplateCatalogState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TemplateCatalogState &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded) &&
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
      const DeepCollectionEquality().hash(items),
      category,
      page,
      hasNext,
      hasLoaded,
      isLoading,
      isLoadingMore,
      errorMessage);

  @override
  String toString() {
    return 'TemplateCatalogState(items: $items, category: $category, page: $page, hasNext: $hasNext, hasLoaded: $hasLoaded, isLoading: $isLoading, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $TemplateCatalogStateCopyWith<$Res> {
  factory $TemplateCatalogStateCopyWith(TemplateCatalogState value,
          $Res Function(TemplateCatalogState) _then) =
      _$TemplateCatalogStateCopyWithImpl;
  @useResult
  $Res call(
      {List<RecommendedTemplate> items,
      RecommendedTemplateCategory? category,
      int page,
      bool hasNext,
      bool hasLoaded,
      bool isLoading,
      bool isLoadingMore,
      String? errorMessage});
}

/// @nodoc
class _$TemplateCatalogStateCopyWithImpl<$Res>
    implements $TemplateCatalogStateCopyWith<$Res> {
  _$TemplateCatalogStateCopyWithImpl(this._self, this._then);

  final TemplateCatalogState _self;
  final $Res Function(TemplateCatalogState) _then;

  /// Create a copy of TemplateCatalogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? category = freezed,
    Object? page = null,
    Object? hasNext = null,
    Object? hasLoaded = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RecommendedTemplate>,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as RecommendedTemplateCategory?,
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
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TemplateCatalogState].
extension TemplateCatalogStatePatterns on TemplateCatalogState {
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
    TResult Function(_TemplateCatalogState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TemplateCatalogState() when $default != null:
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
    TResult Function(_TemplateCatalogState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateCatalogState():
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
    TResult? Function(_TemplateCatalogState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateCatalogState() when $default != null:
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
            RecommendedTemplateCategory? category,
            int page,
            bool hasNext,
            bool hasLoaded,
            bool isLoading,
            bool isLoadingMore,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TemplateCatalogState() when $default != null:
        return $default(
            _that.items,
            _that.category,
            _that.page,
            _that.hasNext,
            _that.hasLoaded,
            _that.isLoading,
            _that.isLoadingMore,
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
            List<RecommendedTemplate> items,
            RecommendedTemplateCategory? category,
            int page,
            bool hasNext,
            bool hasLoaded,
            bool isLoading,
            bool isLoadingMore,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateCatalogState():
        return $default(
            _that.items,
            _that.category,
            _that.page,
            _that.hasNext,
            _that.hasLoaded,
            _that.isLoading,
            _that.isLoadingMore,
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
            List<RecommendedTemplate> items,
            RecommendedTemplateCategory? category,
            int page,
            bool hasNext,
            bool hasLoaded,
            bool isLoading,
            bool isLoadingMore,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateCatalogState() when $default != null:
        return $default(
            _that.items,
            _that.category,
            _that.page,
            _that.hasNext,
            _that.hasLoaded,
            _that.isLoading,
            _that.isLoadingMore,
            _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TemplateCatalogState implements TemplateCatalogState {
  const _TemplateCatalogState(
      {final List<RecommendedTemplate> items = const <RecommendedTemplate>[],
      this.category,
      this.page = 0,
      this.hasNext = false,
      this.hasLoaded = false,
      this.isLoading = false,
      this.isLoadingMore = false,
      this.errorMessage})
      : _items = items;

  final List<RecommendedTemplate> _items;
  @override
  @JsonKey()
  List<RecommendedTemplate> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final RecommendedTemplateCategory? category;
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
  @override
  final String? errorMessage;

  /// Create a copy of TemplateCatalogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TemplateCatalogStateCopyWith<_TemplateCatalogState> get copyWith =>
      __$TemplateCatalogStateCopyWithImpl<_TemplateCatalogState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TemplateCatalogState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded) &&
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
      const DeepCollectionEquality().hash(_items),
      category,
      page,
      hasNext,
      hasLoaded,
      isLoading,
      isLoadingMore,
      errorMessage);

  @override
  String toString() {
    return 'TemplateCatalogState(items: $items, category: $category, page: $page, hasNext: $hasNext, hasLoaded: $hasLoaded, isLoading: $isLoading, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$TemplateCatalogStateCopyWith<$Res>
    implements $TemplateCatalogStateCopyWith<$Res> {
  factory _$TemplateCatalogStateCopyWith(_TemplateCatalogState value,
          $Res Function(_TemplateCatalogState) _then) =
      __$TemplateCatalogStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<RecommendedTemplate> items,
      RecommendedTemplateCategory? category,
      int page,
      bool hasNext,
      bool hasLoaded,
      bool isLoading,
      bool isLoadingMore,
      String? errorMessage});
}

/// @nodoc
class __$TemplateCatalogStateCopyWithImpl<$Res>
    implements _$TemplateCatalogStateCopyWith<$Res> {
  __$TemplateCatalogStateCopyWithImpl(this._self, this._then);

  final _TemplateCatalogState _self;
  final $Res Function(_TemplateCatalogState) _then;

  /// Create a copy of TemplateCatalogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? category = freezed,
    Object? page = null,
    Object? hasNext = null,
    Object? hasLoaded = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_TemplateCatalogState(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RecommendedTemplate>,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as RecommendedTemplateCategory?,
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
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
