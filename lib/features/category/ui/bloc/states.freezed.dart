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
mixin _$CategoriesLoaded {

 List<Category> get categories; Category? get selected; bool get didCreateNew;
/// Create a copy of CategoriesLoaded
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesLoadedCopyWith<CategoriesLoaded> get copyWith => _$CategoriesLoadedCopyWithImpl<CategoriesLoaded>(this as CategoriesLoaded, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesLoaded&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.didCreateNew, didCreateNew) || other.didCreateNew == didCreateNew));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(categories),selected,didCreateNew);

@override
String toString() {
  return 'CategoriesLoaded(categories: $categories, selected: $selected, didCreateNew: $didCreateNew)';
}


}

/// @nodoc
abstract mixin class $CategoriesLoadedCopyWith<$Res>  {
  factory $CategoriesLoadedCopyWith(CategoriesLoaded value, $Res Function(CategoriesLoaded) _then) = _$CategoriesLoadedCopyWithImpl;
@useResult
$Res call({
 List<Category> categories, Category? selected, bool didCreateNew
});




}
/// @nodoc
class _$CategoriesLoadedCopyWithImpl<$Res>
    implements $CategoriesLoadedCopyWith<$Res> {
  _$CategoriesLoadedCopyWithImpl(this._self, this._then);

  final CategoriesLoaded _self;
  final $Res Function(CategoriesLoaded) _then;

/// Create a copy of CategoriesLoaded
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? selected = freezed,Object? didCreateNew = null,}) {
  return _then(_self.copyWith(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as Category?,didCreateNew: null == didCreateNew ? _self.didCreateNew : didCreateNew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _CategoriesLoaded implements CategoriesLoaded {
  const _CategoriesLoaded({required final  List<Category> categories, this.selected, this.didCreateNew = false}): _categories = categories;
  

 final  List<Category> _categories;
@override List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  Category? selected;
@override@JsonKey() final  bool didCreateNew;

/// Create a copy of CategoriesLoaded
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoriesLoadedCopyWith<_CategoriesLoaded> get copyWith => __$CategoriesLoadedCopyWithImpl<_CategoriesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoriesLoaded&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.didCreateNew, didCreateNew) || other.didCreateNew == didCreateNew));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),selected,didCreateNew);

@override
String toString() {
  return 'CategoriesLoaded(categories: $categories, selected: $selected, didCreateNew: $didCreateNew)';
}


}

/// @nodoc
abstract mixin class _$CategoriesLoadedCopyWith<$Res> implements $CategoriesLoadedCopyWith<$Res> {
  factory _$CategoriesLoadedCopyWith(_CategoriesLoaded value, $Res Function(_CategoriesLoaded) _then) = __$CategoriesLoadedCopyWithImpl;
@override @useResult
$Res call({
 List<Category> categories, Category? selected, bool didCreateNew
});




}
/// @nodoc
class __$CategoriesLoadedCopyWithImpl<$Res>
    implements _$CategoriesLoadedCopyWith<$Res> {
  __$CategoriesLoadedCopyWithImpl(this._self, this._then);

  final _CategoriesLoaded _self;
  final $Res Function(_CategoriesLoaded) _then;

/// Create a copy of CategoriesLoaded
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? selected = freezed,Object? didCreateNew = null,}) {
  return _then(_CategoriesLoaded(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as Category?,didCreateNew: null == didCreateNew ? _self.didCreateNew : didCreateNew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
