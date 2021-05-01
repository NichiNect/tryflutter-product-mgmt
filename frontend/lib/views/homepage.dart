import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  final String url = "http://10.0.2.2:8000/api/products";

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nect Product Store"),
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
                          Container(
                            height: 120,
                            width: 120,
                            padding: EdgeInsets.all(3),
                            child: Image.network(
                              snapshoot.data['data'][index]['thumbnail']
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      snapshoot.data['data'][index]['nama_product'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      snapshoot.data['data'][index]['description'],
                                      style: TextStyle(
                                        fontSize: 10
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.edit),
                                      Text(snapshoot.data['data'][index]['price'].toString())
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
            return Text('Data tidak ditemukan');
          }
        },
      ),
    );
  }
}
