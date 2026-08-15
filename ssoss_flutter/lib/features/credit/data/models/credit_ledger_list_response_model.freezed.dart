// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_ledger_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreditLedgerModel {
  int get ledgerId;
  String get type;
  String get description;
  int get amount;
  String get occurredAt;

  /// Create a copy of CreditLedgerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreditLedgerModelCopyWith<CreditLedgerModel> get copyWith =>
      _$CreditLedgerModelCopyWithImpl<CreditLedgerModel>(
          this as CreditLedgerModel, _$identity);

  /// Serializes this CreditLedgerModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreditLedgerModel &&
            (identical(other.ledgerId, ledgerId) ||
                other.ledgerId == ledgerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, ledgerId, type, description, amount, occurredAt);

  @override
  String toString() {
    return 'CreditLedgerModel(ledgerId: $ledgerId, type: $type, description: $description, amount: $amount, occurredAt: $occurredAt)';
  }
}

/// @nodoc
abstract mixin class $CreditLedgerModelCopyWith<$Res> {
  factory $CreditLedgerModelCopyWith(
          CreditLedgerModel value, $Res Function(CreditLedgerModel) _then) =
      _$CreditLedgerModelCopyWithImpl;
  @useResult
  $Res call(
      {int ledgerId,
      String type,
      String description,
      int amount,
      String occurredAt});
}

