import 'package:flutter/material.dart';
import 'package:flutter_nodejs_backend/core/logger.dart';
import 'package:flutter_nodejs_backend/model/product.dart';
import 'package:flutter_nodejs_backend/services/remote_service.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
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
              List<Product> pdataList = snapshot.data ?? [];
              Logger.i('List length', pdataList.length);
              return ListView.builder(
                  itemCount: pdataList.length,
                  itemBuilder: (cxt, idx) {
                    return ListTile(
                      leading: const Icon(Icons.storage),
                      title: Text(pdataList[idx].desc),
                      subtitle: Text(pdataList[idx].desc),
                      trailing: Text(pdataList[idx].price),
                    );
                  });
            }
          }),
    );
  }
}
