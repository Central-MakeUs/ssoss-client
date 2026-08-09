// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommended_template_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecommendedTemplateModel {
  int get id;
  String get category;
  String get title;
  String get description;
  List<String> get recommendedChannels;
  bool get bookmarked;

  /// Create a copy of RecommendedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecommendedTemplateModelCopyWith<RecommendedTemplateModel> get copyWith =>
      _$RecommendedTemplateModelCopyWithImpl<RecommendedTemplateModel>(
          this as RecommendedTemplateModel, _$identity);

  /// Serializes this RecommendedTemplateModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecommendedTemplateModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other.recommendedChannels, recommendedChannels) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, category, title, description,
      const DeepCollectionEquality().hash(recommendedChannels), bookmarked);

  @override
  String toString() {
    return 'RecommendedTemplateModel(id: $id, category: $category, title: $title, description: $description, recommendedChannels: $recommendedChannels, bookmarked: $bookmarked)';
  }
}

/// @nodoc
abstract mixin class $RecommendedTemplateModelCopyWith<$Res> {
  factory $RecommendedTemplateModelCopyWith(RecommendedTemplateModel value,
          $Res Function(RecommendedTemplateModel) _then) =
      _$RecommendedTemplateModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String category,
      String title,
      String description,
      List<String> recommendedChannels,
      bool bookmarked});
}

/// @nodoc
class _$RecommendedTemplateModelCopyWithImpl<$Res>
    implements $RecommendedTemplateModelCopyWith<$Res> {
  _$RecommendedTemplateModelCopyWithImpl(this._self, this._then);

  final RecommendedTemplateModel _self;
  final $Res Function(RecommendedTemplateModel) _then;

  /// Create a copy of RecommendedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? recommendedChannels = null,
    Object? bookmarked = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
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
      recommendedChannels: null == recommendedChannels
          ? _self.recommendedChannels
          : recommendedChannels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bookmarked: null == bookmarked
          ? _self.bookmarked
          : bookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecommendedTemplateModel].
extension RecommendedTemplateModelPatterns on RecommendedTemplateModel {
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
    TResult Function(_RecommendedTemplateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateModel() when $default != null:
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
    TResult Function(_RecommendedTemplateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateModel():
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
    TResult? Function(_RecommendedTemplateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateModel() when $default != null:
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
    TResult Function(int id, String category, String title, String description,
            List<String> recommendedChannels, bool bookmarked)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateModel() when $default != null:
        return $default(_that.id, _that.category, _that.title,
            _that.description, _that.recommendedChannels, _that.bookmarked);
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
    TResult Function(int id, String category, String title, String description,
            List<String> recommendedChannels, bool bookmarked)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateModel():
        return $default(_that.id, _that.category, _that.title,
            _that.description, _that.recommendedChannels, _that.bookmarked);
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
    TResult? Function(int id, String category, String title, String description,
            List<String> recommendedChannels, bool bookmarked)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateModel() when $default != null:
        return $default(_that.id, _that.category, _that.title,
            _that.description, _that.recommendedChannels, _that.bookmarked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecommendedTemplateModel implements RecommendedTemplateModel {
  const _RecommendedTemplateModel(
      {required this.id,
      required this.category,
      required this.title,
      required this.description,
      final List<String> recommendedChannels = const <String>[],
      this.bookmarked = false})
      : _recommendedChannels = recommendedChannels;
  factory _RecommendedTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendedTemplateModelFromJson(json);

  @override
  final int id;
  @override
  final String category;
  @override
  final String title;
  @override
  final String description;
  final List<String> _recommendedChannels;
  @override
  @JsonKey()
  List<String> get recommendedChannels {
    if (_recommendedChannels is EqualUnmodifiableListView)
      return _recommendedChannels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedChannels);
  }

  @override
  @JsonKey()
  final bool bookmarked;

  /// Create a copy of RecommendedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecommendedTemplateModelCopyWith<_RecommendedTemplateModel> get copyWith =>
      __$RecommendedTemplateModelCopyWithImpl<_RecommendedTemplateModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecommendedTemplateModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecommendedTemplateModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._recommendedChannels, _recommendedChannels) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, category, title, description,
      const DeepCollectionEquality().hash(_recommendedChannels), bookmarked);

  @override
  String toString() {
    return 'RecommendedTemplateModel(id: $id, category: $category, title: $title, description: $description, recommendedChannels: $recommendedChannels, bookmarked: $bookmarked)';
  }
}

/// @nodoc
abstract mixin class _$RecommendedTemplateModelCopyWith<$Res>
    implements $RecommendedTemplateModelCopyWith<$Res> {
  factory _$RecommendedTemplateModelCopyWith(_RecommendedTemplateModel value,
          $Res Function(_RecommendedTemplateModel) _then) =
      __$RecommendedTemplateModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String category,
      String title,
      String description,
      List<String> recommendedChannels,
      bool bookmarked});
}

