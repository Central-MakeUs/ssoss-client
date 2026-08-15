// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applied_template_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppliedTemplateResponseModel {
  int get id;
  String get body;

  /// Create a copy of AppliedTemplateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppliedTemplateResponseModelCopyWith<AppliedTemplateResponseModel>
      get copyWith => _$AppliedTemplateResponseModelCopyWithImpl<
              AppliedTemplateResponseModel>(
          this as AppliedTemplateResponseModel, _$identity);

  /// Serializes this AppliedTemplateResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppliedTemplateResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, body);

  @override
  String toString() {
    return 'AppliedTemplateResponseModel(id: $id, body: $body)';
  }
}

/// @nodoc
abstract mixin class $AppliedTemplateResponseModelCopyWith<$Res> {
  factory $AppliedTemplateResponseModelCopyWith(
          AppliedTemplateResponseModel value,
          $Res Function(AppliedTemplateResponseModel) _then) =
      _$AppliedTemplateResponseModelCopyWithImpl;
  @useResult
  $Res call({int id, String body});
}

/// @nodoc
class _$AppliedTemplateResponseModelCopyWithImpl<$Res>
    implements $AppliedTemplateResponseModelCopyWith<$Res> {
  _$AppliedTemplateResponseModelCopyWithImpl(this._self, this._then);

  final AppliedTemplateResponseModel _self;
  final $Res Function(AppliedTemplateResponseModel) _then;

  /// Create a copy of AppliedTemplateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? body = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppliedTemplateResponseModel].
extension AppliedTemplateResponseModelPatterns on AppliedTemplateResponseModel {
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
    TResult Function(_AppliedTemplateResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppliedTemplateResponseModel() when $default != null:
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
    TResult Function(_AppliedTemplateResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppliedTemplateResponseModel():
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
    TResult? Function(_AppliedTemplateResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppliedTemplateResponseModel() when $default != null:
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
    TResult Function(int id, String body)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppliedTemplateResponseModel() when $default != null:
        return $default(_that.id, _that.body);
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
    TResult Function(int id, String body) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppliedTemplateResponseModel():
        return $default(_that.id, _that.body);
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
    TResult? Function(int id, String body)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppliedTemplateResponseModel() when $default != null:
        return $default(_that.id, _that.body);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppliedTemplateResponseModel implements AppliedTemplateResponseModel {
  const _AppliedTemplateResponseModel({required this.id, required this.body});
  factory _AppliedTemplateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AppliedTemplateResponseModelFromJson(json);

  @override
  final int id;
  @override
  final String body;

  /// Create a copy of AppliedTemplateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppliedTemplateResponseModelCopyWith<_AppliedTemplateResponseModel>
      get copyWith => __$AppliedTemplateResponseModelCopyWithImpl<
          _AppliedTemplateResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppliedTemplateResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppliedTemplateResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, body);

  @override
  String toString() {
    return 'AppliedTemplateResponseModel(id: $id, body: $body)';
  }
}

/// @nodoc
abstract mixin class _$AppliedTemplateResponseModelCopyWith<$Res>
    implements $AppliedTemplateResponseModelCopyWith<$Res> {
  factory _$AppliedTemplateResponseModelCopyWith(
          _AppliedTemplateResponseModel value,
          $Res Function(_AppliedTemplateResponseModel) _then) =
      __$AppliedTemplateResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String body});
}

/// @nodoc
class __$AppliedTemplateResponseModelCopyWithImpl<$Res>
    implements _$AppliedTemplateResponseModelCopyWith<$Res> {
  __$AppliedTemplateResponseModelCopyWithImpl(this._self, this._then);

  final _AppliedTemplateResponseModel _self;
  final $Res Function(_AppliedTemplateResponseModel) _then;

  /// Create a copy of AppliedTemplateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? body = null,
  }) {
    return _then(_AppliedTemplateResponseModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
