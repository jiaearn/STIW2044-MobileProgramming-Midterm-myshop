import 'dart:convert';
import 'package:flutter/material.dart';
import 'newproduct.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyShop(),
    );
  }
}

class MyShop extends StatefulWidget {
  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  List _prList;
  String _titlecenter = "Loading...";
  double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Shop',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent[400],
      ),
      body: Center(
        child: Column(children: [
          _prList == null
              ? Flexible(
                  child: Center(
                      child: Text(_titlecenter,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold))))
              : Flexible(
                  child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GridView.builder(
                      itemCount: _prList.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio:
                                  (screenWidth / screenHeight) / 0.9),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "https://hubbuddies.com/269509/myshop/images/product_pictures/${_prList[index]['prid']}.png",
                                    height: 172.5,
                                    width: 172.86,
                                  )
                                ]),
                                Container(
                                  width: 172.86,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    )),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 15, 5, 0),
                                      child: Text(_prList[index]['prname'],
                                          style: TextStyle(
                                            fontSize: 18,
                                          )),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 15, 5, 0),
                                      child: Text(
                                        "Type: " + _prList[index]['prtype'],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 15, 5, 0),
                                      child: Text(
                                        "Price: RM " +
                                            _prList[index]['prprice'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 15, 5, 0),
                                      child: Text(
                                        "Quantity: " + _prList[index]['prqty'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 40, color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (content) => NewProduct()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _loadProducts() {
    http.post(
        Uri.parse("https://hubbuddies.com/269509/myshop/php/loadproducts.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No Product.";
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _prList = jsondata["products"];
        setState(() {});
      }
    });
  }
}
