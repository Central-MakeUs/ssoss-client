// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentEditState implements DiagnosticableTreeMixin {
  ContentEditTarget get target;
  SsossContentsEditDocument? get document;
  List<String> get hashtags;
  List<String> get originalHashtags;
  String get originalPlainText;
  List<String> get originalRecommendationIds;

  /// Create a copy of ContentEditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentEditStateCopyWith<ContentEditState> get copyWith =>
      _$ContentEditStateCopyWithImpl<ContentEditState>(
          this as ContentEditState, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ContentEditState'))
      ..add(DiagnosticsProperty('target', target))
      ..add(DiagnosticsProperty('document', document))
      ..add(DiagnosticsProperty('hashtags', hashtags))
      ..add(DiagnosticsProperty('originalHashtags', originalHashtags))
      ..add(DiagnosticsProperty('originalPlainText', originalPlainText))
      ..add(DiagnosticsProperty(
          'originalRecommendationIds', originalRecommendationIds));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentEditState &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.document, document) ||
                other.document == document) &&
            const DeepCollectionEquality().equals(other.hashtags, hashtags) &&
            const DeepCollectionEquality()
                .equals(other.originalHashtags, originalHashtags) &&
            (identical(other.originalPlainText, originalPlainText) ||
                other.originalPlainText == originalPlainText) &&
            const DeepCollectionEquality().equals(
                other.originalRecommendationIds, originalRecommendationIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      target,
      document,
      const DeepCollectionEquality().hash(hashtags),
      const DeepCollectionEquality().hash(originalHashtags),
      originalPlainText,
      const DeepCollectionEquality().hash(originalRecommendationIds));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ContentEditState(target: $target, document: $document, hashtags: $hashtags, originalHashtags: $originalHashtags, originalPlainText: $originalPlainText, originalRecommendationIds: $originalRecommendationIds)';
  }
}

/// @nodoc
abstract mixin class $ContentEditStateCopyWith<$Res> {
  factory $ContentEditStateCopyWith(
          ContentEditState value, $Res Function(ContentEditState) _then) =
      _$ContentEditStateCopyWithImpl;
  @useResult
  $Res call(
      {ContentEditTarget target,
      SsossContentsEditDocument? document,
      List<String> hashtags,
      List<String> originalHashtags,
      String originalPlainText,
      List<String> originalRecommendationIds});
}

