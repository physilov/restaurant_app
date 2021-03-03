import 'package:flutter/material.dart';
import 'package:restaurant_app/src/helpers/product.dart';
import 'package:restaurant_app/src/models/products.dart';


class ProductProvider with ChangeNotifier{
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsSearched = [];
  List<ProductModel> featuredProducts = [];

  ProductProvider.initialize(){
    loadProducts();
  }

  loadProducts()async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName}) async {
    productsByCategory = await _productServices.getProductsbyCategory(category: categoryName);
    notifyListeners();
  }

  Future getFeaturedProducts() async {
    featuredProducts = await _productServices.getFeaturedProducts();
    notifyListeners();
  }

  Future search({String productName}) async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    print("The number of products detected is: ${productsSearched.length}");
    notifyListeners();
  }
}