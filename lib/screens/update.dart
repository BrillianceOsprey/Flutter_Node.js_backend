import 'package:flutter/material.dart';
import 'package:flutter_nodejs_backend/model/product.dart';
import 'package:flutter_nodejs_backend/screens/edit_screen.dart';
import 'package:flutter_nodejs_backend/services/remote_service.dart';

import '../core/logger.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  RemoteService remoteService = RemoteService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update product'),
      ),
      body: FutureBuilder(
          future: remoteService.getProduct(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Product> pdata = snapshot.data ?? [];
              Logger.clap('Porduct id', pdata);
              return ListView.builder(
                  itemCount: pdata.length,
                  itemBuilder: (cxt, idx) {
                    return ListTile(
                      leading: const Icon(Icons.storage),
                      title: Text(pdata[idx].name),
                      subtitle: Text(pdata[idx].desc),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (cxt) {
                                  return EditScreen(
                                    pdata: pdata[idx],
                                  );
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit)),
                    );
                  });
            }
          })),
    );
  }
}