/// @nodoc
class _$CreditLedgerModelCopyWithImpl<$Res>
    implements $CreditLedgerModelCopyWith<$Res> {
  _$CreditLedgerModelCopyWithImpl(this._self, this._then);

  final CreditLedgerModel _self;
  final $Res Function(CreditLedgerModel) _then;

  /// Create a copy of CreditLedgerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ledgerId = null,
    Object? type = null,
    Object? description = null,
    Object? amount = null,
    Object? occurredAt = null,
  }) {
    return _then(_self.copyWith(
      ledgerId: null == ledgerId
          ? _self.ledgerId
          : ledgerId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      occurredAt: null == occurredAt
          ? _self.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreditLedgerModel].
extension CreditLedgerModelPatterns on CreditLedgerModel {
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
    TResult Function(_CreditLedgerModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerModel() when $default != null:
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
    TResult Function(_CreditLedgerModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerModel():
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
    TResult? Function(_CreditLedgerModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerModel() when $default != null:
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
    TResult Function(int ledgerId, String type, String description, int amount,
            String occurredAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerModel() when $default != null:
        return $default(_that.ledgerId, _that.type, _that.description,
            _that.amount, _that.occurredAt);
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
    TResult Function(int ledgerId, String type, String description, int amount,
            String occurredAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerModel():
        return $default(_that.ledgerId, _that.type, _that.description,
            _that.amount, _that.occurredAt);
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
    TResult? Function(int ledgerId, String type, String description, int amount,
            String occurredAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerModel() when $default != null:
        return $default(_that.ledgerId, _that.type, _that.description,
            _that.amount, _that.occurredAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreditLedgerModel implements CreditLedgerModel {
  const _CreditLedgerModel(
      {required this.ledgerId,
      required this.type,
      required this.description,
      required this.amount,
      required this.occurredAt});
  factory _CreditLedgerModel.fromJson(Map<String, dynamic> json) =>
      _$CreditLedgerModelFromJson(json);

  @override
  final int ledgerId;
  @override
  final String type;
  @override
  final String description;
  @override
  final int amount;
  @override
  final String occurredAt;

  /// Create a copy of CreditLedgerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreditLedgerModelCopyWith<_CreditLedgerModel> get copyWith =>
      __$CreditLedgerModelCopyWithImpl<_CreditLedgerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreditLedgerModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreditLedgerModel &&
            (identical(other.ledgerId, ledgerId) ||
                other.ledgerId == ledgerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, ledgerId, type, description, amount, occurredAt);

  @override
  String toString() {
    return 'CreditLedgerModel(ledgerId: $ledgerId, type: $type, description: $description, amount: $amount, occurredAt: $occurredAt)';
  }
}

/// @nodoc
abstract mixin class _$CreditLedgerModelCopyWith<$Res>
    implements $CreditLedgerModelCopyWith<$Res> {
  factory _$CreditLedgerModelCopyWith(
          _CreditLedgerModel value, $Res Function(_CreditLedgerModel) _then) =
      __$CreditLedgerModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int ledgerId,
      String type,
      String description,
      int amount,
      String occurredAt});
}

/// @nodoc
class __$CreditLedgerModelCopyWithImpl<$Res>
    implements _$CreditLedgerModelCopyWith<$Res> {
  __$CreditLedgerModelCopyWithImpl(this._self, this._then);

  final _CreditLedgerModel _self;
  final $Res Function(_CreditLedgerModel) _then;

  /// Create a copy of CreditLedgerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ledgerId = null,
    Object? type = null,
    Object? description = null,
    Object? amount = null,
    Object? occurredAt = null,
  }) {
    return _then(_CreditLedgerModel(
      ledgerId: null == ledgerId
          ? _self.ledgerId
          : ledgerId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      occurredAt: null == occurredAt
          ? _self.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CreditLedgerListResponseModel {
  int get totalCount;
  int get page;
  int get size;
  bool get hasNext;
  List<CreditLedgerModel> get ledgers;

  /// Create a copy of CreditLedgerListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreditLedgerListResponseModelCopyWith<CreditLedgerListResponseModel>
      get copyWith => _$CreditLedgerListResponseModelCopyWithImpl<
              CreditLedgerListResponseModel>(
          this as CreditLedgerListResponseModel, _$identity);

  /// Serializes this CreditLedgerListResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreditLedgerListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality().equals(other.ledgers, ledgers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(ledgers));

  @override
  String toString() {
    return 'CreditLedgerListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, ledgers: $ledgers)';
  }
}

/// @nodoc
abstract mixin class $CreditLedgerListResponseModelCopyWith<$Res> {
  factory $CreditLedgerListResponseModelCopyWith(
          CreditLedgerListResponseModel value,
          $Res Function(CreditLedgerListResponseModel) _then) =
      _$CreditLedgerListResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<CreditLedgerModel> ledgers});
}

/// @nodoc
class _$CreditLedgerListResponseModelCopyWithImpl<$Res>
    implements $CreditLedgerListResponseModelCopyWith<$Res> {
  _$CreditLedgerListResponseModelCopyWithImpl(this._self, this._then);

  final CreditLedgerListResponseModel _self;
  final $Res Function(CreditLedgerListResponseModel) _then;

  /// Create a copy of CreditLedgerListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? ledgers = null,
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
      ledgers: null == ledgers
          ? _self.ledgers
          : ledgers // ignore: cast_nullable_to_non_nullable
              as List<CreditLedgerModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreditLedgerListResponseModel].
extension CreditLedgerListResponseModelPatterns
    on CreditLedgerListResponseModel {
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
    TResult Function(_CreditLedgerListResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerListResponseModel() when $default != null:
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
    TResult Function(_CreditLedgerListResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerListResponseModel():
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
    TResult? Function(_CreditLedgerListResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerListResponseModel() when $default != null:
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
            List<CreditLedgerModel> ledgers)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.ledgers);
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
            List<CreditLedgerModel> ledgers)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerListResponseModel():
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.ledgers);
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
            List<CreditLedgerModel> ledgers)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreditLedgerListResponseModel() when $default != null:
        return $default(_that.totalCount, _that.page, _that.size, _that.hasNext,
            _that.ledgers);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreditLedgerListResponseModel implements CreditLedgerListResponseModel {
  const _CreditLedgerListResponseModel(
      {required this.totalCount,
      required this.page,
      required this.size,
      required this.hasNext,
      final List<CreditLedgerModel> ledgers = const <CreditLedgerModel>[]})
      : _ledgers = ledgers;
  factory _CreditLedgerListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreditLedgerListResponseModelFromJson(json);

  @override
  final int totalCount;
  @override
  final int page;
  @override
  final int size;
  @override
  final bool hasNext;
  final List<CreditLedgerModel> _ledgers;
  @override
  @JsonKey()
  List<CreditLedgerModel> get ledgers {
    if (_ledgers is EqualUnmodifiableListView) return _ledgers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ledgers);
  }

  /// Create a copy of CreditLedgerListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreditLedgerListResponseModelCopyWith<_CreditLedgerListResponseModel>
      get copyWith => __$CreditLedgerListResponseModelCopyWithImpl<
          _CreditLedgerListResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreditLedgerListResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreditLedgerListResponseModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality().equals(other._ledgers, _ledgers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, page, size, hasNext,
      const DeepCollectionEquality().hash(_ledgers));

  @override
  String toString() {
    return 'CreditLedgerListResponseModel(totalCount: $totalCount, page: $page, size: $size, hasNext: $hasNext, ledgers: $ledgers)';
  }
}

/// @nodoc
abstract mixin class _$CreditLedgerListResponseModelCopyWith<$Res>
    implements $CreditLedgerListResponseModelCopyWith<$Res> {
  factory _$CreditLedgerListResponseModelCopyWith(
          _CreditLedgerListResponseModel value,
          $Res Function(_CreditLedgerListResponseModel) _then) =
      __$CreditLedgerListResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalCount,
      int page,
      int size,
      bool hasNext,
      List<CreditLedgerModel> ledgers});
}

/// @nodoc
class __$CreditLedgerListResponseModelCopyWithImpl<$Res>
    implements _$CreditLedgerListResponseModelCopyWith<$Res> {
  __$CreditLedgerListResponseModelCopyWithImpl(this._self, this._then);

  final _CreditLedgerListResponseModel _self;
  final $Res Function(_CreditLedgerListResponseModel) _then;

  /// Create a copy of CreditLedgerListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalCount = null,
    Object? page = null,
    Object? size = null,
    Object? hasNext = null,
    Object? ledgers = null,
  }) {
    return _then(_CreditLedgerListResponseModel(
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
      ledgers: null == ledgers
          ? _self._ledgers
          : ledgers // ignore: cast_nullable_to_non_nullable
              as List<CreditLedgerModel>,
    ));
  }
}

// dart format on
