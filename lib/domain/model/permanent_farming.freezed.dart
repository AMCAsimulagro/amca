// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permanent_farming.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PermanentFarming implements DiagnosticableTreeMixin {
  String? get id;
  set id(String? value);
  DateTime get createDate;
  set createDate(DateTime value);
  String get totalProfit;
  set totalProfit(String value);
  String get partName;
  set partName(String value);
  String get cropType;
  set cropType(String value);
  String get crop;
  set crop(String value);
  String get sownArea;
  set sownArea(String value);
  String get sownType;
  set sownType(String value);
  String get format;
  set format(String value);
  String get amountSown;
  set amountSown(String value);
  String get value;
  set value(String value);
  String? get uidOwner;
  set uidOwner(String? value);
  String? get comment;
  set comment(String? value);
  List<CostAndExpense>? get costsAndExpenses;
  set costsAndExpenses(List<CostAndExpense>? value); //Production? production,
  List<Production>? get production; //Production? production,
  set production(List<Production>? value);

  /// Create a copy of PermanentFarming
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PermanentFarmingCopyWith<PermanentFarming> get copyWith =>
      _$PermanentFarmingCopyWithImpl<PermanentFarming>(
          this as PermanentFarming, _$identity);

  /// Serializes this PermanentFarming to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'PermanentFarming'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createDate', createDate))
      ..add(DiagnosticsProperty('totalProfit', totalProfit))
      ..add(DiagnosticsProperty('partName', partName))
      ..add(DiagnosticsProperty('cropType', cropType))
      ..add(DiagnosticsProperty('crop', crop))
      ..add(DiagnosticsProperty('sownArea', sownArea))
      ..add(DiagnosticsProperty('sownType', sownType))
      ..add(DiagnosticsProperty('format', format))
      ..add(DiagnosticsProperty('amountSown', amountSown))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('uidOwner', uidOwner))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('costsAndExpenses', costsAndExpenses))
      ..add(DiagnosticsProperty('production', production));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PermanentFarming(id: $id, createDate: $createDate, totalProfit: $totalProfit, partName: $partName, cropType: $cropType, crop: $crop, sownArea: $sownArea, sownType: $sownType, format: $format, amountSown: $amountSown, value: $value, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class $PermanentFarmingCopyWith<$Res> {
  factory $PermanentFarmingCopyWith(
          PermanentFarming value, $Res Function(PermanentFarming) _then) =
      _$PermanentFarmingCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      DateTime createDate,
      String totalProfit,
      String partName,
      String cropType,
      String crop,
      String sownArea,
      String sownType,
      String format,
      String amountSown,
      String value,
      String? uidOwner,
      String? comment,
      List<CostAndExpense>? costsAndExpenses,
      List<Production>? production});
}

