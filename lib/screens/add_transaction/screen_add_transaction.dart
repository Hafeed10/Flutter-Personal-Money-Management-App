import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';

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
                decoration:const InputDecoration(
                  hintText: 'Purpose'

                ),
              ),
              //Amount
              TextFormField(
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
                          value: false,
                           groupValue:CategoryType.income,
                            onChanged: (newValue){
                        
                            },
                            ),
                            Text('Income'),
                      ],
                    ),

                     //Expense Radio button
                     Row(
                      children: [
                        Radio(
                          value: false,
                           groupValue:CategoryType.expense,
                            onChanged: (newValue){
                        
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
                //  value:selectdValue,
                items: CategoryDb().expenseCategoryListListener.value.map((e){
                  return DropdownMenuItem(
                    value:e.id,
                    child: Text(e.name),
                  );
                }).toList(),
                 onChanged: (selectdValue){
                  print(selectdValue);
                 }
                 ),

                 //Submit Button
                ElevatedButton(
                   onPressed: () {
                     // Your onPressed logic here
                   },
                   child: Text('Submit'),      // The label displayed next to the icon
                 )

            ],
          ),
        )
      ) ,
    );
  }
}