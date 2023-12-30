import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../data/data.dart';

class Categories extends StatefulWidget {
  final Function(int) onCategorySelected;
  const Categories({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedCategoryIndex = 0;

  void _onCategoryTap(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
    widget.onCategorySelected(index); // Add this line to use the callback
  }

  Widget _buildCategoryList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _onCategoryTap(index),
      child: Padding(
        padding: const EdgeInsets.only(left: appPadding),
        child: Column(
          children: [
            Text(
              categoryList[index],
              style: TextStyle(
                color: selectedCategoryIndex == index
                    ? black
                    : black.withOpacity(0.1),
                fontSize: 18,
                fontWeight: selectedCategoryIndex == index
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            Container(
              height: 3,
              width: 25,
              decoration: BoxDecoration(
                color: selectedCategoryIndex == index
                    ? orange
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: appPadding),
      child: SizedBox(
        height: size.height * 0.05,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return _buildCategoryList(context, index);
            }),
      ),
    );
  }
}
