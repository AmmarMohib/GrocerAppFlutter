import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groccer_app/Drawer/Stores/prodetails.dart';
import 'package:groccer_app/Drawer/Stores/stores.dart';
import 'package:groccer_app/Drawer/Stores/details.dart';
import 'package:groccer_app/Drawer/Stores/products.dart';
import 'package:groccer_app/commons/categorieslist.dart';
import 'package:groccer_app/commons/drawer.dart';

class Home extends StatefulWidget {
  // const Home({super.key});
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
  //     .collection('Admin')
  //     .doc('products')
  //     .collection('data')
  //     .snapshots();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Stores').snapshots();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
              color: const Color.fromRGBO(127, 159, 185, 1)),
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
          elevation: 1,
          title: SizedBox(
            height: 40,
            width: 360,
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  hintText: 'What are you looking for?',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Icon(Icons.shopping_cart_outlined),
            SizedBox(
              width: 10,
            )
          ],
        ),
        drawer: Drawer(
            // width: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            // backgroundColor: Colors.red,
            child: AppDrawer()),
        // ));
        // body: Column(
        //   children: [
        //     Row(
        //       children: [
        //         const SizedBox(
        //           width: 15,
        //           height: 50,
        //         ),
        //         const Icon(Icons.location_on_outlined, size: 25),
        //         const SizedBox(
        //           width: 15,
        //         ),
        //         Container(
        //             margin: const EdgeInsets.only(top: 5),
        //             child: const Text(
        //               "Deliver to 6, Block N Gulbrg |||, Lahore",
        //               style: TextStyle(
        //                   color: Color.fromRGBO(5, 51, 56, 1),
        //                   fontWeight: FontWeight.w500,
        //                   fontSize: 16),
        //             )),
        //         // alignment: Alignment.bottomRight,
        //         const Spacer(),
        //         // alignment: Alignment.center ,
        //         IconButton(
        //           onPressed: () {},
        //           icon: const Icon(
        //             Icons.arrow_drop_down_rounded,
        //             color: Colors.black,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Expanded(
        //       child: StreamBuilder<QuerySnapshot>(
        //           stream: _usersStream,
        //           builder: (BuildContext context,
        //               AsyncSnapshot<QuerySnapshot> snapshot) {
        //             if (snapshot.hasError) {
        //               return Text('Something went wrong');
        //             }

        //             if (snapshot.connectionState ==
        //                 ConnectionState.waiting) {
        //               return Text("Loading");
        //             }

        //             final docs = snapshot.data!.docs;
        //             final products = docs
        //                 .map((doc) => Products(
        //                       ontap: () {
        //                         print("dsfd");
        //                       },
        //                       imgUrl: doc['img-url'],
        //                       price: doc['price'],
        //                       title: doc['title'],
        //                       quantity: doc['quantity'],
        //                       prodetail: doc['des'],
        //                       // carted: false,
        //                       docId: doc.id, carted: doc['carted'],
        //                     ))
        //                 .toList();

        //             return ListView(children: products);
        //           }),
        //     ),
        //   ],
        // )
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0),
            //   child: Text(
            //     "Stores:",
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Stores')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return Text('Loading...');
                    }

                    final List<QueryDocumentSnapshot> documents =
                        snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final subcollectionRef =
                            documents[index].reference.collection("Products");
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: subcollectionRef.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData) {
                                return Text('Loading...');
                              }

                              final List<QueryDocumentSnapshot> doc =
                                  snapshot.data!.docs;
                              // final String myField = subcollectionDocuments[3]['des'];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ListTile(
                                    // children: [
                                    leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            documents[index]['logoURL'])),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(documents[index]['name']),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.arrow_forward),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Details(
                                                    storeName: documents[index]
                                                        ['name'],
                                                    sellingtxt: documents[index]
                                                        ['subname'],
                                                    tags: documents[index]
                                                        ['categories'],
                                                    des: documents[index]
                                                        ['des'],
                                                    logo: documents[index]
                                                        ['logoURL'],
                                                    location: documents[index]
                                                        ['location'],
                                                    ctrName: documents[index]
                                                        ['CreatorName'],
                                                    ctrEmail: documents[index]
                                                        ['CreatorEmail'],
                                                    ctrPhoto: documents[index]
                                                        ['CreatorPhoto'])));
                                      },
                                    ),
                                    // ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      child: ListView.builder(
                                          physics: ScrollPhysics(),
                                          itemCount: doc.length,
                                          itemBuilder: (context, i) =>
                                              // Products(
                                              //       ontap: () {
                                              //         print("dsfd");
                                              //       },
                                              //       imgUrl: doc[i]['img-url'],
                                              //       price: doc[i]['price'],
                                              //       title: doc[i]['title'],
                                              //       quantity: doc[i]['quantity'],
                                              //       prodetail: doc[i]['des'],
                                              //       // carted: false,
                                              //       // docId: doc[i].id, carted: doc[i]['carted'],
                                              //     )
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Center(
                                                      child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.97,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Color.fromRGBO(
                                                            193, 197, 201, 1),
                                                        width: 2.5,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    )
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder: (context) => ProductDetails(
                                                        //             title: doc[i]
                                                        //                 [
                                                        //                 'title'],
                                                        //             imageUrl: doc[
                                                        //                     i][
                                                        //                 'img-url'],
                                                        //             quantity: doc[
                                                        //                     i][
                                                        //                 'quantity'],
                                                        //             detail: doc[i]
                                                        //                 ['des'],
                                                        //             price: doc[i]
                                                        //                 ['price'])));
                                                      },
                                                      child: Card(
                                                          margin:
                                                              EdgeInsets.all(0),
                                                          color: Color.fromRGBO(
                                                              237, 242, 246, 1),
                                                          elevation: 0,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Row(
                                                              children: [
                                                              
                                                                const SizedBox(
                                                                    width:
                                                                        16.0),
                                                                // Image.network(
                                                                //   doc[i][
                                                                //       'img-url'],
                                                                //   width: 100,
                                                                // ),
                                                                CircleAvatar(
                                                                                          radius: 30,
                                                                                          backgroundColor: const Color.fromRGBO(127, 159, 185, 1.0),
                                                                                          backgroundImage: NetworkImage(doc[i]['img-url']),
                                                                                        ),
                                                                                        SizedBox(width: 10,),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          doc[i]
                                                                              [
                                                                              'title'],
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 15)),
                                                                      const SizedBox(
                                                                          height:
                                                                              7.0),
                                                                      Text(
                                                                          "RS: " +
                                                                              doc[i][
                                                                                  'price'],
                                                                          maxLines:
                                                                              2,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: const TextStyle(
                                                                              color: Colors.green,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 12)),
                                                                      const SizedBox(
                                                                          height:
                                                                              7.0),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // SizedBox(width: 20,),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return SizedBox(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.9,
                                                                            child:
                                                                                Wrap(
                                                                              children: [
                                                                               
                                                                                SizedBox(
                                                                                  height: MediaQuery.of(context).size.height,
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      const SizedBox(
                                                                                        height: 20,
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 10.0),
                                                                                        child: IconButton(
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            icon: Icon(Icons.close)),
                                                                                      ),
                                                                                      Center(
                                                                                        child: CircleAvatar(
                                                                                          radius: 40,
                                                                                          backgroundColor: const Color.fromRGBO(127, 159, 185, 1.0),
                                                                                          backgroundImage: NetworkImage(doc[i]['img-url']),
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 20,
                                                                                      ),
                                                                                      const Divider(),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      const Padding(
                                                                                        padding: EdgeInsets.only(left: 15.0),
                                                                                        child: Text(
                                                                                          "Price",
                                                                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Padding(
                                                                                          padding: const EdgeInsets.only(left: 20),
                                                                                          child: Container(
                                                                                            child: Text("RS: " + doc[i]['price']),
                                                                                            width: MediaQuery.of(context).size.width * 0.9,
                                                                                          )),
                                                                                      const SizedBox(
                                                                                        height: 20,
                                                                                      ),
                                                                                      const Divider(),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      const Padding(
                                                                                        padding: EdgeInsets.only(left: 15.0),
                                                                                        child: Text(
                                                                                          "Product Description",
                                                                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Padding(
                                                                                          padding: const EdgeInsets.only(left: 20),
                                                                                          child: Container(
                                                                                            child: Text(doc[i]['des']),
                                                                                            width: MediaQuery.of(context).size.width * 0.9,
                                                                                          )),
                                                                                      const SizedBox(
                                                                                        height: 20,
                                                                                      ),
                                                                                      // const Divider(),
                                                                                      // const SizedBox(
                                                                                      //   height: 10,
                                                                                      // ),
                                                                                      // const Padding(
                                                                                      //   padding: EdgeInsets.only(left: 15.0),
                                                                                      //   child: Text(
                                                                                      //     "From where they are?",
                                                                                      //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                      //   ),
                                                                                      // ),
                                                                                      // const SizedBox(
                                                                                      //   height: 10,
                                                                                      // ),
                                                                                      // Padding(
                                                                                      //     padding: const EdgeInsets.only(left: 20),
                                                                                      //     child: Container(
                                                                                      //       child: Text(widget.location),
                                                                                      //       width: MediaQuery.of(context).size.width * 0.9,
                                                                                      //     )),
                                                                                      // const SizedBox(
                                                                                      //   height: 20,
                                                                                      // ),
                                                                                      // const Divider(
                                                                                      //   height: 20,
                                                                                      // ),
                                                                                      // const Padding(
                                                                                      //   padding: EdgeInsets.only(left: 15.0),
                                                                                      //   child: Text(
                                                                                      //     "Creator Info",
                                                                                      //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                      //   ),
                                                                                      // ),
                                                                                      // const SizedBox(
                                                                                      //   height: 10,
                                                                                      // ),
                                                                                      // // Padding(
                                                                                      // //     padding: const EdgeInsets.only(left: 20),
                                                                                      // //     child: Container(
                                                                                      // //       child: Text(widget.location),
                                                                                      // //       width: MediaQuery.of(context).size.width * 0.9,
                                                                                      // //     )),
                                                                                      // ListTile(
                                                                                      //   leading: Image.network(widget.ctrPhoto),
                                                                                      //   title: Text(widget.ctrName),
                                                                                      //   subtitle: Text(widget.ctrEmail),
                                                                                      // ),
                                                                                      // const SizedBox(
                                                                                      //   height: 20,
                                                                                      // ),
                                                                                      // const Divider(
                                                                                      //   height: 20,
                                                                                      // ),
                                                                                      // SizedBox(
                                                                                      //     height: 20,
                                                                                      //     //  child: GridView.builder(itemBuilder: (context, index) => Text("#" + categories[index], style: TextStyle(color: Colors.blue),),itemCount: categories.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                      //     //    crossAxisCount: 3, // number of columns in the grid
                                                                                      //     //    childAspectRatio: 1.0, // width-to-height ratio of each item
                                                                                      //     //  ),),
                                                                                      //     child: Center(
                                                                                      //       child: Wrap(
                                                                                      //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      //         spacing: 3.0,
                                                                                      //         children: widget.tags
                                                                                      //             .map((e) => Text(
                                                                                      //                   "#" + e,
                                                                                      //                   style: const TextStyle(color: Colors.blue),
                                                                                      //                 ))
                                                                                      //             .toList(),
                                                                                      //       ),
                                                                                      //     )),
                                                                                      // const SizedBox(
                                                                                      //   height: 20,
                                                                                      // ),
                                                                                      const Divider(),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      size: 20,
                                                                    ))
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                  )),
                                                ],
                                              ))),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
