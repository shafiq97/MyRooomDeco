import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

final p1 = ProductModel(
    name: 'metalic bed ',
    quantity: 1,
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s1/bed.png',
    price: 5600,
    color: 'Black',
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    style: 'Modern',
    category: "Interiors",
    ARurl: "assets/s1/bed.gltf");
final p2 = ProductModel(
    name: 'wooden chair ',
    quantity: 1,
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s2/chair.png',
    price: 420,
    color: 'Brown',
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    style: 'Modern',
    category: "Interiors",
    ARurl: "assets/s2/chair.gltf");
final p3 = ProductModel(
    name: 'bedroom drawer',
    quantity: 1,
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s3/drawer.png',
    price: 670,
    color: 'Black',
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    style: 'Modern',
    category: "Interiors",
    ARurl: "assets/s3/drawer.gltf");
final p4 = ProductModel(
    name: 'pouf',
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s4/pouf.png',
    price: 890,
    color: 'Blue',
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    quantity: 1,
    style: 'Modern',
    category: "Interiors",
    ARurl: "assets/s4/pouf.gltf");
final p5 = ProductModel(
    name: 'pink sofa ',
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s5/pinksofa.png',
    price: 3025,
    color: 'Pink',
    quantity: 1,
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    style: 'Modern',
    category: "Furniture",
    ARurl: "assets/s5/pinksofa.gltf");
final p6 = ProductModel(
    name: 'black office chair ',
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s6/office_chair.png',
    price: 3025,
    quantity: 1,
    color: 'Black',
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    category: "Interiors",
    style: 'Modern',
    ARurl: "assets/s6/office_chair.gltf");

final p7 = ProductModel(
    name: 'pouf  ',
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s7/besame_chair.png',
    price: 930,
    color: 'Pink',
    category: "Interiors",
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    quantity: 1,
    style: 'Modern',
    ARurl: "assets/s7/besame_chair.gltf");

final p8 = ProductModel(
    name: 'closet ',
    quantity: 1,
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s8/closet.png',
    price: 8500,
    color: 'Black',
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    category: "Interiors",
    style: 'Modern',
    ARurl: "assets/s8/closet.gltf");

final p9 = ProductModel(
    name: 'blue living couch',
    quantity: 1,
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s9/couch.png',
    price: 3025,
    color: 'Blue',
    category: "Furniture",
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    style: 'Modern',
    ARurl: "assets/s9/couch.gltf");
final p10 = ProductModel(
    name: 'beige living couch ',
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s10/sofa.png',
    price: 3025,
    color: 'Beige',
    quantity: 1,
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    style: 'Modern',
    category: "Furniture",
    ARurl: "assets/s10/sofa.gltf");
final p11 = ProductModel(
    name: 'home chair ',
    manufacturer: 'Nabilah',
    imageUrl: 'assets/s11/chair.png',
    category: "Furniture",
    price: 720,
    color: 'Dark white',
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
    madeIn: 'Russia',
    rating: 5,
    style: 'Modern',
    quantity: 1,
    ARurl: "assets/s11/chair.gltf");

final List<ProductModel> productList = [
  p1,
  p5,
  p6,
  p7,
  p3,
  p4,
  p8,
  p9,
  p10,
  p11,
];

final auth = FirebaseAuth.instance;
String name = "";

final TextEditingController email = TextEditingController();

final TextEditingController password = TextEditingController();

// ignore: non_constant_identifier_names
final TextEditingController PhoneNumber = TextEditingController();
final commentRef = FirebaseFirestore.instance.collection("comments");

RegExp passwordValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
// ignore: non_constant_identifier_names
double password_strength = 0;
late User user;

final formKey = GlobalKey<FormState>();
final TextEditingController userName = TextEditingController();
// final TextEditingController PhoneNumber= TextEditingController();
List<String> categoryList = [
  'Interiors',
  'Furniture',
  'Moods',
  'Creators',
  'Home Appliances'
];
