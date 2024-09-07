// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';
import 'package:personal_money_management_app/db/transaction/transaction_db.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';
import 'package:personal_money_management_app/models/transaction/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
   static const routeName = 'add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
 DateTime? _selectedDate;
 CategoryType? _selectedCategorytype;
 CategoryModel? _selectedCategoryModel;

 String ? _categoryID;
final _purposeTextEditingController = TextEditingController();
final _amountTextEditingController = TextEditingController();

@override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Purpos'
              TextFormField(
                controller: _purposeTextEditingController,
                decoration:const InputDecoration(
                  hintText: 'Purpose'

                ),
              ),
              //Amount
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                 decoration:const InputDecoration(
                  hintText: 'Amount'

                ),
              ),

              //calendar
           TextButton.icon(
          onPressed: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 30)),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            setState(() {
              _selectedDate = pickedDate;
            });
          }
        },
        icon: const Icon(Icons.calendar_today),
        label: Text(
          _selectedDate == null
              ? 'Select Date'
              : _selectedDate!.toString(),
        ),
           ),
           //Income Radio button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: CategoryType.income,
                           groupValue:_selectedCategorytype,
                            onChanged: (newValue){
                              setState(() {
                              _selectedCategorytype = CategoryType.income;
                              _categoryID = null;
                              });
                        
                            },
                            ),
                            Text('Income'),
                      ],
                    ),

                     //Expense Radio button
                     Row(
                      children: [
                        Radio(
                          value: CategoryType.expense,
                           groupValue:_selectedCategorytype,
                            onChanged: (newValue){
                              setState(() {
                              _selectedCategorytype = CategoryType.expense;
                              _categoryID = null;
                              });
                        
                            },
                            ),
                            Text('Expense'),
                      ],
                    ),
                  ],
                ),
                //Category Dropdown button
                DropdownButton(
                  hint: Text('Select Category'),
                 value: _categoryID,
                items:(
                  _selectedCategorytype == CategoryType.income?
                   CategoryDb().incomeCategoryListListener 
                   : CategoryDb().expenseCategoryListListener)
                   .value
                   .map((e){
                  return DropdownMenuItem(
                    value:e.id,
                    child: Text(e.name),
                    onTap: (){
                      _selectedCategoryModel = e;
                    },
                  );
                }).toList(),
                 onChanged: (selectdValue){
                  print(selectdValue);
                  setState(() {
                  _categoryID = selectdValue;
                    
                  });
                 }
                 ),

                 //Submit Button
                ElevatedButton(
                   onPressed: () {
                     addTransaction();
                   },
                   child: Text('Submit'),      // The label displayed next to the icon
                 )

            ],
          ),
        )
      ) ,
    );

   
  }
 Future<void> addTransaction() async {
  // Fetch the input data from TextEditingControllers or form fields
  final String _purposeText = _purposeTextEditingController.text;
   final String _amountText = _amountTextEditingController.text;
  
  // Validation

  if(_purposeText.isEmpty){
    return;
  }
  if(_amountText.isEmpty){
    return;
  }
  if(_categoryID == null){
    return;
  }
   if(_selectedDate == null){
    return;
  }
  if(_selectedCategoryModel == null){
    return;
  }
  
  final _parsedAmount = double.tryParse(_amountText); 
  if(_parsedAmount == null){
    return;
  }
 final _model =  TransactionModel(
    purpose: _purposeText,
     amount: _parsedAmount, 
     date: _selectedDate!, 
     type: _selectedCategorytype!, 
     category: _selectedCategoryModel!,
    
     );

     TransactionDb.instance.addTransaction(_model);

 
}

}