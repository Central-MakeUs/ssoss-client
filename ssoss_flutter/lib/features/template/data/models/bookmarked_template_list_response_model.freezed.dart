// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmarked_template_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookmarkedTemplateModel {
  int get id;
  String get category;
  String get title;
  String get description;
  List<String> get recommendedChannels;

  /// Create a copy of BookmarkedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookmarkedTemplateModelCopyWith<BookmarkedTemplateModel> get copyWith =>
      _$BookmarkedTemplateModelCopyWithImpl<BookmarkedTemplateModel>(
          this as BookmarkedTemplateModel, _$identity);

  /// Serializes this BookmarkedTemplateModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookmarkedTemplateModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other.recommendedChannels, recommendedChannels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, category, title, description,
      const DeepCollectionEquality().hash(recommendedChannels));

  @override
  String toString() {
    return 'BookmarkedTemplateModel(id: $id, category: $category, title: $title, description: $description, recommendedChannels: $recommendedChannels)';
  }
}

/// @nodoc
abstract mixin class $BookmarkedTemplateModelCopyWith<$Res> {
  factory $BookmarkedTemplateModelCopyWith(BookmarkedTemplateModel value,
          $Res Function(BookmarkedTemplateModel) _then) =
      _$BookmarkedTemplateModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String category,
      String title,
      String description,
      List<String> recommendedChannels});
}

/// @nodoc
class _$BookmarkedTemplateModelCopyWithImpl<$Res>
    implements $BookmarkedTemplateModelCopyWith<$Res> {
  _$BookmarkedTemplateModelCopyWithImpl(this._self, this._then);

  final BookmarkedTemplateModel _self;
  final $Res Function(BookmarkedTemplateModel) _then;

  /// Create a copy of BookmarkedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? recommendedChannels = null,
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
    ));
  }
}

/// Adds pattern-matching-related methods to [BookmarkedTemplateModel].
extension BookmarkedTemplateModelPatterns on BookmarkedTemplateModel {
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
    TResult Function(_BookmarkedTemplateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateModel() when $default != null:
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
    TResult Function(_BookmarkedTemplateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateModel():
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
    TResult? Function(_BookmarkedTemplateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateModel() when $default != null:
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
            List<String> recommendedChannels)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateModel() when $default != null:
        return $default(_that.id, _that.category, _that.title,
            _that.description, _that.recommendedChannels);
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
            List<String> recommendedChannels)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateModel():
        return $default(_that.id, _that.category, _that.title,
            _that.description, _that.recommendedChannels);
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
            List<String> recommendedChannels)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateModel() when $default != null:
        return $default(_that.id, _that.category, _that.title,
            _that.description, _that.recommendedChannels);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BookmarkedTemplateModel implements BookmarkedTemplateModel {
  const _BookmarkedTemplateModel(
      {required this.id,
      required this.category,
      required this.title,
      required this.description,
      final List<String> recommendedChannels = const <String>[]})
      : _recommendedChannels = recommendedChannels;
  factory _BookmarkedTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkedTemplateModelFromJson(json);

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

  /// Create a copy of BookmarkedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookmarkedTemplateModelCopyWith<_BookmarkedTemplateModel> get copyWith =>
      __$BookmarkedTemplateModelCopyWithImpl<_BookmarkedTemplateModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BookmarkedTemplateModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookmarkedTemplateModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._recommendedChannels, _recommendedChannels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, category, title, description,
      const DeepCollectionEquality().hash(_recommendedChannels));

  @override
  String toString() {
    return 'BookmarkedTemplateModel(id: $id, category: $category, title: $title, description: $description, recommendedChannels: $recommendedChannels)';
  }
}

/// @nodoc
abstract mixin class _$BookmarkedTemplateModelCopyWith<$Res>
    implements $BookmarkedTemplateModelCopyWith<$Res> {
  factory _$BookmarkedTemplateModelCopyWith(_BookmarkedTemplateModel value,
          $Res Function(_BookmarkedTemplateModel) _then) =
      __$BookmarkedTemplateModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String category,
      String title,
      String description,
      List<String> recommendedChannels});
}

/// @nodoc
class __$BookmarkedTemplateModelCopyWithImpl<$Res>
    implements _$BookmarkedTemplateModelCopyWith<$Res> {
  __$BookmarkedTemplateModelCopyWithImpl(this._self, this._then);

  final _BookmarkedTemplateModel _self;
  final $Res Function(_BookmarkedTemplateModel) _then;

  /// Create a copy of BookmarkedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? recommendedChannels = null,
  }) {
    return _then(_BookmarkedTemplateModel(
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
    ));
  }
}

