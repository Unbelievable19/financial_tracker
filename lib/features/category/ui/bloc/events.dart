import 'package:financial_tracker/core/data/db/database.dart';
import 'package:flutter/material.dart';

abstract class CategorySelectorEvent {}

class SubscribedToCategories implements CategorySelectorEvent {
  final Category? category;

  SubscribedToCategories(this.category);
}

class CategoryCreated implements CategorySelectorEvent {
  final String title;
  final Color color;

  CategoryCreated({required this.title, required this.color});
}

class CategorySelected implements CategorySelectorEvent {
  final Category? selected;

  CategorySelected(this.selected);
}