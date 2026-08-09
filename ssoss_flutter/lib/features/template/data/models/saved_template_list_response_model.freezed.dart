// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_template_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedTemplateListItemModel {
  int get savedTemplateId;
  String get category;
  String get title;
  String get description;
  String get savedAt;

  /// Create a copy of SavedTemplateListItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedTemplateListItemModelCopyWith<SavedTemplateListItemModel>
      get copyWith =>
          _$SavedTemplateListItemModelCopyWithImpl<SavedTemplateListItemModel>(
              this as SavedTemplateListItemModel, _$identity);

  /// Serializes this SavedTemplateListItemModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedTemplateListItemModel &&
            (identical(other.savedTemplateId, savedTemplateId) ||
                other.savedTemplateId == savedTemplateId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, savedTemplateId, category, title, description, savedAt);

  @override
  String toString() {
    return 'SavedTemplateListItemModel(savedTemplateId: $savedTemplateId, category: $category, title: $title, description: $description, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class $SavedTemplateListItemModelCopyWith<$Res> {
  factory $SavedTemplateListItemModelCopyWith(SavedTemplateListItemModel value,
          $Res Function(SavedTemplateListItemModel) _then) =
      _$SavedTemplateListItemModelCopyWithImpl;
  @useResult
  $Res call(
      {int savedTemplateId,
      String category,
      String title,
      String description,
      String savedAt});
}

