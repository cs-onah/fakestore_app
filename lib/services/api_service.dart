import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/models/user_login.dart';

import '../models/cart.dart';
import '../models/cart_update.dart';
import '../models/product.dart';

class ApiService{
  static const String baseUrl = 'https://fakestoreapi.com';
  static const headers = {'Content-type': 'application/json'};

  Future<dynamic> login(String username, String password) async {
    final params = UserLogin(username: username, password: password);
    return http.post(Uri.parse('$baseUrl/auth/login'), body: params.toJson())
        .then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        return jsonData;
      }
    }).catchError((error)=> print(error));

  }

  Future<List<Product>> getAllProducts() async{
    return http.get(Uri.parse('$baseUrl/products'), headers: headers)
        .then((data){
          final products = <Product>[];
          if(data.statusCode == 200){
            final jsonData = json.decode(data.body);
            for(var product in jsonData) {
              products.add(Product.fromJson(product));
            }
          }
          return products;
    }).catchError((err) => print(err));
  }

  static const int pageLimit = 10;
  Future<List<Product>> getProductsPage([int page = 1]) async{
    return http.get(Uri.parse('$baseUrl/products?limit=$pageLimit&page=$page'), headers: headers)
        .then((data){
      final products = <Product>[];
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        for(var product in jsonData) {
          products.add(Product.fromJson(product));
        }
      }
      return products;
    });
  }


  Future<Product?> getProduct(int id) {
    return http.get(Uri.parse('$baseUrl/products/$id'), headers: headers)
        .then((data) {
          if(data.statusCode == 200){
            final jsonData = json.decode(data.body);
            return Product.fromJson(jsonData);
          }
          return null;
    }).catchError((error) => print(error));
  }

  Future<void> updateCart(int cartId, int productId) {
    final cartUpdate =
    CartUpdate(userId: cartId, date: DateTime.now(), products: [
      {'productId': productId, 'quantity': 1}
    ]);
    return http
        .put(Uri.parse('$baseUrl/carts/$cartId'),
        body: json.encode(cartUpdate.toJson()), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }

  Future<Cart?> getCart(String id) {
    return http
        .get(Uri.parse('$baseUrl/carts/$id'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return Cart.fromJson(jsonData);
      }
      return null;
    }).catchError((err) => print(err));
  }


  Future<void> deleteCart(String cartId) {
    return http
        .delete(Uri.parse('$baseUrl/carts/$cartId'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }


}

