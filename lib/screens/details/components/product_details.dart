import 'package:gradutionprojec/screens/details/components/star_rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Ar_session.dart';
import '../../../constants/constants.dart';
import '../../../models/product_model.dart';

class add_notes extends StatefulWidget {
  @override
  add_notes({Key? key, required this.productModel}) : super(key: key);
  final ProductModel productModel;

  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("seha");
    Firebase.initializeApp();
    return add_notes_state(productModel);
  }
}

class add_notes_state extends State<add_notes> {
  add_notes_state(ProductModel productModell) {
    this.productModel = productModell;
  }
  String uid = FirebaseAuth.instance.currentUser!.uid;
  ProductModel productModel = new ProductModel(
      name: "name",
      imageUrl: "imageUrl",
      price: 1,
      quantity: 1,
      manufacturer: "",
      description: "",
      color: "",
      rating: 1,
      style: "",
      madeIn: "",
      ARurl: "ARurl");

  static List<ProductModel> Fav_lst = [];
  static List<ProductModel> cart_list = [];

  Widget build(BuildContext context) {
    bool ispressed = false;
    bool cartPressed = false;
    Size size = MediaQuery.of(context).size;
    if (productModel.isFave == false)
      ispressed = false;
    else
      ispressed = true;
    if (productModel.incart == false)
      cartPressed = false;
    else
      cartPressed = true;
    return Container(
      child: Container(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productModel.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'by ${productModel.manufacturer}',
                          style: TextStyle(
                            color: black.withOpacity(0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: size.width * 0.15,
                    height: 75,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: IconButton(
                        icon: (cartPressed == false)
                            ? Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                              )
                            : Icon(Icons.shopping_cart, color: Colors.blue),
                        iconSize: 30,
                        onPressed: () async {
                          if (productModel.incart == false) {
                            setState(() {
                              cartPressed = true;
                            });
                            productModel.incart = true;
                            cart_list.add(productModel);
                            final CollectionReference usersCollection =
                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(uid)
                                    .collection('cart');
                            //  final CollectionReference usersCollection = await FirebaseFirestore.instance.collection('cart');
                            print(usersCollection.parent);
                            Map<String, dynamic> datatosave = {
                              'manf': productModel.manufacturer,
                              'modelname': productModel.name,
                              'price': productModel.price,
                              'quantity': productModel.quantity,
                              'arurl': productModel.imageUrl,
                            };
                            usersCollection.add(datatosave);

                            print(productModel.incart);
                          } else {
                            String uid = FirebaseAuth.instance.currentUser!.uid;

                            CollectionReference<Map<String, dynamic>>
                                productsRef = await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(uid)
                                    .collection('cart');

                            Query<Map<String, dynamic>> query =
                                productsRef.where('modelname',
                                    isEqualTo: productModel.name);

                            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                                await query.get();
                            querySnapshot.docs.forEach((doc) async {
                              await doc.reference.delete();
                            });
                            setState(() {
                              print("false icon");
                              cartPressed = false;
                            });
                            productModel.incart = false;

                            // cart_list.remove(productModel);
                            print(productModel.incart);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '\$${productModel.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        letterSpacing: -0.6,
                        color: orange,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    '${productModel.rating}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  StarRating(rating: productModel.rating),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'fabric color',
                        style: TextStyle(
                          color: black.withOpacity(0.4),
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        productModel.color,
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'style',
                        style: TextStyle(
                          color: black.withOpacity(0.4),
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        productModel.style,
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'made in',
                        style: TextStyle(
                          color: black.withOpacity(0.4),
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        productModel.madeIn,
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                productModel.description,
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(children: [
                    Container(
                      width: size.width * 0.6,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: FloatingActionButton.extended(
                          label: Text('View in AR'),
                          backgroundColor: Colors.black,
                          icon: Icon(
                            Icons.view_in_ar,
                            size: 30,
                          ),
                          foregroundColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AR_Session(value: productModel.ARurl),
                                ));
                          },
                        ),
                      ),
                    ),
                  ]),
                  Container(
                    width: size.width * 0.2,
                    height: 75,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: IconButton(
                        icon: (ispressed == false)
                            ? Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.white,
                              )
                            : Icon(Icons.favorite, color: Colors.red),
                        iconSize: 30,
                        onPressed: () async {
                          if (productModel.isFave == false) {
                            setState(() {
                              print("true icon");
                              ispressed = true;
                            });
                            productModel.isFave = true;

                            //String uid = "7gkm6w6XfhnaC2tWUD4Q";
                            final CollectionReference usersCollection =
                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(uid)
                                    .collection('favourite');
                            print(usersCollection.parent);
                            Map<String, dynamic> datatosave = {
                              'name': productModel.name,
                              'imageurl': productModel.imageUrl,
                              'color': productModel.color,
                              'manfname': productModel.manufacturer,
                              'arurl': productModel.ARurl,
                              'price': productModel.price,
                              'description': productModel.description,
                              'incart': false,
                              'isfave': true,
                              'madein': productModel.madeIn,
                              'price': productModel.price,
                              'quantity': productModel.quantity,
                              'rating': productModel.rating,
                              'style': productModel.style
                            };
                            usersCollection.add(datatosave);
                            // Fav_lst.add(productModel);
                            print(productModel.isFave);
                          } else {
                            print("seha");
                            String uid = FirebaseAuth.instance.currentUser!.uid;
                            // String uid = "7gkm6w6XfhnaC2tWUD4Q";
                            CollectionReference<Map<String, dynamic>>
                                productsRef = await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(uid)
                                    .collection('favourite');

                            Query<Map<String, dynamic>> query = productsRef
                                .where('name', isEqualTo: productModel.name);
                            print("diab " + productModel.name);
                            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                                await query.get();
                            querySnapshot.docs.forEach((doc) async {
                              await doc.reference.delete();
                            });
                            setState(() {
                              print("false icon");
                              ispressed = false;
                            });
                            productModel.isFave = false;
                            // Fav_lst.remove(productModel);
                            print(productModel.isFave);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
