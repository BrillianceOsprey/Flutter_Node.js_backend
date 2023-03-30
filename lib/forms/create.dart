import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_nodejs_backend/services/remote_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  RemoteService remoteService = RemoteService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _namecontroller,
              decoration: const InputDecoration(hintText: 'Name '),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(hintText: 'Price '),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            ElevatedButton(
                onPressed: () {
                  var data = {
                    "pname": _namecontroller.text,
                    "pprice": _priceController.text,
                    "pdesc": _descController.text,
                  };
                  remoteService.apiRequest(data);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Create'),
                ))
          ],
        ),
      ),
    );
  }
}
