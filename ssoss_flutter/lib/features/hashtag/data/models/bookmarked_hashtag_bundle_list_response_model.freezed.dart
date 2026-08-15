// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmarked_hashtag_bundle_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookmarkedHashtagBundleModel {
  int get id;
  String get name;
  List<String> get hashtags;

  /// Create a copy of BookmarkedHashtagBundleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookmarkedHashtagBundleModelCopyWith<BookmarkedHashtagBundleModel>
      get copyWith => _$BookmarkedHashtagBundleModelCopyWithImpl<
              BookmarkedHashtagBundleModel>(
          this as BookmarkedHashtagBundleModel, _$identity);

  /// Serializes this BookmarkedHashtagBundleModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookmarkedHashtagBundleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.hashtags, hashtags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(hashtags));

  @override
  String toString() {
    return 'BookmarkedHashtagBundleModel(id: $id, name: $name, hashtags: $hashtags)';
  }
}

/// @nodoc
abstract mixin class $BookmarkedHashtagBundleModelCopyWith<$Res> {
  factory $BookmarkedHashtagBundleModelCopyWith(
          BookmarkedHashtagBundleModel value,
          $Res Function(BookmarkedHashtagBundleModel) _then) =
      _$BookmarkedHashtagBundleModelCopyWithImpl;
  @useResult
  $Res call({int id, String name, List<String> hashtags});
}

/// @nodoc
class _$BookmarkedHashtagBundleModelCopyWithImpl<$Res>
    implements $BookmarkedHashtagBundleModelCopyWith<$Res> {
  _$BookmarkedHashtagBundleModelCopyWithImpl(this._self, this._then);

  final BookmarkedHashtagBundleModel _self;
  final $Res Function(BookmarkedHashtagBundleModel) _then;

  /// Create a copy of BookmarkedHashtagBundleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? hashtags = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hashtags: null == hashtags
          ? _self.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BookmarkedHashtagBundleModel].
