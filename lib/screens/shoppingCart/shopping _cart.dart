import 'package:flutter/material.dart';

import '../home/components/products.dart';
import 'items/shopping_cart_item.dart';

class shoppingCart extends StatelessWidget {
  const shoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: const Text("Total Amount"),
        subtitle: const Text("\$ 170.00"),
        trailing: Container(
          width: 160,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(30),
          ),
          child: MaterialButton(
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Shopping Cart"),
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 20,
          ),
          shoppingCartItem(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
