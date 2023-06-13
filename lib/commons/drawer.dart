import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groccer_app/Drawer/Admin/login.dart';
import 'package:groccer_app/Drawer/MyCart/myCart.dart';
import 'package:groccer_app/Drawer/MyProfile/myprofile.dart';
import 'package:groccer_app/Drawer/SignIn/siginin.dart';
import 'package:groccer_app/Drawer/Stores/stores.dart';
import 'package:groccer_app/Drawer/createStore/createstore.dart';
import 'package:groccer_app/Drawer/myStores/mystores.dart';
import 'package:groccer_app/commons/dialog_box.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 105,
          // width: 10,
          child: DrawerHeader(
            
            decoration: const BoxDecoration(
              // backgroundBlendMode: BlendMode.color,
              color: Color.fromRGBO(250, 250, 250, 1.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.close),
                SizedBox(width: 15,),
                Container(
                    child:
                Text(
                   'Hey, User',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(50, 50, 50, 1.0)),
                ))
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(
          FontAwesomeIcons.store,
            size: 25,
            color: Color.fromRGBO(119, 119, 119, 1.0),
          ),
          title: const Text('Stores',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return StoresPage();
            })));
            // Update the UI based on the item selected
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.s,
            size: 25,
            color: Color.fromRGBO(119, 119, 119, 1.0),
          ),
          title: const Text('My Stores',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            // Update the UI based on the item selected
                   Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyStores()));
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.cartShopping,
            size: 25,
            color: Color.fromRGBO(119, 119, 119, 1.0),
          ),
          title: const Text('Carted Products',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyCart()));
            // Update the UI based on the item selected
          },
        ),
        ListTile(
          leading: Icon(
          FontAwesomeIcons.solidUser,
            size: 25,
            color: Color.fromRGBO(119, 119, 119, 1.0),
          ),
          title: const Text('My Profile',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            // Update the UI based on the item selected
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyProfile()));
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.sellcast,
            size: 25,
            color: Color.fromRGBO(119, 119, 119, 1.0),
          ),
          title: const Text('Create a Store',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            // Update the UI based on the item selected
                   Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CreateStore()));
          },
        ),

        ListTile(
          leading: Icon(
            FontAwesomeIcons.solidBell,
            size: 25,
            color: Color.fromRGBO(119, 119, 119, 1.0),
          ),
          title: const Text('Notifications',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            // Update the UI based on the item selected
          },
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline,
            size: 30,
            color: Color.fromRGBO(119, 119, 119, 1.0),
          ),
          title: const Text('FAQs',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            // Update the UI based on the item selected
          },
        ),
        ListTile(
          leading: Icon(
        FontAwesomeIcons.chartLine,
            size: 25,
            color: Color.fromRGBO(119, 119, 119, 1.0),
          ),
          title: const Text('Store Analyses',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            // Update the UI based on the item selected
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminLogin()));
          },
        ),
        ListTile(
            leading: Icon(
              Icons.power_settings_new_outlined,
              size: 30,
              color: Color.fromRGBO(119, 119, 119, 1.0),
            ),
            title: FirebaseAuth.instance.currentUser == null
                ? Text('Sign In',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ))
                : Text('Sign Out',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    )),
            onTap: () async {
              // Update the UI based on the item selected
              if (FirebaseAuth.instance.currentUser != null) {
                VoidCallback continueCallBack = () async => {
                    await FirebaseAuth.instance.signOut(),
                      Navigator.of(context, rootNavigator: true).pop('dialog')
                      // code on continue comes here
                      
                    };
                BlurryDialog alert = BlurryDialog(
                    "Logout",
                    "Are you sure you want to Sign Out?",
                    continueCallBack);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              }
            }),
ListTile(
          leading: Icon(
        FontAwesomeIcons.brandsFontAwesome,
            size: 25,
            color: Color.fromRGBO(119, 119, 119, 1.0),
          ),
          title: const Text('About Us',
              style: TextStyle(
               fontSize: 15,
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            // Update the UI based on the item selected
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminLogin()));
          },
        ),        
      ],
    );
  }
}
