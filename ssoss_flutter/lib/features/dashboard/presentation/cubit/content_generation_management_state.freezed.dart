// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_generation_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentGenerationManagementState {
  List<ContentManagementItem> get items;
  String get selectedFilter;
  bool get isLatestFirst;
  String? get openedMenuItemId;
  bool get isLoading;
  String? get errorMessage;

  /// Create a copy of ContentGenerationManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentGenerationManagementStateCopyWith<ContentGenerationManagementState>
      get copyWith => _$ContentGenerationManagementStateCopyWithImpl<
              ContentGenerationManagementState>(
          this as ContentGenerationManagementState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentGenerationManagementState &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter) &&
            (identical(other.isLatestFirst, isLatestFirst) ||
                other.isLatestFirst == isLatestFirst) &&
            (identical(other.openedMenuItemId, openedMenuItemId) ||
                other.openedMenuItemId == openedMenuItemId) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(items),
      selectedFilter,
      isLatestFirst,
      openedMenuItemId,
      isLoading,
      errorMessage);

  @override
  String toString() {
    return 'ContentGenerationManagementState(items: $items, selectedFilter: $selectedFilter, isLatestFirst: $isLatestFirst, openedMenuItemId: $openedMenuItemId, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ContentGenerationManagementStateCopyWith<$Res> {
  factory $ContentGenerationManagementStateCopyWith(
          ContentGenerationManagementState value,
          $Res Function(ContentGenerationManagementState) _then) =
      _$ContentGenerationManagementStateCopyWithImpl;
  @useResult
  $Res call(
      {List<ContentManagementItem> items,
      String selectedFilter,
      bool isLatestFirst,
      String? openedMenuItemId,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$ContentGenerationManagementStateCopyWithImpl<$Res>
    implements $ContentGenerationManagementStateCopyWith<$Res> {
  _$ContentGenerationManagementStateCopyWithImpl(this._self, this._then);

  final ContentGenerationManagementState _self;
  final $Res Function(ContentGenerationManagementState) _then;

  /// Create a copy of ContentGenerationManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? selectedFilter = null,
    Object? isLatestFirst = null,
    Object? openedMenuItemId = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ContentManagementItem>,
      selectedFilter: null == selectedFilter
          ? _self.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as String,
      isLatestFirst: null == isLatestFirst
          ? _self.isLatestFirst
          : isLatestFirst // ignore: cast_nullable_to_non_nullable
              as bool,
      openedMenuItemId: freezed == openedMenuItemId
          ? _self.openedMenuItemId
          : openedMenuItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentGenerationManagementState].
extension ContentGenerationManagementStatePatterns
    on ContentGenerationManagementState {
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
    TResult Function(_ContentGenerationManagementState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentGenerationManagementState() when $default != null:
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
    TResult Function(_ContentGenerationManagementState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentGenerationManagementState():
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
    TResult? Function(_ContentGenerationManagementState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentGenerationManagementState() when $default != null:
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
            List<ContentManagementItem> items,
            String selectedFilter,
            bool isLatestFirst,
            String? openedMenuItemId,
            bool isLoading,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentGenerationManagementState() when $default != null:
        return $default(_that.items, _that.selectedFilter, _that.isLatestFirst,
            _that.openedMenuItemId, _that.isLoading, _that.errorMessage);
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
            List<ContentManagementItem> items,
            String selectedFilter,
            bool isLatestFirst,
            String? openedMenuItemId,
            bool isLoading,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentGenerationManagementState():
        return $default(_that.items, _that.selectedFilter, _that.isLatestFirst,
            _that.openedMenuItemId, _that.isLoading, _that.errorMessage);
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
            List<ContentManagementItem> items,
            String selectedFilter,
            bool isLatestFirst,
            String? openedMenuItemId,
            bool isLoading,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentGenerationManagementState() when $default != null:
        return $default(_that.items, _that.selectedFilter, _that.isLatestFirst,
            _that.openedMenuItemId, _that.isLoading, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ContentGenerationManagementState
    extends ContentGenerationManagementState {
  const _ContentGenerationManagementState(
      {final List<ContentManagementItem> items =
          const <ContentManagementItem>[],
      this.selectedFilter = '전체',
      this.isLatestFirst = true,
      this.openedMenuItemId,
      this.isLoading = false,
      this.errorMessage})
      : _items = items,
        super._();

  final List<ContentManagementItem> _items;
  @override
  @JsonKey()
  List<ContentManagementItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final String selectedFilter;
  @override
  @JsonKey()
  final bool isLatestFirst;
  @override
  final String? openedMenuItemId;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  /// Create a copy of ContentGenerationManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentGenerationManagementStateCopyWith<_ContentGenerationManagementState>
      get copyWith => __$ContentGenerationManagementStateCopyWithImpl<
          _ContentGenerationManagementState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentGenerationManagementState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter) &&
            (identical(other.isLatestFirst, isLatestFirst) ||
                other.isLatestFirst == isLatestFirst) &&
            (identical(other.openedMenuItemId, openedMenuItemId) ||
                other.openedMenuItemId == openedMenuItemId) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      selectedFilter,
      isLatestFirst,
      openedMenuItemId,
      isLoading,
      errorMessage);

  @override
  String toString() {
    return 'ContentGenerationManagementState(items: $items, selectedFilter: $selectedFilter, isLatestFirst: $isLatestFirst, openedMenuItemId: $openedMenuItemId, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$ContentGenerationManagementStateCopyWith<$Res>
    implements $ContentGenerationManagementStateCopyWith<$Res> {
  factory _$ContentGenerationManagementStateCopyWith(
          _ContentGenerationManagementState value,
          $Res Function(_ContentGenerationManagementState) _then) =
      __$ContentGenerationManagementStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<ContentManagementItem> items,
      String selectedFilter,
      bool isLatestFirst,
      String? openedMenuItemId,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$ContentGenerationManagementStateCopyWithImpl<$Res>
    implements _$ContentGenerationManagementStateCopyWith<$Res> {
  __$ContentGenerationManagementStateCopyWithImpl(this._self, this._then);

  final _ContentGenerationManagementState _self;
  final $Res Function(_ContentGenerationManagementState) _then;

  /// Create a copy of ContentGenerationManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? selectedFilter = null,
    Object? isLatestFirst = null,
    Object? openedMenuItemId = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_ContentGenerationManagementState(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ContentManagementItem>,
      selectedFilter: null == selectedFilter
          ? _self.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as String,
      isLatestFirst: null == isLatestFirst
          ? _self.isLatestFirst
          : isLatestFirst // ignore: cast_nullable_to_non_nullable
              as bool,
      openedMenuItemId: freezed == openedMenuItemId
          ? _self.openedMenuItemId
          : openedMenuItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