/// @nodoc
class _$ContentEditStateCopyWithImpl<$Res>
    implements $ContentEditStateCopyWith<$Res> {
  _$ContentEditStateCopyWithImpl(this._self, this._then);

  final ContentEditState _self;
  final $Res Function(ContentEditState) _then;

  /// Create a copy of ContentEditState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? target = null,
    Object? document = freezed,
    Object? hashtags = null,
    Object? originalHashtags = null,
    Object? originalPlainText = null,
    Object? originalRecommendationIds = null,
  }) {
    return _then(_self.copyWith(
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as ContentEditTarget,
      document: freezed == document
          ? _self.document
          : document // ignore: cast_nullable_to_non_nullable
              as SsossContentsEditDocument?,
      hashtags: null == hashtags
          ? _self.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      originalHashtags: null == originalHashtags
          ? _self.originalHashtags
          : originalHashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      originalPlainText: null == originalPlainText
          ? _self.originalPlainText
          : originalPlainText // ignore: cast_nullable_to_non_nullable
              as String,
      originalRecommendationIds: null == originalRecommendationIds
          ? _self.originalRecommendationIds
          : originalRecommendationIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentEditState].
extension ContentEditStatePatterns on ContentEditState {
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
    TResult Function(_ContentEditState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentEditState() when $default != null:
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
    TResult Function(_ContentEditState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentEditState():
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
    TResult? Function(_ContentEditState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentEditState() when $default != null:
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
            ContentEditTarget target,
            SsossContentsEditDocument? document,
            List<String> hashtags,
            List<String> originalHashtags,
            String originalPlainText,
            List<String> originalRecommendationIds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentEditState() when $default != null:
        return $default(
            _that.target,
            _that.document,
            _that.hashtags,
            _that.originalHashtags,
            _that.originalPlainText,
            _that.originalRecommendationIds);
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
            ContentEditTarget target,
            SsossContentsEditDocument? document,
            List<String> hashtags,
            List<String> originalHashtags,
            String originalPlainText,
            List<String> originalRecommendationIds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentEditState():
        return $default(
            _that.target,
            _that.document,
            _that.hashtags,
            _that.originalHashtags,
            _that.originalPlainText,
            _that.originalRecommendationIds);
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
            ContentEditTarget target,
            SsossContentsEditDocument? document,
            List<String> hashtags,
            List<String> originalHashtags,
            String originalPlainText,
            List<String> originalRecommendationIds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentEditState() when $default != null:
        return $default(
            _that.target,
            _that.document,
            _that.hashtags,
            _that.originalHashtags,
            _that.originalPlainText,
            _that.originalRecommendationIds);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ContentEditState extends ContentEditState with DiagnosticableTreeMixin {
  const _ContentEditState(
      {required this.target,
      this.document,
      final List<String> hashtags = const <String>[],
      final List<String> originalHashtags = const <String>[],
      this.originalPlainText = '',
      final List<String> originalRecommendationIds = const <String>[]})
      : _hashtags = hashtags,
        _originalHashtags = originalHashtags,
        _originalRecommendationIds = originalRecommendationIds,
        super._();

  @override
  final ContentEditTarget target;
  @override
  final SsossContentsEditDocument? document;
  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  final List<String> _originalHashtags;
  @override
  @JsonKey()
  List<String> get originalHashtags {
    if (_originalHashtags is EqualUnmodifiableListView)
      return _originalHashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_originalHashtags);
  }

  @override
  @JsonKey()
  final String originalPlainText;
  final List<String> _originalRecommendationIds;
  @override
  @JsonKey()
  List<String> get originalRecommendationIds {
    if (_originalRecommendationIds is EqualUnmodifiableListView)
      return _originalRecommendationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_originalRecommendationIds);
  }

  /// Create a copy of ContentEditState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentEditStateCopyWith<_ContentEditState> get copyWith =>
      __$ContentEditStateCopyWithImpl<_ContentEditState>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ContentEditState'))
      ..add(DiagnosticsProperty('target', target))
      ..add(DiagnosticsProperty('document', document))
      ..add(DiagnosticsProperty('hashtags', hashtags))
      ..add(DiagnosticsProperty('originalHashtags', originalHashtags))
      ..add(DiagnosticsProperty('originalPlainText', originalPlainText))
      ..add(DiagnosticsProperty(
          'originalRecommendationIds', originalRecommendationIds));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentEditState &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.document, document) ||
                other.document == document) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            const DeepCollectionEquality()
                .equals(other._originalHashtags, _originalHashtags) &&
            (identical(other.originalPlainText, originalPlainText) ||
                other.originalPlainText == originalPlainText) &&
            const DeepCollectionEquality().equals(
                other._originalRecommendationIds, _originalRecommendationIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      target,
      document,
      const DeepCollectionEquality().hash(_hashtags),
      const DeepCollectionEquality().hash(_originalHashtags),
      originalPlainText,
      const DeepCollectionEquality().hash(_originalRecommendationIds));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ContentEditState(target: $target, document: $document, hashtags: $hashtags, originalHashtags: $originalHashtags, originalPlainText: $originalPlainText, originalRecommendationIds: $originalRecommendationIds)';
  }
}

/// @nodoc
abstract mixin class _$ContentEditStateCopyWith<$Res>
    implements $ContentEditStateCopyWith<$Res> {
  factory _$ContentEditStateCopyWith(
          _ContentEditState value, $Res Function(_ContentEditState) _then) =
      __$ContentEditStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ContentEditTarget target,
      SsossContentsEditDocument? document,
      List<String> hashtags,
      List<String> originalHashtags,
      String originalPlainText,
      List<String> originalRecommendationIds});
}

/// @nodoc
class __$ContentEditStateCopyWithImpl<$Res>
    implements _$ContentEditStateCopyWith<$Res> {
  __$ContentEditStateCopyWithImpl(this._self, this._then);

  final _ContentEditState _self;
  final $Res Function(_ContentEditState) _then;

  /// Create a copy of ContentEditState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? target = null,
    Object? document = freezed,
    Object? hashtags = null,
    Object? originalHashtags = null,
    Object? originalPlainText = null,
    Object? originalRecommendationIds = null,
  }) {
    return _then(_ContentEditState(
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as ContentEditTarget,
      document: freezed == document
          ? _self.document
          : document // ignore: cast_nullable_to_non_nullable
              as SsossContentsEditDocument?,
      hashtags: null == hashtags
          ? _self._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      originalHashtags: null == originalHashtags
          ? _self._originalHashtags
          : originalHashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      originalPlainText: null == originalPlainText
          ? _self.originalPlainText
          : originalPlainText // ignore: cast_nullable_to_non_nullable
              as String,
      originalRecommendationIds: null == originalRecommendationIds
          ? _self._originalRecommendationIds
          : originalRecommendationIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
