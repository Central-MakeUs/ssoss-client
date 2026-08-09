// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommended_template_detail_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecommendedTemplateDetailResponseModel {
  int get id;
  String get category;
  String get title;
  String get description;
  String get body;
  String get exampleBody;
  List<String> get recommendedChannels;
  bool get bookmarked;

  /// Create a copy of RecommendedTemplateDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecommendedTemplateDetailResponseModelCopyWith<
          RecommendedTemplateDetailResponseModel>
      get copyWith => _$RecommendedTemplateDetailResponseModelCopyWithImpl<
              RecommendedTemplateDetailResponseModel>(
          this as RecommendedTemplateDetailResponseModel, _$identity);

  /// Serializes this RecommendedTemplateDetailResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecommendedTemplateDetailResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.exampleBody, exampleBody) ||
                other.exampleBody == exampleBody) &&
            const DeepCollectionEquality()
                .equals(other.recommendedChannels, recommendedChannels) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      category,
      title,
      description,
      body,
      exampleBody,
      const DeepCollectionEquality().hash(recommendedChannels),
      bookmarked);

  @override
  String toString() {
    return 'RecommendedTemplateDetailResponseModel(id: $id, category: $category, title: $title, description: $description, body: $body, exampleBody: $exampleBody, recommendedChannels: $recommendedChannels, bookmarked: $bookmarked)';
  }
}

/// @nodoc
abstract mixin class $RecommendedTemplateDetailResponseModelCopyWith<$Res> {
  factory $RecommendedTemplateDetailResponseModelCopyWith(
          RecommendedTemplateDetailResponseModel value,
          $Res Function(RecommendedTemplateDetailResponseModel) _then) =
      _$RecommendedTemplateDetailResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String category,
      String title,
      String description,
      String body,
      String exampleBody,
      List<String> recommendedChannels,
      bool bookmarked});
}

/// @nodoc
class _$RecommendedTemplateDetailResponseModelCopyWithImpl<$Res>
    implements $RecommendedTemplateDetailResponseModelCopyWith<$Res> {
  _$RecommendedTemplateDetailResponseModelCopyWithImpl(this._self, this._then);

  final RecommendedTemplateDetailResponseModel _self;
  final $Res Function(RecommendedTemplateDetailResponseModel) _then;

  /// Create a copy of RecommendedTemplateDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? body = null,
    Object? exampleBody = null,
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
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      exampleBody: null == exampleBody
          ? _self.exampleBody
          : exampleBody // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [RecommendedTemplateDetailResponseModel].
extension RecommendedTemplateDetailResponseModelPatterns
    on RecommendedTemplateDetailResponseModel {
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
    TResult Function(_RecommendedTemplateDetailResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateDetailResponseModel() when $default != null:
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
    TResult Function(_RecommendedTemplateDetailResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateDetailResponseModel():
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
    TResult? Function(_RecommendedTemplateDetailResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateDetailResponseModel() when $default != null:
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
            int id,
            String category,
            String title,
            String description,
            String body,
            String exampleBody,
            List<String> recommendedChannels,
            bool bookmarked)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateDetailResponseModel() when $default != null:
        return $default(
            _that.id,
            _that.category,
            _that.title,
            _that.description,
            _that.body,
            _that.exampleBody,
            _that.recommendedChannels,
            _that.bookmarked);
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
            int id,
            String category,
            String title,
            String description,
            String body,
            String exampleBody,
            List<String> recommendedChannels,
            bool bookmarked)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateDetailResponseModel():
        return $default(
            _that.id,
            _that.category,
            _that.title,
            _that.description,
            _that.body,
            _that.exampleBody,
            _that.recommendedChannels,
            _that.bookmarked);
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
            int id,
            String category,
            String title,
            String description,
            String body,
            String exampleBody,
            List<String> recommendedChannels,
            bool bookmarked)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendedTemplateDetailResponseModel() when $default != null:
        return $default(
            _that.id,
            _that.category,
            _that.title,
            _that.description,
            _that.body,
            _that.exampleBody,
            _that.recommendedChannels,
            _that.bookmarked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecommendedTemplateDetailResponseModel
    implements RecommendedTemplateDetailResponseModel {
  const _RecommendedTemplateDetailResponseModel(
      {required this.id,
      required this.category,
      required this.title,
      required this.description,
      required this.body,
      required this.exampleBody,
      final List<String> recommendedChannels = const <String>[],
      this.bookmarked = false})
      : _recommendedChannels = recommendedChannels;
  factory _RecommendedTemplateDetailResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$RecommendedTemplateDetailResponseModelFromJson(json);

  @override
  final int id;
  @override
  final String category;
  @override
  final String title;
  @override
  final String description;
  @override
  final String body;
  @override
  final String exampleBody;
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

  /// Create a copy of RecommendedTemplateDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecommendedTemplateDetailResponseModelCopyWith<
          _RecommendedTemplateDetailResponseModel>
      get copyWith => __$RecommendedTemplateDetailResponseModelCopyWithImpl<
          _RecommendedTemplateDetailResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecommendedTemplateDetailResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecommendedTemplateDetailResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.exampleBody, exampleBody) ||
                other.exampleBody == exampleBody) &&
            const DeepCollectionEquality()
                .equals(other._recommendedChannels, _recommendedChannels) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      category,
      title,
      description,
      body,
      exampleBody,
      const DeepCollectionEquality().hash(_recommendedChannels),
      bookmarked);

  @override
  String toString() {
    return 'RecommendedTemplateDetailResponseModel(id: $id, category: $category, title: $title, description: $description, body: $body, exampleBody: $exampleBody, recommendedChannels: $recommendedChannels, bookmarked: $bookmarked)';
  }
}

/// @nodoc
abstract mixin class _$RecommendedTemplateDetailResponseModelCopyWith<$Res>
    implements $RecommendedTemplateDetailResponseModelCopyWith<$Res> {
  factory _$RecommendedTemplateDetailResponseModelCopyWith(
          _RecommendedTemplateDetailResponseModel value,
          $Res Function(_RecommendedTemplateDetailResponseModel) _then) =
      __$RecommendedTemplateDetailResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String category,
      String title,
      String description,
      String body,
      String exampleBody,
      List<String> recommendedChannels,
      bool bookmarked});
}

/// @nodoc
class __$RecommendedTemplateDetailResponseModelCopyWithImpl<$Res>
    implements _$RecommendedTemplateDetailResponseModelCopyWith<$Res> {
  __$RecommendedTemplateDetailResponseModelCopyWithImpl(this._self, this._then);

  final _RecommendedTemplateDetailResponseModel _self;
  final $Res Function(_RecommendedTemplateDetailResponseModel) _then;

  /// Create a copy of RecommendedTemplateDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? body = null,
    Object? exampleBody = null,
    Object? recommendedChannels = null,
    Object? bookmarked = null,
  }) {
    return _then(_RecommendedTemplateDetailResponseModel(
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
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      exampleBody: null == exampleBody
          ? _self.exampleBody
          : exampleBody // ignore: cast_nullable_to_non_nullable
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

// dart format on
