import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/views/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  @override
  final Map product;
  EditProduct({@required this.product});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameProductController = TextEditingController();
  TextEditingController _descriptionProductController = TextEditingController();
  TextEditingController _priceProductController = TextEditingController();
  TextEditingController _imageProductController = TextEditingController();

  Future editProduct() async {
    final res = await http.put(
        Uri.parse(
            'http://10.0.2.2:8000/api/products/' + product['id'].toString()),
        body: {
          "nama_product": _nameProductController.text,
          "description": _descriptionProductController.text,
          "thumbnail": _imageProductController.text,
          "price": _priceProductController.text,
        });

    return json.decode(res.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: ListView(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Form Edit Data Product",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: _nameProductController
                        ..text = product['nama_product'],
                      decoration: InputDecoration(labelText: "Name Product"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please insert the name of product!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionProductController
                        ..text = product['description'],
                      decoration:
                          InputDecoration(labelText: "Description Product"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please insert the description of product!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _priceProductController
                        ..text = product['price'].toString(),
                      decoration: InputDecoration(labelText: "Price Product"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please insert the price of product!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _imageProductController
                        ..text = product['thumbnail'],
                      decoration:
                          InputDecoration(labelText: "URL Thumbnail Product"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please insert the image url of product!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          editProduct().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text("Edit data successfully"),
                            ));
                          });
                        }
                      },
                      child: Text("Edit Product"))
                  ],
                )),
          )),
        ],
      ),
    );
  }
}
