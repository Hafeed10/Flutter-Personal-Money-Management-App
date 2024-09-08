import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';
import 'package:personal_money_management_app/db/transaction/transaction_db.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';
import 'package:personal_money_management_app/models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    // Refreshing transaction list when the screen is built
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUI();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Transactions'),
      //   centerTitle: true,
      // ),
      body: ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          if (newList.isEmpty) {
            // Display a message if no transactions are available
            return const Center(
              child: Text('No transactions found'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: newList.length,
            itemBuilder: (ctx, index) {
              final transaction = newList[index];
              return Dismissible(
                confirmDismiss:(direction) async{
                  return false;
                } ,
                 key: Key(transaction.id!), // Ensure that id is not null.
                child: Stack(
                  children: [
                    Card(
                      elevation: 0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Text(
                            parseDate(transaction.date),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          backgroundColor: transaction.type == CategoryType.income
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text('₹ ${transaction.amount.toStringAsFixed(2)}'),
                        subtitle: Text(transaction.category.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Deleting the transaction
                            // TransactionDb.instance.deleteTransaction(transaction.id!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 10);
            },
          );
        },
      ),
    );
  }

  // Function to format the date into a day-month-year format
  String parseDate(DateTime date) {
    final _data = DateFormat.MMMd().format(date);
    final _splitedDate = _data.split('');
   return '${_splitedDate.last}\n ${_splitedDate.first}';
    // '${date.day}\n${date.month} ${date.year}';
  }
}
