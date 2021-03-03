import 'package:flutter/material.dart';

enum SearchBy{PRODUCTS, RESTAURANTS}

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  SearchBy search = SearchBy.PRODUCTS;
  String filterBy = "Products";
  double totalPrice = 0;
  double priceSum = 0;
  int quantitySum =0;


  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeSearchBy({SearchBy newSearchBy}){
    search = newSearchBy;
    if(newSearchBy == SearchBy.PRODUCTS){
      filterBy = "Products";
    }else{
      filterBy = "Restaurants";
    }
    notifyListeners();
  }

  addPrice({double newPrice}){
    priceSum += newPrice;
    notifyListeners();
  }

  addQuantity({int newQuantity}){
    quantitySum += newQuantity;
    notifyListeners();
  }

  getTotalPrice(){
    print("The Total Sum is: $priceSum");
    print("The Total Quantity is: $quantitySum");

    totalPrice = priceSum * quantitySum;
    print("THe total amount is: $totalPrice");
    notifyListeners();
  }


}