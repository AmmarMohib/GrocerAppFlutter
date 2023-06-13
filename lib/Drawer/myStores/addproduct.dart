import 'dart:io';
import 'dart:math';
// import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groccer_app/Home/home.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String storeName;
  final String docId;
  const AddProduct({super.key, required this.storeName, required this.docId});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _imageFile;
  String? imgUrl;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _desController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
    if (_imageFile != null) {
      // final storageRef = FirebaseStorage.instance.ref();
      //   var fileName = _imageFile!.path;
      //             final firebaseStorageRef =
      //   FirebaseStorage.instance.ref().child('uploads/$fileName');
      //           final uploadTask = firebaseStorageRef.putFile(_imageFile!);
      // final taskSnapshot = await uploadTask.then((p0) =>
      //       print("Done: $p0"),
      //     );

      Random rnd = Random();
      final String imgPath = 'imgs/${rnd.nextInt(4000000)}';

      final reference = FirebaseStorage.instance.ref().child(imgPath);

      final TaskSnapshot snapshot = await reference.putFile(_imageFile!);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      setState(() {
        imgUrl = downloadUrl;
      });
      // print(_priceController);
      // print(_quantityController);
      // print(_titleController);
    }
  }

  sendData() {
    FirebaseFirestore databaseinstance = FirebaseFirestore.instance;
    databaseinstance
        .collection("Stores")
        .doc(widget.docId)
        .collection("Products")
        .add({
      // "category": widget.category,
      // "sub-category": widget.subcategory,
      "img-url": imgUrl,
      "title": _titleController.text,
      "price": _priceController.text,
      "quantity": _quantityController.text,
      "des": _desController.text
    }).whenComplete(() {
      Fluttertoast.showToast(
          msg: 'The Product Added Successfully in your store');
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.docId);
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
          title: Text("Add Product",
              //  widget.title,
              style: TextStyle(color: Colors.white)),
          actions: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 20),
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                  child: Text(
                    "[${widget.storeName}]",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 20.0),
                  child: Text(
                    "Add an Image",
                    style: TextStyle(
                        color: Color.fromRGBO(127, 159, 185, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                if (_imageFile != null) ...[
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromRGBO(127, 159, 185, 1),
                    backgroundImage: FileImage(
                      _imageFile!,
                      // width: MediaQuery.of(context).size.width * 0.4,
                      // height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(127, 159, 185, 1)),
                    ),
                    onPressed: _pickImage,
                    child: Text('Pick another image'),
                  ),
                ] else ...[
                  Text('No image selected.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(127, 159, 185, 1)),
                    ),
                    onPressed: _pickImage,
                    child: Text('Pick an image'),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
                SizedBox(
                  height: 20,
                ),

                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 20.0),
                  child: Text(
                    "Product Title",
                    style: TextStyle(
                        color: Color.fromRGBO(127, 159, 185, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Title',
                      hintText: 'Title',
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 20.0),
                  child: Text(
                    "Product Price",
                    style: TextStyle(
                        color: Color.fromRGBO(127, 159, 185, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Title',
                      prefix: Text("Rs:"),
                      hintText: 'Price',
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 20.0),
                  child: Text(
                    "Product quantity",
                    style: TextStyle(
                        color: Color.fromRGBO(127, 159, 185, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Title',
                      // prefix: Text("Rs:"),
                      hintText: 'Quantity, ex: 10kg',
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 20.0),
                  child: Text(
                    "Describe your product",
                    style: TextStyle(
                        color: Color.fromRGBO(127, 159, 185, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    maxLines: 4,
                    controller: _desController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Title',
                      // prefix: Text("Rs:"),
                      hintText: 'description',
                    ),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(127, 159, 185, 1)),
                    ),
                    onPressed: () {
                      sendData();
                    },
                    child: Text('Add in Store'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
