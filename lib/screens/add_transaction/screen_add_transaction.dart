import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';

class ScreenAddTransaction extends StatelessWidget {
   static const routeName = 'add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration:const InputDecoration(
                  hintText: 'Purpose'

                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                 decoration:const InputDecoration(
                  hintText: 'Amount'

                ),
              ),
              TextButton.icon(
                onPressed: () async{
                 final _selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                   firstDate:DateTime.now().subtract(const Duration(days: 30)) ,
                    lastDate: DateTime.now(),
                    );
                if(_selectedDate == null){
                  return;
                }else{
                  print(_selectedDate.toString());
                }
                }, 
                icon:const Icon(Icons.calendar_today),
                label: const Text('Select Date'),
                ),
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