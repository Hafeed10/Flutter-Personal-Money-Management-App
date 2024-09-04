import 'package:flutter/material.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';
import 'package:personal_money_management_app/screens/category/expens_category_list.dart';
import 'package:personal_money_management_app/screens/category/income_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin {
 late TabController _tabController;
@override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const[
            Tab(text: 'INCOME',),
            Tab(text: 'EXPENSE'),
          ] ,
        ),
        Expanded(
          child: TabBarView(
             controller: _tabController,
            children: const [
             IncomeCategoryList(),
            ExpenseCategoryList(),
          
            ],
          ),
        ),
      ],
    );
  }
}