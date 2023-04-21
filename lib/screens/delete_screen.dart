import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_nodejs_backend/model/product.dart';
import 'package:flutter_nodejs_backend/services/remote_service.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  RemoteService remoteService = RemoteService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: remoteService.getProduct(),
        builder: (cxt, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Product> pdata = snapshot.data ?? [];

            return ListView.builder(
              itemCount: pdata.length,
              itemBuilder: (cxt, idx) {
                return ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text(pdata[idx].name),
                  subtitle: Text(pdata[idx].desc),
                  trailing: IconButton(
                    onPressed: () async {
                      await remoteService.deleteProduct(pdata[idx].id);
                      pdata.removeAt(idx);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
