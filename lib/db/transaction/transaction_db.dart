import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';
import 'package:personal_money_management_app/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModel obj);
  // Future<void> deleteCategory(String categoryID);
  Future<List<TransactionModel>> getAllCategories();
}

class TransactionDb implements TransactionDbFunction {
  TransactionDb._internal();

 static TransactionDb instance = TransactionDb._internal();

 factory TransactionDb(){
  return instance;
 }

ValueNotifier<List<TransactionModel>> transactionListNotifier = 
ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj); // Added await and fixed the parameter type.
  }

  Future<void> refresh() async{
    final _list =await getAllCategories();
    _list.sort((first, second)=> second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners(); // Notify listeners that the data has changed.
  }
  
 @override
Future<List<TransactionModel>> getAllCategories() async {
  final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
  // Convert the Iterable to a List and return it
  // _db.listenable();
  return _db.values.toList();
}

}
