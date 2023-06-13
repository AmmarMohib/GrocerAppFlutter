import 'dart:io';
import 'dart:math';

import 'package:another_stepper/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:groccer_app/Drawer/SignIn/siginin.dart';
import 'package:groccer_app/Drawer/Stores/stores.dart';
import 'package:image_picker/image_picker.dart';

class CreateStore extends StatefulWidget {
  const CreateStore({super.key});

  @override
  State<CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _subNameController = TextEditingController();

  File? _storeImgFile;
  String? StoreImgURL;
  List<String> _categories = [];
  int _currentStep = 0;
  Future<void> _pickImageStore() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _storeImgFile = File(pickedFile!.path);
    });
    if (_storeImgFile != null) {
      Random rnd = Random();
      final String imgPath = 'imgs/${rnd.nextInt(4000000)}';

      final reference = FirebaseStorage.instance.ref().child(imgPath);

      final TaskSnapshot snapshot = await reference.putFile(_storeImgFile!);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      setState(() {
        StoreImgURL = downloadUrl;
      });
    }
  }

  String _locationName = '';

  void _getCurrentLocation() async {
    try {
      // Get the current position of the device
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get the address of the current location
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];
      String name = placemark.name ?? '';
      String locality = placemark.locality ?? '';
      String adminArea = placemark.administrativeArea ?? '';
      String country = placemark.country ?? '';
      String postalCode = placemark.postalCode ?? '';
      setState(() {
        _locationName = '$name, $locality, $adminArea, $country $postalCode';
      });
    } catch (e) {
      print(e);
    }
  }

  void _goToNextStep() {
    Random rnd = Random();
    switch (_currentStep) {
      case 0:
        print("the case is 0");
        if (StoreImgURL != "") {
          setState(() {
            _currentStep++;
          });
        }
        break;
      case 1:
        if (_nameController.text != "") {
          setState(() {
            _currentStep++;
          });
        }
        break;
      case 2:
        if (_subNameController.text != "") {
          setState(() {
            _currentStep++;
          });
        }
        break;
      case 3:
        if (_categories.isNotEmpty) {
          setState(() {
            _currentStep++;
          });
        }
        // print("the case is 2");
        break;
      case 4:
        if (_desController.text != "") {
          setState(() {
            _currentStep++;
          });
        }
        break;
      case 5:
        if (_locationName != "") {
          var index = rnd.nextInt(400000).toString();
          FirebaseFirestore.instance.collection("Stores").doc(index).set({
            "logoURL": StoreImgURL,
            "name": _nameController.text,
            "subname": _subNameController.text,
            "categories": _categories,
            "des": _desController.text,
            "location": _locationName,
            "CreatorName": FirebaseAuth.instance.currentUser!.displayName,
            "CreatorPhoto": FirebaseAuth.instance.currentUser!.photoURL,
            "CreatorEmail": FirebaseAuth.instance.currentUser!.email,
            "CreatorUid": FirebaseAuth.instance.currentUser!.uid,
            "docId": index
          }).then((value) async {
            Fluttertoast.showToast(msg: 'Your store created');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => StoresPage()));
          });
        }
        print("the case is 3");
        break;
      default:
    }
  }

  void _goToPreviousStep() {
    setState(() {
      _currentStep--;
    });
  }

  String location = "";
  List<Step> stepList() => [
        Step(
          title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Upload the logo of your store",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
          content:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.only(left: 0.0, top: 20.0),
              child: Text(
                "Add an Image",
                style: TextStyle(
                    color: Color.fromRGBO(255, 121, 62, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: const Text(
                  "* Please note that only the image with transparent backgroud is to be uploaded",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                )),
            const SizedBox(
              height: 20,
            ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            if (_storeImgFile != null) ...[
              // SizedBox(height: 40),
              // CircleAvatar(
              //   child: Image.file(
              //     _imageFile!,
              //     width: MediaQuery.of(context).size.width * 0.5,
              //     height: MediaQuery.of(context).size.height * 0.2,
              //   ),
              // ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(40), // Image border
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(48), // Image radius
                    // backgroundColor: const Color.fromRGBO(237, 230, 227, 1),
                    child: Image.file(
                      _storeImgFile!,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    // widget to be displayed inside the avatar
                  )),
              const SizedBox(
                height: 20,
              ),

              // SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(127, 159, 185, 1.0)),
                ),
                onPressed: _pickImageStore,
                child: const Text('Pick another image'),
              ),
            ] else ...[
              const Text('No image selected.'),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(127, 159, 185, 1.0)),
                  elevation: MaterialStateProperty.resolveWith((states) => 10),
                ),
                onPressed: _pickImageStore,
                child: const Text('Pick an image'),
              ),
            ],
          ]),
          isActive: true,
        ),
        Step(
          title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Give a name to the store",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: SizedBox(
                  child: TextField(
                      controller: _nameController,
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                  width: MediaQuery.of(context).size.width * 0.9),
            ),
          ),
          isActive: true,
        ),
        Step(
          title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "What are you selling?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: SizedBox(
                  child: TextField(
                      controller: _subNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixText: 'We are selling ')),
                  width: MediaQuery.of(context).size.width * 0.9),
            ),
          ),
          isActive: true,
        ),
        Step(
          // title: Padding(padding: EdgeInsets.only(left: 20),child: Text("Step 1:", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),),

          title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Add Categories to your store",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
          content: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "",
                  style: TextStyle(
                      color: Color.fromRGBO(127, 159, 185, 1.0),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: SizedBox(
                    child: TextField(
                        controller: _categoryController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _addCategory,
                          ),
                        )),
                    width: MediaQuery.of(context).size.width * 0.9),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_categories[index]),
                    );
                  },
                ),
              ),
            ],
          ),

          isActive: true,
        ),
        Step(
          // title: Padding(padding: EdgeInsets.only(left: 20),child: Text("Step 1:", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),),

          title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Describe your store",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: SizedBox(
                  child: TextField(
                      maxLines: 5,
                      controller: _desController,
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                  width: MediaQuery.of(context).size.width * 0.9),
            ),
          ),
          isActive: true,
        ),
        Step(
          title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Give location of your store",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                      child: ElevatedButton(
                          onPressed: () async {
                            _getCurrentLocation();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => PlacePicker(
                            //             'YOUR_API_KEY',

                            //             // displayLocation:,
                            //             // onPlacePicked: (result) {
                            //             //   // Do something with the picked location
                            //             // },
                            //           )),
                            // );
                            // LocationResult? result = await Navigator.of(context)
                            //     .push(MaterialPageRoute(
                            //         builder: (context) => PlacePicker(
                            //             "AIzaSyB_APntItUlVQccUcXhFq7JesdWaQuNItE")));
                            // // Handle the result in your way
                            // print(result);
                            // setState(() {
                            //   location = result!.placeId.toString();
                            // });
                          },
                          child: Text('Pick Location'))),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  _locationName,
                  textAlign: TextAlign.center,
                ))
              ],
            ),
          ),
          isActive: true,
        ),
      ];
  void _addCategory() {
    if (_categoryController.text.isNotEmpty) {
      setState(() {
        _categories.add(_categoryController.text);
        _categoryController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(127, 159, 185, 1.0),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Create a Store"),
        ),
        body: FirebaseAuth.instance.currentUser == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    'Please Sign In to Create a Store !',
                    style: TextStyle(color: Colors.red),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => SignIn())));
                    },
                    child: Text("Sign In"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(127, 159, 185, 1.0)),
                  )
                ],
              )
            : Theme(
                data: ThemeData(
                  //  accentColor: Colors.orange,
                  //   primarySwatch: Color.fromRGBO(127, 159, 185, 1.0),
                  //   colorScheme: ColorScheme.light(
                  //     primary: Color.fromRGBO(127, 159, 185, 1.0)
                  //   )
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: const Color.fromRGBO(128, 160, 186, 1.0),
                    secondary: const Color.fromRGBO(128, 160, 186, 1.0),
                    // or from RGB

                    // primary: const Color(0xFF343A40),
                    // secondary: const Color(0xFFFFC107),
                  ),
                ),
                child: Stepper(
                  currentStep: _currentStep,
                  onStepTapped: (value) {
                    print(value.toString() + "gvc");
                  },

                  // onStepContinue: _goToNextStep,
                  // onStepCancel: _goToPreviousStep,
                  onStepContinue: _goToNextStep,
                  onStepCancel: _currentStep > 0 ? _goToPreviousStep : null,
                  steps: stepList(),
                ),
              ),
      ),
    );
  }
}
