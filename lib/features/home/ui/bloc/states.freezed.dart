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
mixin _$HomeLoaded {

// ignore: annotate_overrides
 dynamic get calculator; List<TransactionWithCategory> get transactionsWithCategory;
/// Create a copy of HomeLoaded
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeLoadedCopyWith<HomeLoaded> get copyWith => _$HomeLoadedCopyWithImpl<HomeLoaded>(this as HomeLoaded, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoaded&&const DeepCollectionEquality().equals(other.calculator, calculator)&&const DeepCollectionEquality().equals(other.transactionsWithCategory, transactionsWithCategory));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(calculator),const DeepCollectionEquality().hash(transactionsWithCategory));

@override
String toString() {
  return 'HomeLoaded(calculator: $calculator, transactionsWithCategory: $transactionsWithCategory)';
}


}

/// @nodoc
abstract mixin class $HomeLoadedCopyWith<$Res>  {
  factory $HomeLoadedCopyWith(HomeLoaded value, $Res Function(HomeLoaded) _then) = _$HomeLoadedCopyWithImpl;
@useResult
$Res call({
 List<TransactionWithCategory> transactionsWithCategory
});




}
/// @nodoc
class _$HomeLoadedCopyWithImpl<$Res>
    implements $HomeLoadedCopyWith<$Res> {
  _$HomeLoadedCopyWithImpl(this._self, this._then);

  final HomeLoaded _self;
  final $Res Function(HomeLoaded) _then;

/// Create a copy of HomeLoaded
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionsWithCategory = null,}) {
  return _then(_self.copyWith(
transactionsWithCategory: null == transactionsWithCategory ? _self.transactionsWithCategory : transactionsWithCategory // ignore: cast_nullable_to_non_nullable
as List<TransactionWithCategory>,
  ));
}

}


/// @nodoc


class _HomeLoaded extends HomeLoaded {
   _HomeLoaded({required final  List<TransactionWithCategory> transactionsWithCategory}): _transactionsWithCategory = transactionsWithCategory,super._();
  

 final  List<TransactionWithCategory> _transactionsWithCategory;
@override List<TransactionWithCategory> get transactionsWithCategory {
  if (_transactionsWithCategory is EqualUnmodifiableListView) return _transactionsWithCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactionsWithCategory);
}


/// Create a copy of HomeLoaded
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeLoadedCopyWith<_HomeLoaded> get copyWith => __$HomeLoadedCopyWithImpl<_HomeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeLoaded&&const DeepCollectionEquality().equals(other._transactionsWithCategory, _transactionsWithCategory));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactionsWithCategory));

@override
String toString() {
  return 'HomeLoaded(transactionsWithCategory: $transactionsWithCategory)';
}


}

/// @nodoc
abstract mixin class _$HomeLoadedCopyWith<$Res> implements $HomeLoadedCopyWith<$Res> {
  factory _$HomeLoadedCopyWith(_HomeLoaded value, $Res Function(_HomeLoaded) _then) = __$HomeLoadedCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionWithCategory> transactionsWithCategory
});




}
/// @nodoc
class __$HomeLoadedCopyWithImpl<$Res>
    implements _$HomeLoadedCopyWith<$Res> {
  __$HomeLoadedCopyWithImpl(this._self, this._then);

  final _HomeLoaded _self;
  final $Res Function(_HomeLoaded) _then;

/// Create a copy of HomeLoaded
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionsWithCategory = null,}) {
  return _then(_HomeLoaded(
transactionsWithCategory: null == transactionsWithCategory ? _self._transactionsWithCategory : transactionsWithCategory // ignore: cast_nullable_to_non_nullable
as List<TransactionWithCategory>,
  ));
}


}

// dart format on
