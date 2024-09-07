import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';
import 'package:personal_money_management_app/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModel obj);
  // Future<void> deleteCategory(String categoryID);
}

class TransactionDb implements TransactionDbFunction {
  TransactionDb._internal();

 static TransactionDb instance = TransactionDb._internal();

 factory TransactionDb(){
  return instance;
 }






  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj); // Added await and fixed the parameter type.
  }
}