/// @nodoc
class __$RecommendedTemplateModelCopyWithImpl<$Res>
    implements _$RecommendedTemplateModelCopyWith<$Res> {
  __$RecommendedTemplateModelCopyWithImpl(this._self, this._then);

  final _RecommendedTemplateModel _self;
  final $Res Function(_RecommendedTemplateModel) _then;

  /// Create a copy of RecommendedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? recommendedChannels = null,
    Object? bookmarked = null,
  }) {
    return _then(_RecommendedTemplateModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
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
      recommendedChannels: null == recommendedChannels
          ? _self._recommendedChannels
          : recommendedChannels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bookmarked: null == bookmarked
          ? _self.bookmarked
          : bookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$RecommendedTemplateListResponseModel {
  int get totalCount;
  int get page;
  int get size;
  bool get hasNext;
  List<RecommendedTemplateModel> get templates;

  /// Create a copy of RecommendedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecommendedTemplateListResponseModelCopyWith<
          RecommendedTemplateListResponseModel>
      get copyWith => _$RecommendedTemplateListResponseModelCopyWithImpl<
              RecommendedTemplateListResponseModel>(
          this as RecommendedTemplateListResponseModel, _$identity);

  /// Serializes this RecommendedTemplateListResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecommendedTemplateListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality().equals(other.templates, templates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(templates));

  @override
  String toString() {
    return 'RecommendedTemplateListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, templates: $templates)';
  }
}

/// @nodoc
abstract mixin class $RecommendedTemplateListResponseModelCopyWith<$Res> {
  factory $RecommendedTemplateListResponseModelCopyWith(
          RecommendedTemplateListResponseModel value,
          $Res Function(RecommendedTemplateListResponseModel) _then) =
      _$RecommendedTemplateListResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<RecommendedTemplateModel> templates});
}

/// @nodoc
class _$RecommendedTemplateListResponseModelCopyWithImpl<$Res>
    implements $RecommendedTemplateListResponseModelCopyWith<$Res> {
  _$RecommendedTemplateListResponseModelCopyWithImpl(this._self, this._then);

  final RecommendedTemplateListResponseModel _self;
  final $Res Function(RecommendedTemplateListResponseModel) _then;

  /// Create a copy of RecommendedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? templates = null,
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
      templates: null == templates
          ? _self.templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<RecommendedTemplateModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecommendedTemplateListResponseModel].
extension RecommendedTemplateListResponseModelPatterns
    on RecommendedTemplateListResponseModel {
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
    TResult Function(_RecommendedTemplateListResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateListResponseModel() when $default != null:
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
    TResult Function(_RecommendedTemplateListResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateListResponseModel():
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
    TResult? Function(_RecommendedTemplateListResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateListResponseModel() when $default != null:
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
            List<RecommendedTemplateModel> templates)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.templates);
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
            List<RecommendedTemplateModel> templates)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateListResponseModel():
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.templates);
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
            List<RecommendedTemplateModel> templates)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.templates);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecommendedTemplateListResponseModel
    implements RecommendedTemplateListResponseModel {
  const _RecommendedTemplateListResponseModel(
      {required this.totalCount,
      required this.page,
      required this.size,
      required this.hasNext,
      final List<RecommendedTemplateModel> templates =
          const <RecommendedTemplateModel>[]})
      : _templates = templates;
  factory _RecommendedTemplateListResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$RecommendedTemplateListResponseModelFromJson(json);

  @override
  final int totalCount;
  @override
  final int page;
  @override
  final int size;
  @override
  final bool hasNext;
  final List<RecommendedTemplateModel> _templates;
  @override
  @JsonKey()
  List<RecommendedTemplateModel> get templates {
    if (_templates is EqualUnmodifiableListView) return _templates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templates);
  }

  /// Create a copy of RecommendedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecommendedTemplateListResponseModelCopyWith<
          _RecommendedTemplateListResponseModel>
      get copyWith => __$RecommendedTemplateListResponseModelCopyWithImpl<
          _RecommendedTemplateListResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecommendedTemplateListResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecommendedTemplateListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality()
                .equals(other._templates, _templates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(_templates));

  @override
  String toString() {
    return 'RecommendedTemplateListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, templates: $templates)';
  }
}

/// @nodoc
abstract mixin class _$RecommendedTemplateListResponseModelCopyWith<$Res>
    implements $RecommendedTemplateListResponseModelCopyWith<$Res> {
  factory _$RecommendedTemplateListResponseModelCopyWith(
          _RecommendedTemplateListResponseModel value,
          $Res Function(_RecommendedTemplateListResponseModel) _then) =
      __$RecommendedTemplateListResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<RecommendedTemplateModel> templates});
}

/// @nodoc
class __$RecommendedTemplateListResponseModelCopyWithImpl<$Res>
    implements _$RecommendedTemplateListResponseModelCopyWith<$Res> {
  __$RecommendedTemplateListResponseModelCopyWithImpl(this._self, this._then);

  final _RecommendedTemplateListResponseModel _self;
  final $Res Function(_RecommendedTemplateListResponseModel) _then;

  /// Create a copy of RecommendedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? templates = null,
  }) {
    return _then(_RecommendedTemplateListResponseModel(
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
      templates: null == templates
          ? _self._templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<RecommendedTemplateModel>,
    ));
  }
}

// dart format on
