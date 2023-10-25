import 'package:flutter/material.dart';

import '../models/category.dart';
import '../provider/get_data_provider.dart';


class CategoryChipsWidget extends StatefulWidget {
  @override
  _CategoryChipsWidgetState createState() => _CategoryChipsWidgetState();
}

class _CategoryChipsWidgetState extends State<CategoryChipsWidget> {
  final GetDataProvider dataProvider = GetDataProvider();
  List<CategoryModel> categoryData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final categories = await dataProvider.getCategory();
    setState(() {
      categoryData = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Adjust as needed to control the spacing between chips.
      children: categoryData.map((category) {
        return Chip(
          label: Text(category.name),
          // Add more styling or functionality to the Chip as needed.
        );
      }).toList(),
    );
  }
}