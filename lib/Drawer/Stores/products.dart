import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groccer_app/Drawer/Stores/prodetails.dart';
import 'package:groccer_app/Drawer/Stores/products.dart';
// import 'package:groccer_app/Drawer/Stores/prodetails.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';

class Products extends StatefulWidget {
  final String imgUrl;
  final String title;
  final String quantity;
  final String prodetail;
  final String price;
  final Function ontap;
  final String docId;
  final bool carted;
  final bool isCreator;
  const Products(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.quantity,
      required this.price,
      required this.prodetail,
      required this.ontap,
      this.carted = false,
      this.isCreator = false,
      this.docId = ""});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // bool isCarted = false;
  getdata() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection('Admin')
          .doc('products')
          .collection('IsCarted')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("UserData")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc["CartedDoc"] == widget.docId) {
          } else {}
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // getdata();
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: widget.imgUrl != "" &&
              widget.price != "" &&
              widget.title != "" &&
              widget.prodetail != "" &&
              widget.quantity != ""
          ? Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetails(
                                detail: widget.prodetail,
                                imageUrl: widget.imgUrl,
                                price: widget.price,
                                title: widget.title,
                                quantity: widget.quantity,
                              )));
                  setState(() {});
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          // key: widgetKey,
                          width: 60,
                          height: 60,
                          color: Colors.transparent,
                          child: Image.network(
                            widget.imgUrl,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(widget.title,
                                    // "Onion - Pyaz",
                                    // style: const TextStyle(
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15)),
                              ),
                              const SizedBox(height: 7.0),
                              Text(
                                widget.quantity,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(146, 146, 146, 1.0)),
                              ),
                              const SizedBox(height: 50.0),
                              Text("Rs: " + widget.price,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                      color: Color.fromRGBO(230, 0, 57, 1.0))),
                            ],
                          ),
                        ),
                        widget.isCreator == false
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    // category['icon'],
                                    color: Color.fromRGBO(193, 193, 193, 1.0),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  // isCarted == false
                                  widget.carted == false
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            DocumentReference<
                                                    Map<String, dynamic>>
                                                collref =
                                                await FirebaseFirestore
                                                    .instance
                                                    .collection('Admin')
                                                    .doc('products')
                                                    .collection('IsCarted')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .collection("UserData")
                                                    .doc(widget.docId);

                                            // Add the document to the collection and wait for the operation to complete
                                            await collref.set(
                                                {"CartedDoc": widget.docId});
                                            FirebaseFirestore.instance
                                                .collection('Admin')
                                                .doc('products')
                                                .collection('data')
                                                .doc(widget.docId)
                                                .update({"carted": true});
                                            // Update the state and print the value of `isCarted`
                                            // setState(() {
                                            //   // isCarted = true;
                                            //   // print("this " + isCarted.toString());
                                            // });
                                          },
                                          child: const Text(
                                            "Add to Cart",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      127, 159, 185, 1),
                                              elevation: 0),
                                        )
                                      : ElevatedButton(
                                          onPressed: () async {
                                            if (FirebaseAuth
                                                    .instance.currentUser !=
                                                null) {
                                              DocumentReference<
                                                      Map<String, dynamic>>
                                                  docRef =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Admin')
                                                      .doc('products')
                                                      .collection('IsCarted')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .collection("UserData")
                                                      .doc(widget.docId);
                                              docRef.delete();
                                              FirebaseFirestore.instance
                                                  .collection('Admin')
                                                  .doc('products')
                                                  .collection('data')
                                                  .doc(widget.docId)
                                                  .update({"carted": false});
                                            }
                                            setState(() {});
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateColor
                                                      .resolveWith((states) =>
                                                          Colors.white),
                                              elevation: MaterialStateProperty
                                                  .resolveWith((states) => 0),
                                              side: MaterialStateProperty
                                                  .resolveWith<BorderSide>(
                                                (Set<MaterialState> states) {
                                                  return BorderSide(
                                                      color: Color.fromRGBO(
                                                          25, 174, 68, 1.0),
                                                      width:
                                                          3); // set border color here
                                                },
                                              )),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        )
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              )
            ])
          : Container(),
    );
  }
}
