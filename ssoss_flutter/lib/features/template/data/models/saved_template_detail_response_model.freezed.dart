// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_template_detail_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedTemplateDetailResponseModel {
  int get savedTemplateId;
  String get category;
  String get title;
  String get description;
  String get body;
  String get savedAt;
  List<String> get recommendedChannels;

  /// Create a copy of SavedTemplateDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedTemplateDetailResponseModelCopyWith<SavedTemplateDetailResponseModel>
      get copyWith => _$SavedTemplateDetailResponseModelCopyWithImpl<
              SavedTemplateDetailResponseModel>(
          this as SavedTemplateDetailResponseModel, _$identity);

  /// Serializes this SavedTemplateDetailResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedTemplateDetailResponseModel &&
            (identical(other.savedTemplateId, savedTemplateId) ||
                other.savedTemplateId == savedTemplateId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            const DeepCollectionEquality()
                .equals(other.recommendedChannels, recommendedChannels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      savedTemplateId,
      category,
      title,
      description,
      body,
      savedAt,
      const DeepCollectionEquality().hash(recommendedChannels));

  @override
  String toString() {
    return 'SavedTemplateDetailResponseModel(savedTemplateId: $savedTemplateId, category: $category, title: $title, description: $description, body: $body, savedAt: $savedAt, recommendedChannels: $recommendedChannels)';
  }
}

/// @nodoc
abstract mixin class $SavedTemplateDetailResponseModelCopyWith<$Res> {
  factory $SavedTemplateDetailResponseModelCopyWith(
          SavedTemplateDetailResponseModel value,
          $Res Function(SavedTemplateDetailResponseModel) _then) =
      _$SavedTemplateDetailResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {int savedTemplateId,
      String category,
      String title,
      String description,
      String body,
      String savedAt,
      List<String> recommendedChannels});
}

/// @nodoc
class _$SavedTemplateDetailResponseModelCopyWithImpl<$Res>
    implements $SavedTemplateDetailResponseModelCopyWith<$Res> {
  _$SavedTemplateDetailResponseModelCopyWithImpl(this._self, this._then);

  final SavedTemplateDetailResponseModel _self;
  final $Res Function(SavedTemplateDetailResponseModel) _then;

  /// Create a copy of SavedTemplateDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedTemplateId = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? body = null,
    Object? savedAt = null,
    Object? recommendedChannels = null,
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
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedChannels: null == recommendedChannels
          ? _self.recommendedChannels
          : recommendedChannels // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedTemplateDetailResponseModel].
extension SavedTemplateDetailResponseModelPatterns
    on SavedTemplateDetailResponseModel {
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
    TResult Function(_SavedTemplateDetailResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailResponseModel() when $default != null:
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
    TResult Function(_SavedTemplateDetailResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailResponseModel():
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
    TResult? Function(_SavedTemplateDetailResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailResponseModel() when $default != null:
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
            int savedTemplateId,
            String category,
            String title,
            String description,
            String body,
            String savedAt,
            List<String> recommendedChannels)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailResponseModel() when $default != null:
        return $default(
            _that.savedTemplateId,
            _that.category,
            _that.title,
            _that.description,
            _that.body,
            _that.savedAt,
            _that.recommendedChannels);
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
            int savedTemplateId,
            String category,
            String title,
            String description,
            String body,
            String savedAt,
            List<String> recommendedChannels)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailResponseModel():
        return $default(
            _that.savedTemplateId,
            _that.category,
            _that.title,
            _that.description,
            _that.body,
            _that.savedAt,
            _that.recommendedChannels);
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
            int savedTemplateId,
            String category,
            String title,
            String description,
            String body,
            String savedAt,
            List<String> recommendedChannels)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateDetailResponseModel() when $default != null:
        return $default(
            _that.savedTemplateId,
            _that.category,
            _that.title,
            _that.description,
            _that.body,
            _that.savedAt,
            _that.recommendedChannels);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SavedTemplateDetailResponseModel
    implements SavedTemplateDetailResponseModel {
  const _SavedTemplateDetailResponseModel(
      {required this.savedTemplateId,
      required this.category,
      required this.title,
      required this.description,
      required this.body,
      required this.savedAt,
      final List<String> recommendedChannels = const <String>[]})
      : _recommendedChannels = recommendedChannels;
  factory _SavedTemplateDetailResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$SavedTemplateDetailResponseModelFromJson(json);

  @override
  final int savedTemplateId;
  @override
  final String category;
  @override
  final String title;
  @override
  final String description;
  @override
  final String body;
  @override
  final String savedAt;
  final List<String> _recommendedChannels;
  @override
  @JsonKey()
  List<String> get recommendedChannels {
    if (_recommendedChannels is EqualUnmodifiableListView)
      return _recommendedChannels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedChannels);
  }

  /// Create a copy of SavedTemplateDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedTemplateDetailResponseModelCopyWith<_SavedTemplateDetailResponseModel>
      get copyWith => __$SavedTemplateDetailResponseModelCopyWithImpl<
          _SavedTemplateDetailResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SavedTemplateDetailResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedTemplateDetailResponseModel &&
            (identical(other.savedTemplateId, savedTemplateId) ||
                other.savedTemplateId == savedTemplateId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            const DeepCollectionEquality()
                .equals(other._recommendedChannels, _recommendedChannels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      savedTemplateId,
      category,
      title,
      description,
      body,
      savedAt,
      const DeepCollectionEquality().hash(_recommendedChannels));

  @override
  String toString() {
    return 'SavedTemplateDetailResponseModel(savedTemplateId: $savedTemplateId, category: $category, title: $title, description: $description, body: $body, savedAt: $savedAt, recommendedChannels: $recommendedChannels)';
  }
}

/// @nodoc
abstract mixin class _$SavedTemplateDetailResponseModelCopyWith<$Res>
    implements $SavedTemplateDetailResponseModelCopyWith<$Res> {
  factory _$SavedTemplateDetailResponseModelCopyWith(
          _SavedTemplateDetailResponseModel value,
          $Res Function(_SavedTemplateDetailResponseModel) _then) =
      __$SavedTemplateDetailResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int savedTemplateId,
      String category,
      String title,
      String description,
      String body,
      String savedAt,
      List<String> recommendedChannels});
}

/// @nodoc
class __$SavedTemplateDetailResponseModelCopyWithImpl<$Res>
    implements _$SavedTemplateDetailResponseModelCopyWith<$Res> {
  __$SavedTemplateDetailResponseModelCopyWithImpl(this._self, this._then);

  final _SavedTemplateDetailResponseModel _self;
  final $Res Function(_SavedTemplateDetailResponseModel) _then;

  /// Create a copy of SavedTemplateDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? savedTemplateId = null,
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? body = null,
    Object? savedAt = null,
    Object? recommendedChannels = null,
  }) {
    return _then(_SavedTemplateDetailResponseModel(
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
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedChannels: null == recommendedChannels
          ? _self._recommendedChannels
          : recommendedChannels // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
