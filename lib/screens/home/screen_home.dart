import 'package:flutter/material.dart';
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
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
