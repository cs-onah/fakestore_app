import 'package:ecommerce_app/presentation/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/api_service.dart';

import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  ApiService get service => GetIt.I<ApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search, size: 30.0,)
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, size: 30.0,),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>  CartScreen(),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: service.getAllProducts(),
          builder: (_, AsyncSnapshot<List<Product>> snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            final product = snapshot.data!;
            return GridView.builder(
                itemCount: product.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 4
                ),
                itemBuilder: ((context, index){
                  final product = snapshot.data![index];
                  return Column(
                    children: [
                      const SizedBox(height: 20,),
                      Image.network(
                        product.image ?? '',
                        height: 60,
                        width: 60,
                      ),
                      ListTile(
                        title: Text(product.title, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis,),
                        subtitle: Text("\$${product.price}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_)=>  ProductDetailScreen(id: product.id,))
                          );
                        },
                      ),
                    ],
                  );
                }),
             //   separatorBuilder: (_,__) => const SizedBox(height: 4,),
            );
          },
        ),
      ),
    );
  }
}
