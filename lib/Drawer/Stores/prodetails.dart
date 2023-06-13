import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String quantity;
  final String detail;
  final String price;
  const ProductDetails(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.quantity,
      required this.detail,
      required this.price});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    print(widget.detail);
    print(widget.quantity);
    print(widget.imageUrl);
    print(widget.price);
    print(widget.title);
    // return MaterialApp(
    //   home: Scaffold(body: Text("df")),
    
    // );
        return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
          // resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          // appBar: PreferredSize(
          //     preferredSize: const Size.fromHeight(40),
          //     child: AppBar(

          //         // systemOverlayStyle:  const SystemUiOverlayStyle(
          //         //     statusBarColor: Colors.black,systemNavigationBarColor: Colors.black),
          //         elevation: 0,
          //         backgroundColor: Colors.transparent,
          //         leading: IconButton(
          //           icon: const Icon(
          //             Icons.close,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           iconSize: 30,
          //         ),
          //         title: Align(
          //             alignment: Alignment.centerRight,
          //             child: IconButton(
          //               onPressed: () {},
          //               icon: const Icon(Icons.share),
          //               color: Colors.white,
          //             )))),
          appBar: AppBar(
            
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(241, 147, 72, 1.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  backgroundColor: Colors.white,
                  title:
                      Text(widget.title ,
                      //  widget.title,
                       style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                  actions: [
                    Icon(Icons.share, color: Color.fromRGBO(241, 147, 72, 1.0)),
                    SizedBox(width: 20),
                    Icon(Icons.search,
                        color: Color.fromRGBO(241, 147, 72, 1.0)),
                    SizedBox(width: 20),
                    Icon(Icons.shopping_cart_outlined,
                        color: Color.fromRGBO(241, 147, 72, 1.0)),
                    SizedBox(width: 10),
                  ],
                ),
          body: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 10,),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 5, bottom: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Slideshow(
                      //               imageURL: widget.slides,
                      //             )));
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Image.network(
                                    widget.imageUrl,
                                    fit: BoxFit.contain,
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height * 0.25,
                                  ),
                                ),
                              ],
                            ))
                    ),
                  Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Rs ${widget.price}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  // fontwo
                                  color: Color.fromRGBO(230, 0, 57, 1.0),
                                  fontWeight: FontWeight.w900),
                            ),
                          )),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite_border_outlined,color: Color.fromRGBO(255, 121, 62, 1.0)),
                              onPressed: () {},
                            ),
                            Text(widget.quantity),
                            SizedBox(width: 20,)
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                        
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1.0,
                        child: const Divider(
                          color: Color.fromRGBO(235, 238, 239, 1.0),
                          height: 20,
                          thickness: 1.8,
                          // indent: 10,
                          // endIndent: 60,
                        ),
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0, top: 10),
                              child: Text(
                                widget.detail ,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromRGBO(5, 51, 56, 1),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
            ),
          )),
    );
  }
}
