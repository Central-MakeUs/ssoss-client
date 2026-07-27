// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generation_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenerationDetailModel {
  int get generationId;
  String get status;
  String get purpose;
  String get tone;
  List<String> get keywords;
  List<GenerationChannelResultModel> get results;

  /// Create a copy of GenerationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenerationDetailModelCopyWith<GenerationDetailModel> get copyWith =>
      _$GenerationDetailModelCopyWithImpl<GenerationDetailModel>(
          this as GenerationDetailModel, _$identity);

  /// Serializes this GenerationDetailModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenerationDetailModel &&
            (identical(other.generationId, generationId) ||
                other.generationId == generationId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            const DeepCollectionEquality().equals(other.results, results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      generationId,
      status,
      purpose,
      tone,
      const DeepCollectionEquality().hash(keywords),
      const DeepCollectionEquality().hash(results));

  @override
  String toString() {
    return 'GenerationDetailModel(generationId: $generationId, status: $status, purpose: $purpose, tone: $tone, keywords: $keywords, results: $results)';
  }
}

/// @nodoc
abstract mixin class $GenerationDetailModelCopyWith<$Res> {
  factory $GenerationDetailModelCopyWith(GenerationDetailModel value,
          $Res Function(GenerationDetailModel) _then) =
      _$GenerationDetailModelCopyWithImpl;
  @useResult
  $Res call(
      {int generationId,
      String status,
      String purpose,
      String tone,
      List<String> keywords,
      List<GenerationChannelResultModel> results});
}

/// @nodoc
class _$GenerationDetailModelCopyWithImpl<$Res>
    implements $GenerationDetailModelCopyWith<$Res> {
  _$GenerationDetailModelCopyWithImpl(this._self, this._then);

  final GenerationDetailModel _self;
  final $Res Function(GenerationDetailModel) _then;

  /// Create a copy of GenerationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generationId = null,
    Object? status = null,
    Object? purpose = null,
    Object? tone = null,
    Object? keywords = null,
    Object? results = null,
  }) {
    return _then(_self.copyWith(
      generationId: null == generationId
          ? _self.generationId
          : generationId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      results: null == results
          ? _self.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<GenerationChannelResultModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [GenerationDetailModel].
extension GenerationDetailModelPatterns on GenerationDetailModel {
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
    TResult Function(_GenerationDetailModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerationDetailModel() when $default != null:
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
    TResult Function(_GenerationDetailModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationDetailModel():
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
    TResult? Function(_GenerationDetailModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationDetailModel() when $default != null:
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
            int generationId,
            String status,
            String purpose,
            String tone,
            List<String> keywords,
            List<GenerationChannelResultModel> results)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerationDetailModel() when $default != null:
        return $default(_that.generationId, _that.status, _that.purpose,
            _that.tone, _that.keywords, _that.results);
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
            int generationId,
            String status,
            String purpose,
            String tone,
            List<String> keywords,
            List<GenerationChannelResultModel> results)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationDetailModel():
        return $default(_that.generationId, _that.status, _that.purpose,
            _that.tone, _that.keywords, _that.results);
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
            int generationId,
            String status,
            String purpose,
            String tone,
            List<String> keywords,
            List<GenerationChannelResultModel> results)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerationDetailModel() when $default != null:
        return $default(_that.generationId, _that.status, _that.purpose,
            _that.tone, _that.keywords, _that.results);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GenerationDetailModel implements GenerationDetailModel {
  const _GenerationDetailModel(
      {required this.generationId,
      required this.status,
      required this.purpose,
      required this.tone,
      required final List<String> keywords,
      required final List<GenerationChannelResultModel> results})
      : _keywords = keywords,
        _results = results;
  factory _GenerationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GenerationDetailModelFromJson(json);

  @override
  final int generationId;
  @override
  final String status;
  @override
  final String purpose;
  @override
  final String tone;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  final List<GenerationChannelResultModel> _results;
  @override
  List<GenerationChannelResultModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  /// Create a copy of GenerationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenerationDetailModelCopyWith<_GenerationDetailModel> get copyWith =>
      __$GenerationDetailModelCopyWithImpl<_GenerationDetailModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GenerationDetailModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenerationDetailModel &&
            (identical(other.generationId, generationId) ||
                other.generationId == generationId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      generationId,
      status,
      purpose,
      tone,
      const DeepCollectionEquality().hash(_keywords),
      const DeepCollectionEquality().hash(_results));

  @override
  String toString() {
    return 'GenerationDetailModel(generationId: $generationId, status: $status, purpose: $purpose, tone: $tone, keywords: $keywords, results: $results)';
  }
}

/// @nodoc
abstract mixin class _$GenerationDetailModelCopyWith<$Res>
    implements $GenerationDetailModelCopyWith<$Res> {
  factory _$GenerationDetailModelCopyWith(_GenerationDetailModel value,
          $Res Function(_GenerationDetailModel) _then) =
      __$GenerationDetailModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int generationId,
      String status,
      String purpose,
      String tone,
      List<String> keywords,
      List<GenerationChannelResultModel> results});
}

/// @nodoc
class __$GenerationDetailModelCopyWithImpl<$Res>
    implements _$GenerationDetailModelCopyWith<$Res> {
  __$GenerationDetailModelCopyWithImpl(this._self, this._then);

  final _GenerationDetailModel _self;
  final $Res Function(_GenerationDetailModel) _then;

  /// Create a copy of GenerationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? generationId = null,
    Object? status = null,
    Object? purpose = null,
    Object? tone = null,
    Object? keywords = null,
    Object? results = null,
  }) {
    return _then(_GenerationDetailModel(
      generationId: null == generationId
          ? _self.generationId
          : generationId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _self.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _self._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<GenerationChannelResultModel>,
    ));
  }
}

// dart format on
