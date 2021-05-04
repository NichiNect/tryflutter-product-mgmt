import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/views/add_product.dart';
import 'package:frontend/views/edit_product.dart';
import 'package:frontend/views/product_detail.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  // Endpoint for Android Emulator
  final String url = "http://10.0.2.2:8000/api/products";

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
      ),
      appBar: AppBar(
        title: Center(child: Text("Nect Product Store")),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshoot) {
          if (snapshoot.hasData) {
            return ListView.builder(
                itemCount: snapshoot.data['data'].length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 130,
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                            product: snapshoot.data['data']
                                                [index],
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              height: 120,
                              width: 120,
                              padding: EdgeInsets.all(3),
                              child: Image.network(
                                  snapshoot.data['data'][index]['thumbnail']),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetail(
                                                        product: snapshoot
                                                            .data['data'][index])));
                                      },
                                      child: Text(
                                        snapshoot.data['data'][index]
                                            ['nama_product'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      snapshoot.data['data'][index]
                                          ['description'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => EditProduct(product: snapshoot.data['data'][index]))
                                          );
                                        },
                                        child: Icon(Icons.edit)
                                      ),
                                      Text(snapshoot.data['data'][index]
                                              ['price']
                                          .toString())
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: Text('Data tidak ditemukan'));
          }
        },
      ),
    );
  }
}
