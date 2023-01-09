import 'package:ecommerce_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommerce_app/services/api_service.dart';

import '../../models/cart.dart';
import '../../models/product.dart';


class CartScreen extends StatelessWidget {
   CartScreen({Key? key}) : super(key: key);

  ApiService service = GetIt.I<ApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.shopping_cart, size: 30.0,),
              padding: const EdgeInsets.all(6.0),
              tooltip: 'Cart',
          )
        ],
        backgroundColor: Colors.redAccent,

      ),
      body: FutureBuilder(
        future: service.getCart('1'),
        builder: (BuildContext context, AsyncSnapshot<Cart?> snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.data == null){
            return const Center(child: Text('cart is not available'),);
          }
          final products = snapshot.data!.products;
          return ListView.separated(
              itemCount: products.length,
              itemBuilder: (_, index){
                final product = products[index];
                return FutureBuilder(
                  future: service.getProduct(product['productId']),
                  builder: (BuildContext context, AsyncSnapshot<Product?> productSnapshot){
                    if(!productSnapshot.hasData){
                      return const LinearProgressIndicator();
                    }
                    final productInfo = productSnapshot.data;
                    if(productInfo == null){
                      return const Text("No product found");
                    }
                    return Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(productInfo.title),
                            leading: Image.network(
                                productInfo.image ?? '',
                              height: 50,
                            ),
                            subtitle: Text('Quantity: ${product['quantity']}'),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                            Text('${productInfo.price}'),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await service.deleteCart('1');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Cart deleted successfully.'),
                                    ),
                                  );
                                },
                              ),
                          ],)
                        ],
                      ),
                    );
                  },
                );
          },
              separatorBuilder: ((_,__)=> const SizedBox(height: 10,) ),

          );
        },
      ),
    floatingActionButton: SizedBox(
      height: 50,
      child: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (){},
        shape: RoundedRectangleBorder(),
        child: Text('Total:'),

      ),
    ),
    );
  }
}
