import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final Map product;

  ProductDetail({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Detail Product"))),
      body: Center(
          child: Column(
            children: [
              Container(
                child: Image.network(product['thumbnail']),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rp. " + product['price'].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Row(children: [
                      Icon(Icons.edit),
                      Icon(Icons.delete),
                    ],),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(product['nama_product'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Column(children: [
                          Row(children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text("Description Product: ", style: TextStyle(fontSize: 12))),
                          ],),
                          Text(product['description'], style: TextStyle(fontSize: 12),),
                        ],)
                      )
                ],
              ),
            ],
          )
        )
    );
  }
}