/// @nodoc
mixin _$BookmarkedTemplateListResponseModel {
  List<BookmarkedTemplateModel> get templates;

  /// Create a copy of BookmarkedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookmarkedTemplateListResponseModelCopyWith<
          BookmarkedTemplateListResponseModel>
      get copyWith => _$BookmarkedTemplateListResponseModelCopyWithImpl<
              BookmarkedTemplateListResponseModel>(
          this as BookmarkedTemplateListResponseModel, _$identity);

  /// Serializes this BookmarkedTemplateListResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookmarkedTemplateListResponseModel &&
            const DeepCollectionEquality().equals(other.templates, templates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(templates));

  @override
  String toString() {
    return 'BookmarkedTemplateListResponseModel(templates: $templates)';
  }
}

/// @nodoc
abstract mixin class $BookmarkedTemplateListResponseModelCopyWith<$Res> {
  factory $BookmarkedTemplateListResponseModelCopyWith(
          BookmarkedTemplateListResponseModel value,
          $Res Function(BookmarkedTemplateListResponseModel) _then) =
      _$BookmarkedTemplateListResponseModelCopyWithImpl;
  @useResult
  $Res call({List<BookmarkedTemplateModel> templates});
}

/// @nodoc
class _$BookmarkedTemplateListResponseModelCopyWithImpl<$Res>
    implements $BookmarkedTemplateListResponseModelCopyWith<$Res> {
  _$BookmarkedTemplateListResponseModelCopyWithImpl(this._self, this._then);

  final BookmarkedTemplateListResponseModel _self;
  final $Res Function(BookmarkedTemplateListResponseModel) _then;

  /// Create a copy of BookmarkedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templates = null,
  }) {
    return _then(_self.copyWith(
      templates: null == templates
          ? _self.templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<BookmarkedTemplateModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BookmarkedTemplateListResponseModel].
extension BookmarkedTemplateListResponseModelPatterns
    on BookmarkedTemplateListResponseModel {
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
    TResult Function(_BookmarkedTemplateListResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateListResponseModel() when $default != null:
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
    TResult Function(_BookmarkedTemplateListResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateListResponseModel():
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
    TResult? Function(_BookmarkedTemplateListResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateListResponseModel() when $default != null:
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
    TResult Function(List<BookmarkedTemplateModel> templates)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateListResponseModel() when $default != null:
        return $default(_that.templates);
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
    TResult Function(List<BookmarkedTemplateModel> templates) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateListResponseModel():
        return $default(_that.templates);
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
    TResult? Function(List<BookmarkedTemplateModel> templates)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedTemplateListResponseModel() when $default != null:
        return $default(_that.templates);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BookmarkedTemplateListResponseModel
    implements BookmarkedTemplateListResponseModel {
  const _BookmarkedTemplateListResponseModel(
      {final List<BookmarkedTemplateModel> templates =
          const <BookmarkedTemplateModel>[]})
      : _templates = templates;
  factory _BookmarkedTemplateListResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$BookmarkedTemplateListResponseModelFromJson(json);

  final List<BookmarkedTemplateModel> _templates;
  @override
  @JsonKey()
  List<BookmarkedTemplateModel> get templates {
    if (_templates is EqualUnmodifiableListView) return _templates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templates);
  }

  /// Create a copy of BookmarkedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookmarkedTemplateListResponseModelCopyWith<
          _BookmarkedTemplateListResponseModel>
      get copyWith => __$BookmarkedTemplateListResponseModelCopyWithImpl<
          _BookmarkedTemplateListResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BookmarkedTemplateListResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookmarkedTemplateListResponseModel &&
            const DeepCollectionEquality()
                .equals(other._templates, _templates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_templates));

  @override
  String toString() {
    return 'BookmarkedTemplateListResponseModel(templates: $templates)';
  }
}

/// @nodoc
abstract mixin class _$BookmarkedTemplateListResponseModelCopyWith<$Res>
    implements $BookmarkedTemplateListResponseModelCopyWith<$Res> {
  factory _$BookmarkedTemplateListResponseModelCopyWith(
          _BookmarkedTemplateListResponseModel value,
          $Res Function(_BookmarkedTemplateListResponseModel) _then) =
      __$BookmarkedTemplateListResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<BookmarkedTemplateModel> templates});
}

/// @nodoc
class __$BookmarkedTemplateListResponseModelCopyWithImpl<$Res>
    implements _$BookmarkedTemplateListResponseModelCopyWith<$Res> {
  __$BookmarkedTemplateListResponseModelCopyWithImpl(this._self, this._then);

  final _BookmarkedTemplateListResponseModel _self;
  final $Res Function(_BookmarkedTemplateListResponseModel) _then;

  /// Create a copy of BookmarkedTemplateListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? templates = null,
  }) {
    return _then(_BookmarkedTemplateListResponseModel(
      templates: null == templates
          ? _self._templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<BookmarkedTemplateModel>,
    ));
  }
}

// dart format on
