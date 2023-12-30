import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../data/data.dart';
import '../../../models/product_model.dart';
import '../../details/details_screen.dart';

// Change Products to a StatefulWidget
class Products extends StatefulWidget {
  final String category;

  const Products({Key? key, required this.category}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

// Define the corresponding State class for the StatefulWidget
class _ProductsState extends State<Products> {
  // The _buildProducts method remains the same, but now accesses the filteredList based on the widget's category
  Widget _buildProducts(
      BuildContext context, int index, List<ProductModel> filteredList) {
    Size size = MediaQuery.of(context).size;
    ProductModel productModel = filteredList[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(
              product: productModel,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(appPadding / 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                productModel.imageUrl,
                fit: BoxFit.cover,
                height: size.height * 0.24,
                width: size.width * 0.45,
              ),
            ),
            Expanded(
              child: Text(
                productModel.name,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: black,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'by ${productModel.manufacturer}',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: black.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // The build method now uses widget.category to filter the productList
  @override
  Widget build(BuildContext context) {
    List<ProductModel> filteredList = productList
        .where((product) => product.category == widget.category)
        .toList();

    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding),
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: appPadding * 2),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
              ),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return Transform.translate(
                  offset: Offset(0.0, index.isOdd ? 30 : 0.0),
                  child: _buildProducts(context, index, filteredList),
                );
              },
            )));
  }
}
