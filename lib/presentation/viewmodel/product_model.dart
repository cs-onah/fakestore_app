import 'package:ecommerce_app/services/api_service.dart';
import 'package:flutter/cupertino.dart';

import '../../models/product.dart';

class ProductViewmodel extends ChangeNotifier{
  List<Product> products = [];
  final service = ApiService();

  int page = 1;

  bool loading = false;

  Future fetchProduct([int? pageNumber]) async {
    if(pageNumber != null) page = pageNumber;
    print(page);
    try{
      loading = true;
      List<Product> res = await service.getProductsPage(page);
      if(page == 1) {products = res;}
      else {products.addAll(res);}
      notifyListeners();
      page +=1;
    } catch(e){
      print(e.toString());
    }
    loading = false;
  }
}