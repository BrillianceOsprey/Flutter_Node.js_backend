import 'package:flutter/material.dart';

import 'package:flutter_nodejs_backend/model/product.dart';
import 'package:flutter_nodejs_backend/services/remote_service.dart';

class EditScreen extends StatefulWidget {
  final Product pdata;
  const EditScreen({super.key, required this.pdata});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  RemoteService remoteService = RemoteService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.pdata.name.toString();
    _descController.text = widget.pdata.desc.toString();
    _priceController.text = widget.pdata.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: "Name here"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(hintText: "Price here"),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(hintText: "Desc here"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                var body = {
                  "id": widget.pdata.id,
                  "pname": _nameController.text,
                  "pprice": _priceController.text,
                  "pdesc": _descController.text,
                };

                remoteService.updateProduct(widget.pdata.id, body);
              },
              child: const Text("Update Product"),
            ),
          ],
        ),
      ),
    );
  }
}
