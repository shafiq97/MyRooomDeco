import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Order {
  String name, email, date, address, phone, price;
  int orderNumber;
  List<dynamic> orderDetails;

  Order({
    required this.name,
    required this.email,
    required this.date,
    required this.address,
    required this.phone,
    required this.price,
    required this.orderNumber,
    required this.orderDetails,
  });
}

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order> orders = [];
  bool isDroppedDown = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(uid)
        .collection('orders')
        .get();
    List<Order> items = querySnapshot.docs.map((doc) {
      return Order(
        name: doc.data()['userName'],
        price: doc.data()['orderPrice'],
        date: doc.data()['date'].toString(),
        email: doc.data()['email'],
        orderNumber: doc.data()['orderNumber'],
        phone: doc.data()['phone'],
        address: doc.data()['address'],
        orderDetails: doc.data()['orderDetails'],
      );
    }).toList();
    setState(() {
      orders = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple, // Customize as per your theme
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                Order order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Implement navigation or other functionality
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Number: ${order.orderNumber}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Order Price: ${order.price} MYR',
                            style: TextStyle(color: Colors.orangeAccent),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Order Date: ${order.date}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          // ...add more fields as necessary
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
