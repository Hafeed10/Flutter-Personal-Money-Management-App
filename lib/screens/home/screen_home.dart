import 'package:flutter/material.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';
import 'package:personal_money_management_app/screens/category/category_add_popup.dart';
import 'package:personal_money_management_app/screens/category/screen_category.dart';
import 'package:personal_money_management_app/screens/home/widgets/bottom_navigation.dart';
import 'package:personal_money_management_app/screens/transaction/screen_transction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final List<Widget> _pages = const [
    ScreenTransction(),
    ScreenCategory(), // Corrected typo
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('MONEY MANAGER'),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder<int>(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext context, int updatedIndex, _) {
              return _pages[updatedIndex]; // Return the correct page
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
       onPressed: () {
  if (selectedIndexNotifier.value == 0) {
    print('Add transaction');
    
  } else {
     print('Add category');
     showCategoryAddPopup(context);
    // final _sample = CategoryModel(
    //   id: DateTime.now().microsecondsSinceEpoch.toString(),
    //   name: 'Travel',
    //   type: CategoryType.expense,
    // );
    // // Insert the category into the database
    // CategoryDb().insertCategory(_sample);
  }
},

        child: const Icon(Icons.add),
      ),
    );
  }
}
