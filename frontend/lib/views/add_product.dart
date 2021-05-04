import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/views/homepage.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _nameProductController = TextEditingController();
    TextEditingController _descriptionProductController =
        TextEditingController();
    TextEditingController _priceProductController = TextEditingController();
    TextEditingController _imageProductController = TextEditingController();

    Future saveProduct() async {
      final res = await http
          .post(Uri.parse('http://10.0.2.2:8000/api/products'), body: {
        "nama_product": _nameProductController.text,
        "description": _descriptionProductController.text,
        "thumbnail": _imageProductController.text,
        "price": _priceProductController.text,
      });

      return json.decode(res.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
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
                          Text("Form Add Product", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                          TextFormField(
                            controller: _nameProductController,
                            decoration: InputDecoration(labelText: "Name Product"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please insert the name of product!";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _descriptionProductController,
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
                            controller: _priceProductController,
                            decoration: InputDecoration(labelText: "Price Product"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please insert the price of product!";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _imageProductController,
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
                                  saveProduct().then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  });
                                }
                              },
                              child: Text("Add Product"))
                        ],
                      )
                    ),
                  )
              ),
            ],
      ),
    );
  }
}
