import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';


const CATEGORY_DB_NAME = 'category-database';
abstract class CategoryDbFunctions {
  Future <List<CategoryModel>>getCategories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDb implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModel value) async {
  final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  await  _categoryDB.add(value);
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
    
  }

}