// import 'dart:ffi';

// import 'package:flutter/material.dart';

// class PlacePicker extends StatefulWidget {
//   final String apiKey;
//   final onPlacePicked;
//   final bool useCurrentLocation;
//   const PlacePicker({super.key, required this.apiKey, required this.onPlacePicked, required this.useCurrentLocation});

//   @override
//   State<PlacePicker> createState() => _PlacePickerState();
// }

// class _PlacePickerState extends State<PlacePicker> {
//   @override
//   Widget build(BuildContext context) {
//     return FloatingCard(
//                       bottomPosition: MediaQuery.of(context).size.height * 0.05,
//                       leftPosition: MediaQuery.of(context).size.width * 0.05,
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       borderRadius: BorderRadius.circular(12.0),
//                       child: state == SearchingState.Searching ? 
//                                       Center(child: CircularProgressIndicator()) : 
//                                       RaisedButton(onPressed: () { print("do something with [selectedPlace] data"); },),
//                    );
//             },
//             // ...
//           ),;
//   }
// }
