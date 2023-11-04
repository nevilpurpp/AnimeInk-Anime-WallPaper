import 'package:flutter/material.dart';
import '../Screens/categoryimage.dart';
import '../models/category.dart';
import '../provider/get_data_provider.dart';
class CategoryCard extends StatefulWidget {
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final GetDataProvider dataProvider = GetDataProvider();
  List<CategoryModel> categoryData = [];
late List<CategoryModel> categories;
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

  void _onCategoryTapped(CategoryModel category) {
    // Navigate to a new page with the selected category
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryImagePage(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: categoryData.isEmpty
          ? const Center(child:
           CircularProgressIndicator()
          
           )
          : GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categoryData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final category = categoryData[index];
                return GestureDetector(
                  onTap: () => _onCategoryTapped(category),
                  child: Card(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(category.name!),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
