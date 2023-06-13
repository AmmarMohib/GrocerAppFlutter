import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String storeName;
  final String sellingtxt;
  final String logo;
  final String location;
  final List tags;
  final String des;
  final String ctrName;
  final String ctrEmail;
  final String ctrPhoto;
  const Details(
      {super.key,
      required this.storeName,
      required this.sellingtxt,
      required this.tags,
      required this.des,
      required this.logo, required this.location, required this.ctrName, required this.ctrEmail, required this.ctrPhoto});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    // print(widget.des);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color.fromRGBO(127, 159, 185, 1),
          title: Text(widget.storeName,
              //  widget.title,
              style: const TextStyle(color: Colors.white)),
          actions: [
            // Icon(Icons.search, color: Colors.white),
            // SizedBox(width: 20),
          ],
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: const Color.fromRGBO(127, 159, 185, 1.0),
                backgroundImage: NetworkImage(widget.logo),
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
                "What are they offering?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  child: Text("We are selling " + widget.sellingtxt),
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
                "Who they are?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  child: Text(widget.des),
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
                "From where they are?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  child: Text(widget.location),
                  width: MediaQuery.of(context).size.width * 0.9,
                )),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Creator Info",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //     padding: const EdgeInsets.only(left: 20),
            //     child: Container(
            //       child: Text(widget.location),
            //       width: MediaQuery.of(context).size.width * 0.9,
            //     )),
            ListTile(
              leading: Image.network(widget.ctrPhoto),
              title: Text(widget.ctrName),
              subtitle: Text(widget.ctrEmail),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 20,
            ),
            SizedBox(
                height: 20,
                //  child: GridView.builder(itemBuilder: (context, index) => Text("#" + categories[index], style: TextStyle(color: Colors.blue),),itemCount: categories.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //    crossAxisCount: 3, // number of columns in the grid
                //    childAspectRatio: 1.0, // width-to-height ratio of each item
                //  ),),
                child: Center(
                  child: Wrap(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 3.0,
                    children: widget.tags
                        .map((e) => Text(
                              "#" + e,
                              style: const TextStyle(color: Colors.blue),
                            ))
                        .toList(),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
