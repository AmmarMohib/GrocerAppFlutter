import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:groccer_app/Drawer/Stores/details.dart';
import 'package:groccer_app/commons/categorieslist.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Stores').snapshots();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          title: Text("Stores",
              //  widget.title,
              style: TextStyle(color: Colors.white)),
          actions: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 20),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    List categories = data['categories'];
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Container(
                          width: MediaQuery.of(context).size.width * 0.97,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(193, 197, 201, 1),
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details(storeName: data['name'],sellingtxt: data['subname'],des: data['des'],tags: data['categories'],logo: data['logoURL'],location: data['location'], ctrEmail: data['CreatorEmail'],ctrName: data['CreatorName'],ctrPhoto: data['CreatorPhoto'])));
                            },
                            child: Card(
                              margin: EdgeInsets.all(0),
                                color: Color.fromRGBO(237, 242, 246, 1),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      // ClipRRect(
                                      //     borderRadius: BorderRadius.circular(
                                      //         35), // Image border
                                      //     child: SizedBox.fromSize(
                                      //       size: Size.fromRadius(
                                      //           50), // Image radius
                                      //       // backgroundColor: Color.fromRGBO(237, 230, 227, 1),
                                      //       child:
                                      //           Image.network(data['logoURL']),
                                      //     )),
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Color.fromRGBO(127, 159, 185, 1.0),
                                        backgroundImage: NetworkImage(data['logoURL']),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data['name'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15)),
                                            const SizedBox(height: 7.0),
                                            Text(
                                                "We are selling " +
                                                    data['subname'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12)),
                                            const SizedBox(height: 7.0),
                                            SizedBox(
                                              height: 20,
                                              //  child: GridView.builder(itemBuilder: (context, index) => Text("#" + categories[index], style: TextStyle(color: Colors.blue),),itemCount: categories.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              //    crossAxisCount: 3, // number of columns in the grid
                                              //    childAspectRatio: 1.0, // width-to-height ratio of each item
                                              //  ),),
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: categories.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1.0,
                                                ),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  if (index > 3 != true) {
                                                    return Text(
                                                      "#" + categories[index],
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    );
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        )),
                      ],
                    );
                  })
                  .toList()
                  .cast(),
            );
          },
        ),
      ),
    );
  }
}
