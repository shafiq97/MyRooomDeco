import 'package:flutter/material.dart';
import 'package:gradutionprojec/Ar_session.dart';
import 'package:gradutionprojec/data/data.dart';
import 'package:gradutionprojec/models/product_model.dart';
import 'package:gradutionprojec/screens/home/components/products.dart';
import 'package:gradutionprojec/screens/details/components/product_details.dart';

import '../../details/components/star_rating.dart';
import '../../details/details_screen.dart';
import '../../../constants/constants.dart';

class cartScreen extends StatefulWidget {
  List counters = [];
  double total = 0;

  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  TextEditingController _couponController = TextEditingController();
  var _coupon_applied = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    for (var i = 0; i < add_notes_state.cart_list.length; i++) {
      widget.total += add_notes_state.cart_list[i].price;
    }
    return Scaffold(
      bottomNavigationBar: buildBottomAppBar(context),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "cart",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: ListView.builder(
                  itemCount: add_notes_state.cart_list.length,
                  itemBuilder: (context, index) {
                    counter = 1;
                    widget.counters.add(counter);
                    Size size = MediaQuery.of(context).size;
                    ProductModel productModel =
                        add_notes_state.cart_list[index];
                    return Padding(
                      padding: const EdgeInsets.all(appPadding / 4),
                      child: Container(
                        height: 120,
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  fit: BoxFit.cover,
                                  height: size.height * 0.20,
                                  width: size.width * 0.35,
                                  productModel.imageUrl,
                                )),
                            const SizedBox(
                              width: 2,
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                      productModel.name,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 0.1,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            add_notes_state.cart_list
                                                .remove(productModel);
                                          });
                                          widget.total-=productModel.price;
                                        },
                                        child: const Text("REMOVE"))
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  '\$  ${(productModel.price) * widget.counters[index]} EG',
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.orange,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 150),
                            Column(
                              children: const [
                                SizedBox(height: 100),
                              ],
                            ),
                            SizedBox(width: 2),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 2.0, top: 70),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black12)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () => setState(() {
                                              widget.counters[index] == 1
                                                  ? add_notes_state.cart_list
                                                      .remove(productModel)
                                                  : widget.counters[index]--;
                                              widget.total -=
                                                  productModel.price;
                                            }),
                                        child: Icon(
                                          Icons.remove,
                                          size: 20,
                                        )),
                                    Text(
                                      '${widget.counters[index]}',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            print('set');
                                            widget.counters[index]++;
                                            widget.total += productModel.price;
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 20,
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,

                /*border: Border(
                      top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                    )*/
              ),
              height: 140,
              // widget.paymentFor == PaymentFor.ManualPayment ? 80 : 140,
              //color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //  widget.paymentFor == PaymentFor.Order
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: buildApplyCouponRow(context),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.transparent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                child: const Text(
                  "PLACE MY ORDER",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  setState(() {
                    add_notes_state.cart_list.clear();
                    widget.total = 0;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Column buildApplyCouponRow(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 42,
              width: (MediaQuery.of(context).size.width - 32) * (2 / 3),
              child: TextFormField(
                controller: _couponController,
                readOnly: _coupon_applied,
                autofocus: false,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 16.0)),
              ),
            ),
            !_coupon_applied
                ? Container(
                    width: (MediaQuery.of(context).size.width - 32) * (1 / 3),
                    height: 42,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          //height: 50,
                          backgroundColor: Colors.redAccent,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          )),
                        ),
                        child: const Text(
                          // AppLocalizations.of(context).checkout_screen_apply_coupon,
                          ("APLLY COUPON"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.total -=800;
                            _couponController.clear();
                          });
                        },
                      ),
                    ),
                  )
                : Container(
                    width: (MediaQuery.of(context).size.width - 32) * (1 / 3),
                    height: 42,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          //height: 50,
                          backgroundColor: Colors.redAccent,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          )),
                        ),
                        child: const Text(
                          //AppLocalizations.of(context).checkout_screen_remove,
                          // Text("a7aaaa")
                          ("REMOVE"),
                          style: TextStyle(
                              color: Colors.black12,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Text(
              "TOTAL:",
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            const SizedBox(width: 30),
            Text(
              '\$  ${widget.total} EG',
              style: const TextStyle(color: Colors.black, fontSize: 30),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Transaction completed sucssefully'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Payment by cash on delviery "),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
