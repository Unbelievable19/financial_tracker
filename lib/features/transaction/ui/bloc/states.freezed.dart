// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionDraft {

 String get title; bool get isIncome; DateTime get date; Category? get category; int? get valueKopecks; int? get id;
/// Create a copy of TransactionDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionDraftCopyWith<TransactionDraft> get copyWith => _$TransactionDraftCopyWithImpl<TransactionDraft>(this as TransactionDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.isIncome, isIncome) || other.isIncome == isIncome)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.valueKopecks, valueKopecks) || other.valueKopecks == valueKopecks)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,title,isIncome,date,category,valueKopecks,id);

@override
String toString() {
  return 'TransactionDraft(title: $title, isIncome: $isIncome, date: $date, category: $category, valueKopecks: $valueKopecks, id: $id)';
}


}

/// @nodoc
abstract mixin class $TransactionDraftCopyWith<$Res>  {
  factory $TransactionDraftCopyWith(TransactionDraft value, $Res Function(TransactionDraft) _then) = _$TransactionDraftCopyWithImpl;
@useResult
$Res call({
 String title, bool isIncome, DateTime date, Category? category, int? valueKopecks, int? id
});




}
/// @nodoc
class _$TransactionDraftCopyWithImpl<$Res>
    implements $TransactionDraftCopyWith<$Res> {
  _$TransactionDraftCopyWithImpl(this._self, this._then);

  final TransactionDraft _self;
  final $Res Function(TransactionDraft) _then;

/// Create a copy of TransactionDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? isIncome = null,Object? date = null,Object? category = freezed,Object? valueKopecks = freezed,Object? id = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isIncome: null == isIncome ? _self.isIncome : isIncome // ignore: cast_nullable_to_non_nullable
as bool,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category?,valueKopecks: freezed == valueKopecks ? _self.valueKopecks : valueKopecks // ignore: cast_nullable_to_non_nullable
as int?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc


class _TransactionDraft implements TransactionDraft {
  const _TransactionDraft({required this.title, required this.isIncome, required this.date, this.category, this.valueKopecks, this.id});
  

@override final  String title;
@override final  bool isIncome;
@override final  DateTime date;
@override final  Category? category;
@override final  int? valueKopecks;
@override final  int? id;

/// Create a copy of TransactionDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionDraftCopyWith<_TransactionDraft> get copyWith => __$TransactionDraftCopyWithImpl<_TransactionDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.isIncome, isIncome) || other.isIncome == isIncome)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.valueKopecks, valueKopecks) || other.valueKopecks == valueKopecks)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,title,isIncome,date,category,valueKopecks,id);

@override
String toString() {
  return 'TransactionDraft(title: $title, isIncome: $isIncome, date: $date, category: $category, valueKopecks: $valueKopecks, id: $id)';
}


}

/// @nodoc
abstract mixin class _$TransactionDraftCopyWith<$Res> implements $TransactionDraftCopyWith<$Res> {
  factory _$TransactionDraftCopyWith(_TransactionDraft value, $Res Function(_TransactionDraft) _then) = __$TransactionDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, bool isIncome, DateTime date, Category? category, int? valueKopecks, int? id
});




}
/// @nodoc
class __$TransactionDraftCopyWithImpl<$Res>
    implements _$TransactionDraftCopyWith<$Res> {
  __$TransactionDraftCopyWithImpl(this._self, this._then);

  final _TransactionDraft _self;
  final $Res Function(_TransactionDraft) _then;

/// Create a copy of TransactionDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? isIncome = null,Object? date = null,Object? category = freezed,Object? valueKopecks = freezed,Object? id = freezed,}) {
  return _then(_TransactionDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isIncome: null == isIncome ? _self.isIncome : isIncome // ignore: cast_nullable_to_non_nullable
as bool,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category?,valueKopecks: freezed == valueKopecks ? _self.valueKopecks : valueKopecks // ignore: cast_nullable_to_non_nullable
as int?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
