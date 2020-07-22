import 'package:flutter/material.dart';

class CategoryMealsPage extends StatelessWidget {
  final String categoryId;
  final String title;

  CategoryMealsPage(this.categoryId, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('recipe here'),
      ),
    );
  }
}
