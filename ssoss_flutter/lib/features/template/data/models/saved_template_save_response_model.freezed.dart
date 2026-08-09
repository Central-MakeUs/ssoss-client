// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_template_save_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedTemplateSaveResponseModel {
  int get savedTemplateId;

  /// Create a copy of SavedTemplateSaveResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedTemplateSaveResponseModelCopyWith<SavedTemplateSaveResponseModel>
      get copyWith => _$SavedTemplateSaveResponseModelCopyWithImpl<
              SavedTemplateSaveResponseModel>(
          this as SavedTemplateSaveResponseModel, _$identity);

  /// Serializes this SavedTemplateSaveResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedTemplateSaveResponseModel &&
            (identical(other.savedTemplateId, savedTemplateId) ||
                other.savedTemplateId == savedTemplateId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, savedTemplateId);

  @override
  String toString() {
    return 'SavedTemplateSaveResponseModel(savedTemplateId: $savedTemplateId)';
  }
}

/// @nodoc
abstract mixin class $SavedTemplateSaveResponseModelCopyWith<$Res> {
  factory $SavedTemplateSaveResponseModelCopyWith(
          SavedTemplateSaveResponseModel value,
          $Res Function(SavedTemplateSaveResponseModel) _then) =
      _$SavedTemplateSaveResponseModelCopyWithImpl;
  @useResult
  $Res call({int savedTemplateId});
}

/// @nodoc
class _$SavedTemplateSaveResponseModelCopyWithImpl<$Res>
    implements $SavedTemplateSaveResponseModelCopyWith<$Res> {
  _$SavedTemplateSaveResponseModelCopyWithImpl(this._self, this._then);

  final SavedTemplateSaveResponseModel _self;
  final $Res Function(SavedTemplateSaveResponseModel) _then;

  /// Create a copy of SavedTemplateSaveResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedTemplateId = null,
  }) {
    return _then(_self.copyWith(
      savedTemplateId: null == savedTemplateId
          ? _self.savedTemplateId
          : savedTemplateId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedTemplateSaveResponseModel].
extension SavedTemplateSaveResponseModelPatterns
    on SavedTemplateSaveResponseModel {
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
    TResult Function(_SavedTemplateSaveResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateSaveResponseModel() when $default != null:
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
    TResult Function(_SavedTemplateSaveResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateSaveResponseModel():
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
    TResult? Function(_SavedTemplateSaveResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateSaveResponseModel() when $default != null:
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
    TResult Function(int savedTemplateId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateSaveResponseModel() when $default != null:
        return $default(_that.savedTemplateId);
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
    TResult Function(int savedTemplateId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateSaveResponseModel():
        return $default(_that.savedTemplateId);
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
    TResult? Function(int savedTemplateId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedTemplateSaveResponseModel() when $default != null:
        return $default(_that.savedTemplateId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SavedTemplateSaveResponseModel
    implements SavedTemplateSaveResponseModel {
  const _SavedTemplateSaveResponseModel({required this.savedTemplateId});
  factory _SavedTemplateSaveResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateSaveResponseModelFromJson(json);

  @override
  final int savedTemplateId;

  /// Create a copy of SavedTemplateSaveResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedTemplateSaveResponseModelCopyWith<_SavedTemplateSaveResponseModel>
      get copyWith => __$SavedTemplateSaveResponseModelCopyWithImpl<
          _SavedTemplateSaveResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SavedTemplateSaveResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedTemplateSaveResponseModel &&
            (identical(other.savedTemplateId, savedTemplateId) ||
                other.savedTemplateId == savedTemplateId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, savedTemplateId);

  @override
  String toString() {
    return 'SavedTemplateSaveResponseModel(savedTemplateId: $savedTemplateId)';
  }
}

/// @nodoc
abstract mixin class _$SavedTemplateSaveResponseModelCopyWith<$Res>
    implements $SavedTemplateSaveResponseModelCopyWith<$Res> {
  factory _$SavedTemplateSaveResponseModelCopyWith(
          _SavedTemplateSaveResponseModel value,
          $Res Function(_SavedTemplateSaveResponseModel) _then) =
      __$SavedTemplateSaveResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({int savedTemplateId});
}

/// @nodoc
class __$SavedTemplateSaveResponseModelCopyWithImpl<$Res>
    implements _$SavedTemplateSaveResponseModelCopyWith<$Res> {
  __$SavedTemplateSaveResponseModelCopyWithImpl(this._self, this._then);

  final _SavedTemplateSaveResponseModel _self;
  final $Res Function(_SavedTemplateSaveResponseModel) _then;

  /// Create a copy of SavedTemplateSaveResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? savedTemplateId = null,
  }) {
    return _then(_SavedTemplateSaveResponseModel(
      savedTemplateId: null == savedTemplateId
          ? _self.savedTemplateId
          : savedTemplateId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
