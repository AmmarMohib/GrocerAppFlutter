// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groccer_app/Drawer/myStores/addproduct.dart';
import 'package:groccer_app/Drawer/Stores/details.dart';
import 'package:groccer_app/Home/home.dart';
import 'package:groccer_app/commons/categorieslist.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
// import 'package:dropdown_formfield/dropdown_formfield.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  String? selectedValue;
  bool isExpandedcat = false;
  bool isExpandedsubcat = false;
  bool isExpandedproduct = false;
  File? _catImageFile;
  File? _subCatImageFile;
  File? _ProImageFile;
  String? CatImgUrl;
  String? SubCatImgUrl;
  String? ProImgUrl;
  final catTitles = [];
  final subcatTitles = [];
  final ProductcatTitles = [];
  final ProductsubcatTitles = [];
  final TextEditingController _CattitleController = TextEditingController();
  final TextEditingController _CatSubtitleController = TextEditingController();
  final TextEditingController _SubCattitleController = TextEditingController();
  final TextEditingController _desCont = TextEditingController();
  final DropdownEditingController<String> _CatdropdownController =
      DropdownEditingController();
  final DropdownEditingController<String> _ProCatdropdownController =
      DropdownEditingController();
  final DropdownEditingController<String> _ProSubCatdropdownController =
      DropdownEditingController();
  late String _selectedItem;
  TextEditingController _ProTitleController = TextEditingController();
  TextEditingController _ProPriceController = TextEditingController();
  TextEditingController _ProQuantityController = TextEditingController();
  Future<void> _pickImageCat() async {
    final pickedFileCat =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _catImageFile = File(pickedFileCat!.path);
    });
    if (_catImageFile != null) {
      Random rnd = Random();
      final String imgPath = 'imgs/${rnd.nextInt(4000000)}';

      final reference = FirebaseStorage.instance.ref().child(imgPath);

// File? _catImageFile;
      final TaskSnapshot snapshot = await reference.putFile(_catImageFile!);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      setState(() {
        CatImgUrl = downloadUrl;
      });
      // print(_priceController);
      // print(_quantityController);
      // print(_titleController);
    }
  }

  sendDataCat() {
    // IconData myIconData = Icons.keyboard_arrow_down_rounded;
    // String iconString = String.fromCharCode(myIconData.codePoint);
    FirebaseFirestore databaseinstance = FirebaseFirestore.instance;
    databaseinstance
        .collection('Admin')
        .doc('Categories')
        .collection('data')
        .add({
      "catTitle": _CattitleController.text,
      // "sub-category": widget.subcategory,
      "imgUrl": CatImgUrl,
      "catSubtitle": _CatSubtitleController.text,
      "isExpanded": false,
      "icon": 'keyboard_arrow_down_rounded',
    }).whenComplete((() {
      Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromRGBO(241, 147, 72, 1.0),
          textColor: Colors.white,
          fontSize: 16.0);
      //             Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPanel()));  // pop current page
      //           // Navigator.pushNamed(context, "Setting"); //
      setState(() {
        _CattitleController.text = "";
        CatImgUrl = "";
        _CatSubtitleController.text = "";
      });
    }));
  }

  Future<void> _pickImageSubCat() async {
    final pickedFileSubCat =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _subCatImageFile = File(pickedFileSubCat!.path);
    });
    if (_subCatImageFile != null) {
      Random rnd = Random();
      final String imgPath = 'imgs/${rnd.nextInt(4000000)}';

      final reference = FirebaseStorage.instance.ref().child(imgPath);

      final TaskSnapshot snapshot = await reference.putFile(_subCatImageFile!);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      setState(() {
        SubCatImgUrl = downloadUrl;
      });
    }
  }

  sendDataSubCat() {
    FirebaseFirestore databaseinstance = FirebaseFirestore.instance;
    databaseinstance
        .collection('Admin')
        .doc('SubCategories')
        .collection('data')
        .add({
      // "category": _ProCatdropdownController.value,
      // "sub-category": _ProSubCatdropdownController.value,
      // "img-url": ProImgUrl,
      // "title": _ProTitleController.text,
      // "price": _ProPriceController.text,
      // "quantity": _ProQuantityController
      "Cat": _CatdropdownController.value,
      "subCat": _SubCattitleController.text,
      "imgUrl": SubCatImgUrl,
    }).whenComplete(() => Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(241, 147, 72, 1.0),
            textColor: Colors.white,
            fontSize: 16.0));
  }

  Future<void> _pickImagePro() async {
    final pickedFilePro =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _ProImageFile = File(pickedFilePro!.path);
    });
    if (_ProImageFile != null) {
      Random rnd = Random();
      final String imgPath = 'imgs/${rnd.nextInt(4000000)}';

      final reference = FirebaseStorage.instance.ref().child(imgPath);

      final TaskSnapshot snapshot = await reference.putFile(_ProImageFile!);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      setState(() {
        ProImgUrl = downloadUrl;
      });
    }
  }

  sendDataPro() {
    FirebaseFirestore databaseinstance = FirebaseFirestore.instance;
    databaseinstance
        .collection('Admin')
        .doc('products')
        .collection('data')
        .add({
      // "Cat": _ProCatdropdownController.value,
      // "subCat": _ProSubCatdropdownController.value,
      // "imgUrl": SubCatImgUrl,
      // "price": _priceController.text,
      // "quantity": _quantityController.text
      "category": _ProCatdropdownController.value,
      "sub-category": _ProSubCatdropdownController.value,
      "img-url": ProImgUrl,
      "title": _ProTitleController.text,
      "price": _ProPriceController.text,
      "des": _desCont.text,
      "quantity": _ProQuantityController.text,
      "carted": false
    }).whenComplete(() => Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(241, 147, 72, 1.0),
            textColor: Colors.white,
            fontSize: 16.0));
  }

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
                  onPressed: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  })),
              backgroundColor: Colors.white,
              title: const Text("Admin Panel",
                  style: TextStyle(color: Colors.black)),
              elevation: 0.5,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                    onTap: () {
                      if (isExpandedcat == false) {
                        setState(() {
                          isExpandedcat = true;
                        });
                      } else if (isExpandedcat == true) {
                        setState(() {
                          isExpandedcat = false;
                        });
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text("Add a category",
                                      // style: const TextStyle(
                                      //   fontWeight: FontWeight.bold,
                                      // ),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20)),
                                  const SizedBox(height: 7.0),
                                ],
                              ),
                            ),
                            Icon(
                              isExpandedcat == false
                                  ? Icons.add
                                  : Icons.keyboard_arrow_up_rounded,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )),
                if (isExpandedcat)
                  Container(
                    color: const Color.fromRGBO(247, 242, 239, 1),
                    child: Padding(
                        // padding: EdgeInsets.only(left: 10, bottom: 50, top: 10),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                                      //   child: Text(
                                      //     "Category",
                                      //     style: TextStyle(
                                      //         color: Colors.black,
                                      //         fontWeight: FontWeight.w500,
                                      //         fontSize: 20),
                                      //   ),
                                      // ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Add an Image",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: const Text(
                                            "* Please note that only the image with transparent backgroud is to be uploaded",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          )),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                                      if (_catImageFile != null) ...[
                                        // SizedBox(height: 40),
                                        // CircleAvatar(
                                        //   child: Image.file(
                                        //     _imageFile!,
                                        //     width: MediaQuery.of(context).size.width * 0.5,
                                        //     height: MediaQuery.of(context).size.height * 0.2,
                                        //   ),
                                        // ),
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundColor: const Color.fromRGBO(
                                              237, 230, 227, 1),
                                          child: Image.file(
                                            _catImageFile!,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          ),
                                          // widget to be displayed inside the avatar
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        // SizedBox(height: 40),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromRGBO(
                                                        241, 147, 72, 1.0)),
                                          ),
                                          onPressed: _pickImageCat,
                                          child:
                                              const Text('Pick another image'),
                                        ),
                                      ] else ...[
                                        const Text('No image selected.'),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromRGBO(
                                                        241, 147, 72, 1.0)),
                                          ),
                                          onPressed: _pickImageCat,
                                          child: const Text('Pick an image'),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Category Title",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: TextField(
                                          controller: _CattitleController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            // labelText: 'Title',
                                            // prefix: Text("Rs:"),
                                            hintText:
                                                'Category Title, ex: books',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Category Sub-Title",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: TextField(
                                          controller: _CatSubtitleController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            // labelText: 'Title',
                                            hintText:
                                                'Category Sub-Title, ex: Education, Story, Comedy',
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromRGBO(
                                                        241, 147, 72, 1.0)),
                                          ),
                                          onPressed: () {
                                            sendDataCat();
                                          },
                                          child: const Text('Add Category'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                  ),
                GestureDetector(
                    onTap: () {
                      if (isExpandedsubcat == false) {
                        setState(() {
                          isExpandedsubcat = true;
                        });
                        FirebaseFirestore.instance
                            .collection('Admin')
                            .doc('Categories')
                            .collection('data')
                            .snapshots()
                            .listen((event) {
                          for (var doc in event.docs) {
                            catTitles.add(doc.data()["catTitle"]);
                          }
                          // print(catTitles);
                        });
                      } else if (isExpandedsubcat == true) {
                        setState(() {
                          isExpandedsubcat = false;
                        });
                        catTitles.clear();
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // CircleAvatar(
                            //   radius: 45,
                            //   backgroundColor: Color.fromRGBO(237, 230, 227, 1),
                            //   child: Image.asset(
                            //     category['imagePath'],
                            //     // width: 200,
                            //     // height: 200,
                            //   ), // widget to be displayed inside the avatar
                            // ),
                            // Image.asset(
                            //   category['imagePath'],
                            //   width: 150,
                            // ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Add a sub category",
                                      // style: const TextStyle(
                                      //   fontWeight: FontWeight.bold,
                                      // ),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20)),
                                  const SizedBox(height: 7.0),
                                  // Text(
                                  //   "Ex: Fruit, Vegetables, Milk, etc",
                                  //   style: const TextStyle(
                                  //       overflow: TextOverflow.ellipsis,
                                  //       fontSize: 15,
                                  //       fontWeight: FontWeight.w400,
                                  //       color:
                                  //           Color.fromRGBO(146, 146, 146, 1.0)),
                                  // ),
                                ],
                              ),
                            ),

                            Icon(
                              isExpandedsubcat == false
                                  ? Icons.add
                                  : Icons.keyboard_arrow_up_rounded,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )),
                if (isExpandedsubcat)
                  Container(
                    color: const Color.fromRGBO(247, 242, 239, 1),
                    child: Padding(
                        // padding: EdgeInsets.only(left: 10, bottom: 50, top: 10),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                                      //   child: Text(
                                      //     "Category",
                                      //     style: TextStyle(
                                      //         color: Colors.black,
                                      //         fontWeight: FontWeight.w500,
                                      //         fontSize: 20),
                                      //   ),
                                      // ),
                                      TextDropdownFormField(
                                        options: catTitles != []
                                            ? catTitles.cast()
                                            : [],
                                        dropdownHeight:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            suffixIcon:
                                                Icon(Icons.arrow_drop_down),
                                            labelText: "Category"),
                                        controller: _CatdropdownController,

                                        // dropdownHeight: 120,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Add an Image",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: const Text(
                                            "* Please note that only the image with transparent backgroud is to be uploaded",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          )),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                                      if (_subCatImageFile != null) ...[
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundColor: const Color.fromRGBO(
                                              237, 230, 227, 1),
                                          child: Image.file(
                                            _subCatImageFile!,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          ),
                                          // widget to be displayed inside the avatar
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        // SizedBox(height: 40),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromRGBO(
                                                        241, 147, 72, 1.0)),
                                          ),
                                          onPressed: _pickImageSubCat,
                                          child:
                                              const Text('Pick another image'),
                                        ),
                                      ] else ...[
                                        const Text('No image selected.'),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromRGBO(
                                                        241, 147, 72, 1.0)),
                                          ),
                                          onPressed: _pickImageSubCat,
                                          child: const Text('Pick an image'),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Category Title",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: TextField(
                                          controller: _SubCattitleController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            // labelText: 'Title',
                                            // prefix: Text("Rs:"),
                                            hintText: 'Sub-Category Title',
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromRGBO(
                                                        241, 147, 72, 1.0)),
                                          ),
                                          onPressed: () {
                                            sendDataSubCat();
                                          },
                                          child: const Text('Add Sub Category'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                  ),
                GestureDetector(
                    onTap: () {
                      if (isExpandedproduct == false) {
                        setState(() {
                          isExpandedproduct = true;
                        });
                        FirebaseFirestore.instance
                            .collection('Admin')
                            .doc('Categories')
                            .collection('data')
                            .snapshots()
                            .listen((event) {
                          for (var doc in event.docs) {
                            ProductcatTitles.add(doc.data()["catTitle"]);
                          }
                          // print(catTitles);
                        });
                        // FirebaseFirestore.instance
                        //     .collection('Admin')
                        //     .doc('SubCategories')
                        //     .collection('data')
                        //     .snapshots()
                        //     .listen((event) {
                        //   for (var doc in event.docs) {
                        //     // catTitles.add(doc.data()["catTitle"]);
                        //     // if (_ProCatdropdownController.value ==
                        //     //     doc.data()["Cat"]) {
                        //     //   print(doc.data()["Cat"]);
                        //     // }

                        //   }
                        //   // print(catTitles);
                        // });
                      } else if (isExpandedproduct == true) {
                        setState(() {
                          isExpandedproduct = false;
                        });
                        ProductcatTitles.clear();
                        ProductsubcatTitles.clear();
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // CircleAvatar(
                            //   radius: 45,
                            //   backgroundColor: Color.fromRGBO(237, 230, 227, 1),
                            //   child: Image.asset(
                            //     category['imagePath'],
                            //     // width: 200,
                            //     // height: 200,
                            //   ), // widget to be displayed inside the avatar
                            // ),
                            // Image.asset(
                            //   category['imagePath'],
                            //   width: 150,
                            // ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Add a Product",
                                      // style: const TextStyle(
                                      //   fontWeight: FontWeight.bold,
                                      // ),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20)),
                                  const SizedBox(height: 7.0),
                                  // Text(
                                  //   "Ex: Fruit, Vegetables, Milk, etc",
                                  //   style: const TextStyle(
                                  //       overflow: TextOverflow.ellipsis,
                                  //       fontSize: 15,
                                  //       fontWeight: FontWeight.w400,
                                  //       color:
                                  //           Color.fromRGBO(146, 146, 146, 1.0)),
                                  // ),
                                ],
                              ),
                            ),
                            Icon(
                              isExpandedproduct == false
                                  ? Icons.add
                                  : Icons.keyboard_arrow_up_rounded,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )),
                if (isExpandedproduct)
                  Container(
                    color: const Color.fromRGBO(247, 242, 239, 1),
                    child: Padding(
                        // padding: EdgeInsets.only(left: 10, bottom: 50, top: 10),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                                      //   child: Text(
                                      //     "Category",
                                      //     style: TextStyle(
                                      //         color: Colors.black,
                                      //         fontWeight: FontWeight.w500,
                                      //         fontSize: 20),
                                      //   ),
                                      // ),
                                      TextDropdownFormField(
                                        options: ProductcatTitles != []
                                            ? ProductcatTitles.cast()
                                            : [],
                                        dropdownHeight:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            suffixIcon:
                                                Icon(Icons.arrow_drop_down),
                                            labelText: "Category"),
                                        controller: _ProCatdropdownController,
                                        // onChanged: (String? selectedValue) {
                                        //   // Do something with the selected value
                                        //   print('Selected value: $selectedValue');
                                        // },
                                        onChanged: (selectedValue) {
                                          // Do something with the selected value
                                          print(
                                              'Selected value: $selectedValue');
                                          ProductsubcatTitles.clear();
                                          FirebaseFirestore.instance
                                              .collection('Admin')
                                              .doc('SubCategories')
                                              .collection('data')
                                              .snapshots()
                                              .listen((event) {
                                            for (var doc in event.docs) {
                                              // catTitles.add(doc.data()["catTitle"]);
                                              if (selectedValue ==
                                                  doc.data()["Cat"]) {
                                                // print(doc.data()["subCat"]);
                                                // setState(() {
                                                ProductsubcatTitles.add(
                                                    doc.data()["subCat"]);
                                                // });
                                              }
                                            }
                                            // print(catTitles);
                                          });
                                        } as dynamic,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextDropdownFormField(
                                        options: ProductsubcatTitles != []
                                            ? ProductsubcatTitles.cast()
                                            : [],
                                        dropdownHeight:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            suffixIcon:
                                                Icon(Icons.arrow_drop_down),
                                            labelText: "Sub Category"),
                                        controller:
                                            _ProSubCatdropdownController,

                                        // dropdownHeight: 120,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Add an Image",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: const Text(
                                            "* Please note that only the image with transparent backgroud is to be uploaded",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          )),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                                      if (_ProImageFile != null) ...[
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundColor: const Color.fromRGBO(
                                              237, 230, 227, 1),
                                          child: Image.file(
                                            _ProImageFile!,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          ),
                                          // widget to be displayed inside the avatar
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        // SizedBox(height: 40),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromRGBO(
                                                        241, 147, 72, 1.0)),
                                          ),
                                          onPressed: _pickImagePro,
                                          child:
                                              const Text('Pick another image'),
                                        ),
                                      ] else ...[
                                        const Text('No image selected.'),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromRGBO(
                                                        241, 147, 72, 1.0)),
                                          ),
                                          onPressed: _pickImagePro,
                                          child: const Text('Pick an image'),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      // const Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: 0.0, top: 20.0),
                                      //   child: Text(
                                      //     "Category Title",
                                      //     style: TextStyle(
                                      //         color: Color.fromRGBO(
                                      //             255, 121, 62, 1.0),
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 20),
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(30.0),
                                      //   child: TextField(
                                      //     controller: _SubCattitleController,
                                      //     decoration: const InputDecoration(
                                      //       border: OutlineInputBorder(),
                                      //       // labelText: 'Title',
                                      //       // prefix: Text("Rs:"),
                                      //       hintText: 'Sub-Category Title',
                                      //     ),
                                      //   ),
                                      // ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Product Title",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: TextField(
                                          controller: _ProTitleController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            // labelText: 'Title',
                                            hintText: 'Title, ex: Potato pack',
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Product Price",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: TextField(
                                          controller: _ProPriceController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            // labelText: 'Title',
                                            prefix: Text("Rs:"),
                                            hintText: 'Product Price, ex: 5000',
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Product quantity",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: TextField(
                                          controller: _ProQuantityController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            // labelText: 'Title',
                                            // prefix: Text("Rs:"),
                                            hintText: 'Quantity, ex: 10kg',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      // SizedBox(height: 20,),

                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 20.0),
                                        child: Text(
                                          "Product Description",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 121, 62, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(30.0),
                                        child: TextField(
                                          controller: _desCont,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            // labelText: 'Description',
                                            hintText: 'Description',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Divider(
                                        thickness: 1.25,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color.fromRGBO(
                                                        241, 147, 72, 1.0)),
                                          ),
                                          onPressed: () {
                                            sendDataPro();
                                          },
                                          child: const Text('Add Product'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                  ),
              ]),
            )));
  }
}