extension BookmarkedHashtagBundleModelPatterns on BookmarkedHashtagBundleModel {
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
    TResult Function(_BookmarkedHashtagBundleModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleModel() when $default != null:
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
    TResult Function(_BookmarkedHashtagBundleModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleModel():
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
    TResult? Function(_BookmarkedHashtagBundleModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleModel() when $default != null:
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
    TResult Function(int id, String name, List<String> hashtags)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleModel() when $default != null:
        return $default(_that.id, _that.name, _that.hashtags);
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
    TResult Function(int id, String name, List<String> hashtags) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleModel():
        return $default(_that.id, _that.name, _that.hashtags);
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
    TResult? Function(int id, String name, List<String> hashtags)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleModel() when $default != null:
        return $default(_that.id, _that.name, _that.hashtags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BookmarkedHashtagBundleModel implements BookmarkedHashtagBundleModel {
  const _BookmarkedHashtagBundleModel(
      {required this.id,
      required this.name,
      final List<String> hashtags = const <String>[]})
      : _hashtags = hashtags;
  factory _BookmarkedHashtagBundleModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkedHashtagBundleModelFromJson(json);

  @override
  final int id;
  @override
  final String name;
  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  /// Create a copy of BookmarkedHashtagBundleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookmarkedHashtagBundleModelCopyWith<_BookmarkedHashtagBundleModel>
      get copyWith => __$BookmarkedHashtagBundleModelCopyWithImpl<
          _BookmarkedHashtagBundleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BookmarkedHashtagBundleModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookmarkedHashtagBundleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_hashtags));

  @override
  String toString() {
    return 'BookmarkedHashtagBundleModel(id: $id, name: $name, hashtags: $hashtags)';
  }
}

/// @nodoc
abstract mixin class _$BookmarkedHashtagBundleModelCopyWith<$Res>
    implements $BookmarkedHashtagBundleModelCopyWith<$Res> {
  factory _$BookmarkedHashtagBundleModelCopyWith(
          _BookmarkedHashtagBundleModel value,
          $Res Function(_BookmarkedHashtagBundleModel) _then) =
      __$BookmarkedHashtagBundleModelCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name, List<String> hashtags});
}

/// @nodoc
class __$BookmarkedHashtagBundleModelCopyWithImpl<$Res>
    implements _$BookmarkedHashtagBundleModelCopyWith<$Res> {
  __$BookmarkedHashtagBundleModelCopyWithImpl(this._self, this._then);

  final _BookmarkedHashtagBundleModel _self;
  final $Res Function(_BookmarkedHashtagBundleModel) _then;

  /// Create a copy of BookmarkedHashtagBundleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? hashtags = null,
  }) {
    return _then(_BookmarkedHashtagBundleModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hashtags: null == hashtags
          ? _self._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$BookmarkedHashtagBundleListResponseModel {
  List<BookmarkedHashtagBundleModel> get bundles;

  /// Create a copy of BookmarkedHashtagBundleListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookmarkedHashtagBundleListResponseModelCopyWith<
          BookmarkedHashtagBundleListResponseModel>
      get copyWith => _$BookmarkedHashtagBundleListResponseModelCopyWithImpl<
              BookmarkedHashtagBundleListResponseModel>(
          this as BookmarkedHashtagBundleListResponseModel, _$identity);

  /// Serializes this BookmarkedHashtagBundleListResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookmarkedHashtagBundleListResponseModel &&
            const DeepCollectionEquality().equals(other.bundles, bundles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(bundles));

  @override
  String toString() {
    return 'BookmarkedHashtagBundleListResponseModel(bundles: $bundles)';
  }
}

/// @nodoc
abstract mixin class $BookmarkedHashtagBundleListResponseModelCopyWith<$Res> {
  factory $BookmarkedHashtagBundleListResponseModelCopyWith(
          BookmarkedHashtagBundleListResponseModel value,
          $Res Function(BookmarkedHashtagBundleListResponseModel) _then) =
      _$BookmarkedHashtagBundleListResponseModelCopyWithImpl;
  @useResult
  $Res call({List<BookmarkedHashtagBundleModel> bundles});
}

/// @nodoc
class _$BookmarkedHashtagBundleListResponseModelCopyWithImpl<$Res>
    implements $BookmarkedHashtagBundleListResponseModelCopyWith<$Res> {
  _$BookmarkedHashtagBundleListResponseModelCopyWithImpl(
      this._self, this._then);

  final BookmarkedHashtagBundleListResponseModel _self;
  final $Res Function(BookmarkedHashtagBundleListResponseModel) _then;

  /// Create a copy of BookmarkedHashtagBundleListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundles = null,
  }) {
    return _then(_self.copyWith(
      bundles: null == bundles
          ? _self.bundles
          : bundles // ignore: cast_nullable_to_non_nullable
              as List<BookmarkedHashtagBundleModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BookmarkedHashtagBundleListResponseModel].
extension BookmarkedHashtagBundleListResponseModelPatterns
    on BookmarkedHashtagBundleListResponseModel {
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
    TResult Function(_BookmarkedHashtagBundleListResponseModel value)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleListResponseModel() when $default != null:
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
    TResult Function(_BookmarkedHashtagBundleListResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleListResponseModel():
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
    TResult? Function(_BookmarkedHashtagBundleListResponseModel value)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleListResponseModel() when $default != null:
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
    TResult Function(List<BookmarkedHashtagBundleModel> bundles)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleListResponseModel() when $default != null:
        return $default(_that.bundles);
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
    TResult Function(List<BookmarkedHashtagBundleModel> bundles) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleListResponseModel():
        return $default(_that.bundles);
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
    TResult? Function(List<BookmarkedHashtagBundleModel> bundles)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookmarkedHashtagBundleListResponseModel() when $default != null:
        return $default(_that.bundles);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BookmarkedHashtagBundleListResponseModel
    implements BookmarkedHashtagBundleListResponseModel {
  const _BookmarkedHashtagBundleListResponseModel(
      {final List<BookmarkedHashtagBundleModel> bundles =
          const <BookmarkedHashtagBundleModel>[]})
      : _bundles = bundles;
  factory _BookmarkedHashtagBundleListResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$BookmarkedHashtagBundleListResponseModelFromJson(json);

  final List<BookmarkedHashtagBundleModel> _bundles;
  @override
  @JsonKey()
  List<BookmarkedHashtagBundleModel> get bundles {
    if (_bundles is EqualUnmodifiableListView) return _bundles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bundles);
  }

  /// Create a copy of BookmarkedHashtagBundleListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookmarkedHashtagBundleListResponseModelCopyWith<
          _BookmarkedHashtagBundleListResponseModel>
      get copyWith => __$BookmarkedHashtagBundleListResponseModelCopyWithImpl<
          _BookmarkedHashtagBundleListResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BookmarkedHashtagBundleListResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookmarkedHashtagBundleListResponseModel &&
            const DeepCollectionEquality().equals(other._bundles, _bundles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_bundles));

  @override
  String toString() {
    return 'BookmarkedHashtagBundleListResponseModel(bundles: $bundles)';
  }
}

/// @nodoc
abstract mixin class _$BookmarkedHashtagBundleListResponseModelCopyWith<$Res>
    implements $BookmarkedHashtagBundleListResponseModelCopyWith<$Res> {
  factory _$BookmarkedHashtagBundleListResponseModelCopyWith(
          _BookmarkedHashtagBundleListResponseModel value,
          $Res Function(_BookmarkedHashtagBundleListResponseModel) _then) =
      __$BookmarkedHashtagBundleListResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<BookmarkedHashtagBundleModel> bundles});
}

/// @nodoc
class __$BookmarkedHashtagBundleListResponseModelCopyWithImpl<$Res>
    implements _$BookmarkedHashtagBundleListResponseModelCopyWith<$Res> {
  __$BookmarkedHashtagBundleListResponseModelCopyWithImpl(
      this._self, this._then);

  final _BookmarkedHashtagBundleListResponseModel _self;
  final $Res Function(_BookmarkedHashtagBundleListResponseModel) _then;

  /// Create a copy of BookmarkedHashtagBundleListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bundles = null,
  }) {
    return _then(_BookmarkedHashtagBundleListResponseModel(
      bundles: null == bundles
          ? _self._bundles
          : bundles // ignore: cast_nullable_to_non_nullable
              as List<BookmarkedHashtagBundleModel>,
    ));
  }
}

// dart format on
