import 'package:flutter/cupertino.dart';

import '../models/catogery.dart';
import '../helpers/category.dart';

class CategoryProvider with ChangeNotifier{
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = []; //list contains object of type category models

  CategoryProvider.initialize(){
    loadCategories();
  }


//define loadCategories method
  loadCategories()async{
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }
}