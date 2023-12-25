import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradutionprojec/Login_screen.dart';
import 'package:gradutionprojec/cart.dart';
import 'package:gradutionprojec/newfav.dart';

import '../../Mes.dart';
import '../../data/data.dart';
import '../orders/orders.dart';
import '../rateus/reviews.dart';
import 'components/categories.dart';
import 'components/products.dart';
import 'components/search_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("back button pressed");
        final shouldpop = await showWarning(context) as bool?;
        return shouldpop ?? false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            'MyRoom Deco',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),

        //appBar: AppBar(leading: Icon(Icons.accessibility),),
        drawer: NavigationDrawer(),
        backgroundColor: Colors.white,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                // CustomAppBar(),
                MySearchBar(),
                Categories(),
                Products(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Do you want to exist the app?'),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("NO")),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("YES")),
          ],
        ),
      );
}

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser?.email.toString();
    String? Name = FirebaseAuth.instance.currentUser?.displayName.toString();

    // TODO: implement build
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(""),
            accountEmail: Text(email!, style: const TextStyle(fontSize: 17)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Navigate to home screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Orders()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.compare_arrows),
            title: const Text('Area measurement'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const Mes(value: "assets/s14/chair.gltf")),
              );
              // Navigate to favorites screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text('Rate us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Reviewes(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              // Navigate to help screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              auth.signOut().then((value) {
                print('signout');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              });

              // Navigate to help screen
            },
          ),
        ],
      ),
    );
  }
}
