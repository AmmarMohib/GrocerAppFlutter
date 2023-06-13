import 'package:another_stepper/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<String> docIds = [];
    int _currentStep = 0;


  @override
  void initState() {
    super.initState();
    getDocs();
  }

  getDocs() {
    if (FirebaseAuth.instance.currentUser != null)
    FirebaseFirestore.instance
        .collection('Admin')
        .doc('products')
        .collection('IsCarted')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserData")
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<String> ids = [];
      querySnapshot.docs.forEach((doc) {
        print(doc['CartedDoc']);
        ids.add(doc['CartedDoc']);
      });
      setState(() {
        docIds = ids;
      });
    });
  }
  void _goToNextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _goToPreviousStep() {
    setState(() {
      _currentStep--;
    });
  }
List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Order Placed",
          textStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        subtitle: StepperText("Your order has been placed"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
        )),
    StepperData(
        title: StepperText("Preparing"),
        subtitle: StepperText("Your order is being prepared"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_two, color: Colors.white),
        )),
    StepperData(
        title: StepperText("On the way"),
        subtitle: StepperText(
            "Our delivery executive is on the way to deliver your item"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_3, color: Colors.white),
        )),
    StepperData(
        title: StepperText("Delivered",
            textStyle: const TextStyle(color: Colors.grey)),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
        )),
  ];
 List<Step> stepList() => [
        // const Step(title: Text('Account'), content: Center(child: Text('Account'),),isActive: true,state: ),
        //  const Step(title: Text('Address'), content: Center(child: Text('Address'),),isActive: false),
        //   const Step(title: Text('Confirm'), content: Center(child: Text('Confirm'),),isActive: true)
         Step(
      title: Text('Account'),
      content: Center(child: Text('Account')),
      isActive: true,
    ),
    Step(
      title: Text('Address'),
      content: Center(child: Text('Address')),
      isActive: true,
    ),
    Step(
      title: Text('Confirm'),
      content: Center(child: Text('Confirm')),
    ),
   ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(241, 147, 72, 1.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.white,
                title: const Text("My Cart",
                    //  widget.title,
                    style: TextStyle(color: Colors.black)),
                actions: [
                  const Icon(Icons.share, color: Color.fromRGBO(241, 147, 72, 1.0)),
                  const SizedBox(width: 20),
                  const Icon(Icons.search, color: Color.fromRGBO(241, 147, 72, 1.0)),
                  const SizedBox(width: 20),
                  const Icon(Icons.shopping_cart_outlined,
                      color: Color.fromRGBO(241, 147, 72, 1.0)),
                  const SizedBox(width: 10),
                ],
              ),
        body: docIds.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
              children: [
              //   AnotherStepper(
              //   stepperList: stepperData,
              //   stepperDirection: Axis.horizontal,
              //   iconWidth: 40,
              //   iconHeight: 40,
              //   activeBarColor: Colors.green,
              //   inActiveBarColor: Colors.grey,
              //   inverted: true,
              //   verticalGap: 30,
              //   activeIndex: 2,
              //   barThickness: 8,
              // ),
//               AnotherStepper(
//   stepperList: stepperData,
//   stepperDirection: Axis.vertical,
//   iconWidth: 40, // Height that will be applied to all the stepper icons
//   iconHeight: 40, // Width that will be applied to all the stepper icons
// ),
Stepper(
        currentStep: _currentStep,
      // onStepContinue: _goToNextStep,
      // onStepCancel: _goToPreviousStep,
        onStepContinue: _currentStep < stepList().length - 1 ? _goToNextStep : null,
      onStepCancel: _currentStep > 0 ? _goToPreviousStep : null,
        steps: stepList(),
      ),
                Expanded(
                  child: ListView.builder(
                      itemCount: docIds.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('Admin')
                              .doc('products')
                              .collection('data')
                              .doc(docIds[index])
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }
                
                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return const Text("Document does not exist");
                            }
                
                            if (snapshot.connectionState == ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              // return ListTile(
                              //   leading: Image.network(
                              //     data['img-url'],
                              //     width: 60,
                              //     height: 60,
                              //   ),
                              //   title: Text(data['title']),
                              //   subtitle: Text('Price: \$${data['price']}'),
                              // );
                              return  Column(children: [
                              GestureDetector(
                                onTap: () {
                                  // print("dd");
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => productDetails(
                                  //               detail: widget.prodetail,
                                  //               imageUrl: widget.imgUrl,
                                  //               price: widget.price,
                                  //               title: widget.title,
                                  //               quantity: widget.quantity,
                                  //             )));
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
                                            data['img-url'],
                                            // width: 100,
                                            // height: 100,
                                          ),
                                        ), // widget to be displayed inside the avatar
                                        // Image.asset(
                                        //   category['imagePath'],
                                        //   width: 150,
                                        // ),
                                        const SizedBox(width: 16.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    MediaQuery.of(context).size.width,
                                                child: Text(data['title'],
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
                                                data['quantity'],
                                                style: const TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(
                                                        146, 146, 146, 1.0)),
                                              ),
                                              const SizedBox(height: 50.0),
                                              Text("Rs: " + data['price'],
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 17,
                                                      color: Color.fromRGBO(
                                                          230, 0, 57, 1.0))),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              // category['icon'],
                                              color:
                                                  Color.fromRGBO(193, 193, 193, 1.0),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                    //                   CollectionReference collref =
                                                    //     await FirebaseFirestore.instance
                                                    //         .collection('Admin')
                                                    //         .doc('products')
                                                    //         .collection('IsCarted')
                                                    //         .doc(FirebaseAuth.instance.currentUser!.uid)
                                                    //         .collection("UserData");
                                                    // await collref.add({
                                                    //   "CartedDoc": doc.id,
                                                    // });
                                                    if (FirebaseAuth
                                                            .instance.currentUser !=
                                                        null) {
                                                      CollectionReference collref =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection('Admin')
                                                              .doc('products')
                                                              .collection('IsCarted')
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .collection("UserData");
                                                      collref.get().then(
                                                          (QuerySnapshot
                                                              querySnapshot) {
                                                        querySnapshot.docs
                                                            .forEach((doc) async {
                                                          // if (doc["CartedDoc"] == widget.docId) {
                                                          //   setState(() {
                                                          //     isCarted = true;
                                                          //   });
                                                          // } else {
                                                          //   isCarted = false;
                                                          // }
                                                          await doc.reference
                                                              .delete();
                                                          // print(doc["CartedDoc"] == widget.docId);
                                                        });
                                                      });
                                                    }
                                                    // setState(() {
                                                      
                                                    // });
                                              //       setState(() {
                                              //   isCarted = false;
                                              //   print("this " + isCarted.toString());
                                              // });
                                                    // getdata();
                                                  },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateColor.resolveWith(
                                                        (states) => Colors.white),
                                                elevation:
                                                    MaterialStateProperty.resolveWith(
                                                        (states) => 0),
                                                side: MaterialStateProperty
                                                    .resolveWith<BorderSide>(
                                                  (Set<MaterialState> states) {
                                                    // if (states.contains(MaterialState.disabled)) {
                                                    //   // return null;
                                                    // }
                                                    return const BorderSide(
                                                        color: Color.fromRGBO(
                                                            25, 174, 68, 1.0),
                                                        width:
                                                            3); // set border color here
                                                  },
                                                )),
                                            // onPressed: () async {
                                            //   widget.ontap();
                                            //   print("this" + isCarted.toString());
                                            // },
                                            // child: const Text(
                                            //   "Added to Cart",
                                            //   style: TextStyle(
                                            //       color: Color.fromRGBO(
                                            //           191, 232, 203, 1.0)),
                                            // ),
                                            child: Row(
                                              children: [
                                                 const Icon(
                                                    Icons.delete,
                                                    color: Colors.black,
                                                  ),
                                              ],
                                            ),
                
                                            //   style: ElevatedButton.styleFrom(
                                            //       backgroundColor: Colors.white,
                
                                            // )
                                          )
                                          ],
                
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              
                              ]);
                            }
                            
                
                            return const ListTile(
                              leading: CircularProgressIndicator(),
                              title: Text('Loading...'),
                            );
                          },
                        );
                      },
                    ),
                ),
              ],
            ),
      ),
    );
  }
}
// ElevatedButton(
//                                         onPressed: () async {
//                                               //                   CollectionReference collref =
//                                               //     await FirebaseFirestore.instance
//                                               //         .collection('Admin')
//                                               //         .doc('products')
//                                               //         .collection('IsCarted')
//                                               //         .doc(FirebaseAuth.instance.currentUser!.uid)
//                                               //         .collection("UserData");
//                                               // await collref.add({
//                                               //   "CartedDoc": doc.id,
//                                               // });
//                                               if (FirebaseAuth
//                                                       .instance.currentUser !=
//                                                   null) {
//                                                 CollectionReference collref =
//                                                     await FirebaseFirestore
//                                                         .instance
//                                                         .collection('Admin')
//                                                         .doc('products')
//                                                         .collection('IsCarted')
//                                                         .doc(FirebaseAuth
//                                                             .instance
//                                                             .currentUser!
//                                                             .uid)
//                                                         .collection("UserData");
//                                                 collref.get().then(
//                                                     (QuerySnapshot
//                                                         querySnapshot) {
//                                                   querySnapshot.docs
//                                                       .forEach((doc) async {
//                                                     // if (doc["CartedDoc"] == widget.docId) {
//                                                     //   setState(() {
//                                                     //     isCarted = true;
//                                                     //   });
//                                                     // } else {
//                                                     //   isCarted = false;
//                                                     // }
//                                                     await doc.reference
//                                                         .delete();
//                                                     // print(doc["CartedDoc"] == widget.docId);
//                                                   });
//                                                 });
//                                               }
//                                               setState(() {
//                                           isCarted = false;
//                                           print("this " + isCarted.toString());
//                                         });
//                                               // getdata();
//                                             },
//                                       style: ButtonStyle(
//                                           backgroundColor:
//                                               MaterialStateColor.resolveWith(
//                                                   (states) => Colors.white),
//                                           elevation:
//                                               MaterialStateProperty.resolveWith(
//                                                   (states) => 0),
//                                           side: MaterialStateProperty
//                                               .resolveWith<BorderSide>(
//                                             (Set<MaterialState> states) {
//                                               // if (states.contains(MaterialState.disabled)) {
//                                               //   // return null;
//                                               // }
//                                               return BorderSide(
//                                                   color: Color.fromRGBO(
//                                                       25, 174, 68, 1.0),
//                                                   width:
//                                                       3); // set border color here
//                                             },
//                                           )),
//                                       // onPressed: () async {
//                                       //   widget.ontap();
//                                       //   print("this" + isCarted.toString());
//                                       // },
//                                       // child: const Text(
//                                       //   "Added to Cart",
//                                       //   style: TextStyle(
//                                       //       color: Color.fromRGBO(
//                                       //           191, 232, 203, 1.0)),
//                                       // ),
//                                       child: Row(
//                                         children: [
//                                            Icon(
//                                               Icons.delete,
//                                               color: Colors.black,
//                                             ),
//                                         ],
//                                       ),

//                                       //   style: ElevatedButton.styleFrom(
//                                       //       backgroundColor: Colors.white,

//                                       // )
//                                     )