import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groccer_app/Drawer/Stores/products.dart';

class ProductPage extends StatefulWidget {
  final String docId;
  const ProductPage({super.key, required this.docId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection("Stores")
        .doc(widget.docId)
        .collection("Products")
        .snapshots();
    return MaterialApp(
        home: Scaffold(
      // backgroundColor: Color.fromRGBO(127, 159, 185, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(127, 159, 185, 1),
        title: Text("Your Products",
            //  widget.title,
            style: TextStyle(color: Colors.white)),
        actions: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 20),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              // return ListTile(
              //   title: Text(data.toString()),
              //   // subtitle: Text(data['company']),
              // );
              return Products(
                ontap: () {
                  print("dsfd");
                },
                isCreator: true,
                imgUrl: data['img-url'],
                price: data['price'],
                title: data['title'],
                quantity: data['quantity'],
                prodetail: data['des'],
                // carted: false,
                // docId: doc.id, carted: doc['carted'],
              );
            }).toList(),
          );
        },
      ),
    ));
  }
}