/// @nodoc
class _$PermanentFarmingCopyWithImpl<$Res>
    implements $PermanentFarmingCopyWith<$Res> {
  _$PermanentFarmingCopyWithImpl(this._self, this._then);

  final PermanentFarming _self;
  final $Res Function(PermanentFarming) _then;

  /// Create a copy of PermanentFarming
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createDate = null,
    Object? totalProfit = null,
    Object? partName = null,
    Object? cropType = null,
    Object? crop = null,
    Object? sownArea = null,
    Object? sownType = null,
    Object? format = null,
    Object? amountSown = null,
    Object? value = null,
    Object? uidOwner = freezed,
    Object? comment = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalProfit: null == totalProfit
          ? _self.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as String,
      partName: null == partName
          ? _self.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String,
      cropType: null == cropType
          ? _self.cropType
          : cropType // ignore: cast_nullable_to_non_nullable
              as String,
      crop: null == crop
          ? _self.crop
          : crop // ignore: cast_nullable_to_non_nullable
              as String,
      sownArea: null == sownArea
          ? _self.sownArea
          : sownArea // ignore: cast_nullable_to_non_nullable
              as String,
      sownType: null == sownType
          ? _self.sownType
          : sownType // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      amountSown: null == amountSown
          ? _self.amountSown
          : amountSown // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      uidOwner: freezed == uidOwner
          ? _self.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      costsAndExpenses: freezed == costsAndExpenses
          ? _self.costsAndExpenses
          : costsAndExpenses // ignore: cast_nullable_to_non_nullable
              as List<CostAndExpense>?,
      production: freezed == production
          ? _self.production
          : production // ignore: cast_nullable_to_non_nullable
              as List<Production>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PermanentFarming extends PermanentFarming with DiagnosticableTreeMixin {
  _PermanentFarming(
      {this.id,
      required this.createDate,
      required this.totalProfit,
      required this.partName,
      required this.cropType,
      required this.crop,
      required this.sownArea,
      required this.sownType,
      required this.format,
      required this.amountSown,
      required this.value,
      this.uidOwner,
      this.comment,
      this.costsAndExpenses,
      this.production})
      : super._();
  factory _PermanentFarming.fromJson(Map<String, dynamic> json) =>
      _$PermanentFarmingFromJson(json);

  @override
  String? id;
  @override
  DateTime createDate;
  @override
  String totalProfit;
  @override
  String partName;
  @override
  String cropType;
  @override
  String crop;
  @override
  String sownArea;
  @override
  String sownType;
  @override
  String format;
  @override
  String amountSown;
  @override
  String value;
  @override
  String? uidOwner;
  @override
  String? comment;
  @override
  List<CostAndExpense>? costsAndExpenses;
//Production? production,
  @override
  List<Production>? production;

  /// Create a copy of PermanentFarming
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PermanentFarmingCopyWith<_PermanentFarming> get copyWith =>
      __$PermanentFarmingCopyWithImpl<_PermanentFarming>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PermanentFarmingToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'PermanentFarming'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createDate', createDate))
      ..add(DiagnosticsProperty('totalProfit', totalProfit))
      ..add(DiagnosticsProperty('partName', partName))
      ..add(DiagnosticsProperty('cropType', cropType))
      ..add(DiagnosticsProperty('crop', crop))
      ..add(DiagnosticsProperty('sownArea', sownArea))
      ..add(DiagnosticsProperty('sownType', sownType))
      ..add(DiagnosticsProperty('format', format))
      ..add(DiagnosticsProperty('amountSown', amountSown))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('uidOwner', uidOwner))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('costsAndExpenses', costsAndExpenses))
      ..add(DiagnosticsProperty('production', production));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PermanentFarming(id: $id, createDate: $createDate, totalProfit: $totalProfit, partName: $partName, cropType: $cropType, crop: $crop, sownArea: $sownArea, sownType: $sownType, format: $format, amountSown: $amountSown, value: $value, uidOwner: $uidOwner, comment: $comment, costsAndExpenses: $costsAndExpenses, production: $production)';
  }
}

/// @nodoc
abstract mixin class _$PermanentFarmingCopyWith<$Res>
    implements $PermanentFarmingCopyWith<$Res> {
  factory _$PermanentFarmingCopyWith(
          _PermanentFarming value, $Res Function(_PermanentFarming) _then) =
      __$PermanentFarmingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      DateTime createDate,
      String totalProfit,
      String partName,
      String cropType,
      String crop,
      String sownArea,
      String sownType,
      String format,
      String amountSown,
      String value,
      String? uidOwner,
      String? comment,
      List<CostAndExpense>? costsAndExpenses,
      List<Production>? production});
}

/// @nodoc
class __$PermanentFarmingCopyWithImpl<$Res>
    implements _$PermanentFarmingCopyWith<$Res> {
  __$PermanentFarmingCopyWithImpl(this._self, this._then);

  final _PermanentFarming _self;
  final $Res Function(_PermanentFarming) _then;

  /// Create a copy of PermanentFarming
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? createDate = null,
    Object? totalProfit = null,
    Object? partName = null,
    Object? cropType = null,
    Object? crop = null,
    Object? sownArea = null,
    Object? sownType = null,
    Object? format = null,
    Object? amountSown = null,
    Object? value = null,
    Object? uidOwner = freezed,
    Object? comment = freezed,
    Object? costsAndExpenses = freezed,
    Object? production = freezed,
  }) {
    return _then(_PermanentFarming(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalProfit: null == totalProfit
          ? _self.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as String,
      partName: null == partName
          ? _self.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String,
      cropType: null == cropType
          ? _self.cropType
          : cropType // ignore: cast_nullable_to_non_nullable
              as String,
      crop: null == crop
          ? _self.crop
          : crop // ignore: cast_nullable_to_non_nullable
              as String,
      sownArea: null == sownArea
          ? _self.sownArea
          : sownArea // ignore: cast_nullable_to_non_nullable
              as String,
      sownType: null == sownType
          ? _self.sownType
          : sownType // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      amountSown: null == amountSown
          ? _self.amountSown
          : amountSown // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      uidOwner: freezed == uidOwner
          ? _self.uidOwner
          : uidOwner // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      costsAndExpenses: freezed == costsAndExpenses
          ? _self.costsAndExpenses
          : costsAndExpenses // ignore: cast_nullable_to_non_nullable
              as List<CostAndExpense>?,
      production: freezed == production
          ? _self.production
          : production // ignore: cast_nullable_to_non_nullable
              as List<Production>?,
    ));
  }
}

// dart format on
