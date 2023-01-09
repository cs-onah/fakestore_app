import 'package:ecommerce_app/presentation/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommerce_app/services/api_service.dart';
import 'package:ecommerce_app/models/product.dart';


class ProductDetailScreen extends StatelessWidget {
  final int id;
  ProductDetailScreen({Key? key, required this.id}) : super(key: key);

  ApiService service = GetIt.I<ApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  CartScreen()));
            },
            icon: const Icon(Icons.shopping_cart, size: 30.0,),
            padding: const EdgeInsets.all(6.0),
            tooltip: 'Cart',
          )
        ],
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: FutureBuilder(
          future: service.getProduct(id),
          builder: (BuildContext context, AsyncSnapshot<Product?> snapshot){
            if(!snapshot.hasData){
              return  const Center(child: CircularProgressIndicator());
            }
            final product = snapshot.data;
            if(product == null){
              return const Center(
                child: Text(
                    'Opps, No Product Found',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(

                children: [
                  const SizedBox(height: 20,),
                  Image.network(
                      '${product.image}' ?? '',
                       height: 150,
                       width: double.infinity,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 25
                    ),
                  ),
                  Chip(
                    label: Text(
                      product.category ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.blueGrey,
                  ),
                  const SizedBox(height: 30),
                  Text(product.description ?? ''),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 100,
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () async{
            await service.updateCart(1, id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product added to cart"))
            );
          },
          shape: RoundedRectangleBorder(),
          child: const Text("Add to cart"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat
    );
  }
}
