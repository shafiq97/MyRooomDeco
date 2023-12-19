import 'package:flutter/cupertino.dart';
import 'package:gradutionprojec/models/product_model.dart';

class ProductsManager extends ChangeNotifier {
  final List<ProductModel> Fav_lst = [];

  void addFavoriteProduct(ProductModel productModel) {
    Fav_lst.add(productModel);
    notifyListeners();
  }

  void removeFavoriteProduct(ProductModel product) {
    Fav_lst.removeWhere((element) => element.isFave == true);
    notifyListeners();
  }

  bool isFavorite(ProductModel product) {
    try {
      Fav_lst.firstWhere((product) => product.isFave == false);
      return true;
    } catch (e) {
      return false;
    }
  }
}
