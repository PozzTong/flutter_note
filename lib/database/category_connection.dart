import 'dart:io';
import 'package:flutter_app_vscode/global/constant/data_fiels.dart';
import 'package:flutter_app_vscode/model/category_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDB {
  Future<Database> initializeDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory appDocumentDir = await getTemporaryDirectory();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'category.db'),
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE $categoryTable($category_id INTERGER PRIMARY KEY,$categiry_name TEXT)');
      },
      version: 1,
    );
  }

  Future<void> insertCategory(CategoryModel category) async {
    var db = await initializeDatabase();
    await db.insert(categoryTable, category.toMap());
    print('Ok'); //for stop process
  }

  Future<List<CategoryModel>> getCategory() async {
    var db = await initializeDatabase();
    List<Map<String, dynamic>> result = await db.query(categoryTable);
    return result.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<void> deleteCategory(int categoryId) async {
    var db = await initializeDatabase();
    await db.delete(categoryTable,
        where: '$category_id=?', whereArgs: [categoryId]);
  }

  Future<void> updateCategory(CategoryModel category) async {
    var db = await initializeDatabase();
    await db.update(categoryTable, category.toMap(),
        where: '$category_id=?', whereArgs: [category.id]);
  }
}
