import 'package:drift/drift.dart';
import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:flutter/material.dart';

abstract class CategoriesRepository {
  Stream<List<Category>> categories();

  Future<Category> addCategory({required String title, required Color color});

  Future<Category> updateCategory({
    required int id,
    String? title,
    Color? color,
  });

  Future<void> removeCategory(int id);
}

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Category>> categories() {
    final query = _db.select(_db.categories);
    return query.watch();
  }

  @override
  Future<Category> addCategory({
    required String title,
    required Color color,
  }) async {
    return _db
        .into(_db.categories)
        .insertReturning(
          CategoriesCompanion.insert(title: title, color: color.hex),
        );
  }

  @override
  Future<Category> updateCategory({
    required int id,
    String? title,
    Color? color,
  }) async {
    final returns = await (_db.update(_db.categories)
      ..where((c) => c.id.equals(id))).writeReturning(
      CategoriesCompanion(
        id: Value(id),
        title: Value.absentIfNull(title),
        color: Value.absentIfNull(color?.hex),
      ),
    );
    if (returns.isEmpty) throw Exception();
    return returns.first;
  }

  @override
  Future<void> removeCategory(int id) async {
    await (_db.delete(_db.categories)..where((c) => c.id.equals(id))).go();
  }
}