/// @nodoc
class _$SavedTemplateListItemModelCopyWithImpl<$Res>
    implements $SavedTemplateListItemModelCopyWith<$Res> {
  _$SavedTemplateListItemModelCopyWithImpl(this._self, this._then);

  final SavedTemplateListItemModel _self;
  final $Res Function(SavedTemplateListItemModel) _then;

  /// Create a copy of SavedTemplateListItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedTemplateId = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? savedAt = null,
  }) {
    return _then(_self.copyWith(
      savedTemplateId: null == savedTemplateId
          ? _self.savedTemplateId
          : savedTemplateId // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedTemplateListItemModel].
extension SavedTemplateListItemModelPatterns on SavedTemplateListItemModel {
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
    TResult Function(_SavedTemplateListItemModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListItemModel() when $default != null:
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
    TResult Function(_SavedTemplateListItemModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListItemModel():
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
    TResult? Function(_SavedTemplateListItemModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListItemModel() when $default != null:
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
    TResult Function(int savedTemplateId, String category, String title,
            String description, String savedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListItemModel() when $default != null:
        return $default(_that.savedTemplateId, _that.category, _that.title,
            _that.description, _that.savedAt);
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
    TResult Function(int savedTemplateId, String category, String title,
            String description, String savedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListItemModel():
        return $default(_that.savedTemplateId, _that.category, _that.title,
            _that.description, _that.savedAt);
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
    TResult? Function(int savedTemplateId, String category, String title,
            String description, String savedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListItemModel() when $default != null:
        return $default(_that.savedTemplateId, _that.category, _that.title,
            _that.description, _that.savedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SavedTemplateListItemModel implements SavedTemplateListItemModel {
  const _SavedTemplateListItemModel(
      {required this.savedTemplateId,
      required this.category,
      required this.title,
      required this.description,
      required this.savedAt});
  factory _SavedTemplateListItemModel.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateListItemModelFromJson(json);

  @override
  final int savedTemplateId;
  @override
  final String category;
  @override
  final String title;
  @override
  final String description;
  @override
  final String savedAt;

  /// Create a copy of SavedTemplateListItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedTemplateListItemModelCopyWith<_SavedTemplateListItemModel>
      get copyWith => __$SavedTemplateListItemModelCopyWithImpl<
          _SavedTemplateListItemModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SavedTemplateListItemModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedTemplateListItemModel &&
            (identical(other.savedTemplateId, savedTemplateId) ||
                other.savedTemplateId == savedTemplateId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, savedTemplateId, category, title, description, savedAt);

  @override
  String toString() {
    return 'SavedTemplateListItemModel(savedTemplateId: $savedTemplateId, category: $category, title: $title, description: $description, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class _$SavedTemplateListItemModelCopyWith<$Res>
    implements $SavedTemplateListItemModelCopyWith<$Res> {
  factory _$SavedTemplateListItemModelCopyWith(
          _SavedTemplateListItemModel value,
          $Res Function(_SavedTemplateListItemModel) _then) =
      __$SavedTemplateListItemModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int savedTemplateId,
      String category,
      String title,
      String description,
      String savedAt});
}

/// @nodoc
class __$SavedTemplateListItemModelCopyWithImpl<$Res>
    implements _$SavedTemplateListItemModelCopyWith<$Res> {
  __$SavedTemplateListItemModelCopyWithImpl(this._self, this._then);

  final _SavedTemplateListItemModel _self;
  final $Res Function(_SavedTemplateListItemModel) _then;

  /// Create a copy of SavedTemplateListItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? savedTemplateId = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? savedAt = null,
  }) {
    return _then(_SavedTemplateListItemModel(
      savedTemplateId: null == savedTemplateId
          ? _self.savedTemplateId
          : savedTemplateId // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SavedTemplateListResponseModel {
  int get totalCount;
  int get page;
  int get size;
  bool get hasNext;
  List<SavedTemplateListItemModel> get savedTemplates;

  /// Create a copy of SavedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedTemplateListResponseModelCopyWith<SavedTemplateListResponseModel>
      get copyWith => _$SavedTemplateListResponseModelCopyWithImpl<
              SavedTemplateListResponseModel>(
          this as SavedTemplateListResponseModel, _$identity);

  /// Serializes this SavedTemplateListResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedTemplateListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality()
                .equals(other.savedTemplates, savedTemplates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(savedTemplates));

  @override
  String toString() {
    return 'SavedTemplateListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, savedTemplates: $savedTemplates)';
  }
}

/// @nodoc
abstract mixin class $SavedTemplateListResponseModelCopyWith<$Res> {
  factory $SavedTemplateListResponseModelCopyWith(
          SavedTemplateListResponseModel value,
          $Res Function(SavedTemplateListResponseModel) _then) =
      _$SavedTemplateListResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<SavedTemplateListItemModel> savedTemplates});
}

/// @nodoc
class _$SavedTemplateListResponseModelCopyWithImpl<$Res>
    implements $SavedTemplateListResponseModelCopyWith<$Res> {
  _$SavedTemplateListResponseModelCopyWithImpl(this._self, this._then);

  final SavedTemplateListResponseModel _self;
  final $Res Function(SavedTemplateListResponseModel) _then;

  /// Create a copy of SavedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? savedTemplates = null,
  }) {
    return _then(_self.copyWith(
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      savedTemplates: null == savedTemplates
          ? _self.savedTemplates
          : savedTemplates // ignore: cast_nullable_to_non_nullable
              as List<SavedTemplateListItemModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedTemplateListResponseModel].
extension SavedTemplateListResponseModelPatterns
    on SavedTemplateListResponseModel {
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
    TResult Function(_SavedTemplateListResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListResponseModel() when $default != null:
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
    TResult Function(_SavedTemplateListResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListResponseModel():
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
    TResult? Function(_SavedTemplateListResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListResponseModel() when $default != null:
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
    TResult Function(int totalCount, int page, int size, bool hasNext,
            List<SavedTemplateListItemModel> savedTemplates)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.savedTemplates);
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
    TResult Function(int totalCount, int page, int size, bool hasNext,
            List<SavedTemplateListItemModel> savedTemplates)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListResponseModel():
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.savedTemplates);
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
    TResult? Function(int totalCount, int page, int size, bool hasNext,
            List<SavedTemplateListItemModel> savedTemplates)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.savedTemplates);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SavedTemplateListResponseModel
    implements SavedTemplateListResponseModel {
  const _SavedTemplateListResponseModel(
      {required this.totalCount,
      required this.page,
      required this.size,
      required this.hasNext,
      final List<SavedTemplateListItemModel> savedTemplates =
          const <SavedTemplateListItemModel>[]})
      : _savedTemplates = savedTemplates;
  factory _SavedTemplateListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateListResponseModelFromJson(json);

  @override
  final int totalCount;
  @override
  final int page;
  @override
  final int size;
  @override
  final bool hasNext;
  final List<SavedTemplateListItemModel> _savedTemplates;
  @override
  @JsonKey()
  List<SavedTemplateListItemModel> get savedTemplates {
    if (_savedTemplates is EqualUnmodifiableListView) return _savedTemplates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedTemplates);
  }

  /// Create a copy of SavedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedTemplateListResponseModelCopyWith<_SavedTemplateListResponseModel>
      get copyWith => __$SavedTemplateListResponseModelCopyWithImpl<
          _SavedTemplateListResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SavedTemplateListResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedTemplateListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality()
                .equals(other._savedTemplates, _savedTemplates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(_savedTemplates));

  @override
  String toString() {
    return 'SavedTemplateListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, savedTemplates: $savedTemplates)';
  }
}

/// @nodoc
abstract mixin class _$SavedTemplateListResponseModelCopyWith<$Res>
    implements $SavedTemplateListResponseModelCopyWith<$Res> {
  factory _$SavedTemplateListResponseModelCopyWith(
          _SavedTemplateListResponseModel value,
          $Res Function(_SavedTemplateListResponseModel) _then) =
      __$SavedTemplateListResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<SavedTemplateListItemModel> savedTemplates});
}

/// @nodoc
class __$SavedTemplateListResponseModelCopyWithImpl<$Res>
    implements _$SavedTemplateListResponseModelCopyWith<$Res> {
  __$SavedTemplateListResponseModelCopyWithImpl(this._self, this._then);

  final _SavedTemplateListResponseModel _self;
  final $Res Function(_SavedTemplateListResponseModel) _then;

  /// Create a copy of SavedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? savedTemplates = null,
  }) {
    return _then(_SavedTemplateListResponseModel(
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      savedTemplates: null == savedTemplates
          ? _self._savedTemplates
          : savedTemplates // ignore: cast_nullable_to_non_nullable
              as List<SavedTemplateListItemModel>,
    ));
  }
}

// dart format on
