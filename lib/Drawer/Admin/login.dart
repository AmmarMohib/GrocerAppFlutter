import 'package:flutter/material.dart';
import 'package:groccer_app/Drawer/Admin/admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title:Text("Admin Panel", style: TextStyle(color: Colors.black) ))),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(241, 147, 72, 1.0),
              ),
              onPressed: (() {
                Navigator.pop(context);
              })),
          backgroundColor: Colors.white,
          title: Text("Admin Login", style: TextStyle(color: Colors.black)),
          // bottom: TabBar(
          //   controller: TabController(
          //       length: widget.tabs.length,
          //       vsync: this,
          //       initialIndex: widget.defaultIndex),
          //   isScrollable: true,
          //   indicatorWeight: 1.0,
          //   // indicatorColor: Colors.green, // set the initial color of the tab indicator
          //   indicatorSize: TabBarIndicatorSize.tab,
          //   indicatorColor: Color.fromRGBO(241, 147, 72, 1.0),
          //   // labelPadding: EdgeInsets.only(: 10),
          //   labelColor: Color.fromRGBO(241, 147, 72, 1.0),
          //   // splashBorderRadius: BorderRadius.only(topLeft: rad),
          //   // indicator:,
          //   unselectedLabelColor: Colors.black,
          //   // labelStyle: TextStyle(color: Colors.white),

          //   // tabs: [
          //   //   // ignore: avoid_function_literals_in_foreach_calls
          //   //   widget.tabs.
          //   //   Tab(icon: Icon(Icons.contacts), text: "Tab 1"),
          //   // ],
          //   // tabs: widget.tabs.map(
          //   //       (title) => Tab(text: title['title']),
          //   //     )
          //   //     .toList(),
          // ),
          // actions: [
          //   Icon(Icons.share, color: Color.fromRGBO(241, 147, 72, 1.0)),
          //   SizedBox(
          //     width: 20,
          //   ),
          //   Icon(Icons.search, color: Color.fromRGBO(241, 147, 72, 1.0)),
          //   SizedBox(
          //     width: 20,
          //   ),
          //   Icon(Icons.shopping_cart_outlined,
          //       color: Color.fromRGBO(241, 147, 72, 1.0)),
          //   SizedBox(
          //     width: 10,
          //   ),
          // ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // labelText: 'Password',
                  hintText: 'Enter Password',
                ),
                onChanged: ((value) {
                  if (value == "123gr") {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPanel()));
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
