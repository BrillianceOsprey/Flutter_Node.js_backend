import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nodejs_backend/core/logger.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';

class RemoteService {
  final dio = Dio();

  static const baseUrl = "http://192.168.0.5/api/";
  Future apiRequest(Map<String, dynamic> pdata) async {
    var url = Uri.parse("${baseUrl}add_product");
    var dioUrl = "${baseUrl}add_product";
    final toJsonData = jsonEncode(pdata);
    Logger.i("JsonEncode", toJsonData);
    try {
      var response = await dio.post(dioUrl, data: toJsonData);
      final responseInfo = response.data;

      Logger.d('Response ', responseInfo['status_code']);

      if (response.statusCode == 200) {
        Logger.d('Response statuscode', response.statusCode);
        //
        var data = response.data['product'];
        Logger.d('Response Data', data);
      } else {
        //
        print('Failed to get response');
      }
    } catch (e) {
      Logger.e('Catched Error', e.toString());
    }
  }

// get method
  Future<List<Product>> getProduct() async {
    var dioUrl = "${baseUrl}get_product";
    try {
      Logger.clap('Remote Service get porduct url', dioUrl);
      var response = await dio.get(
        dioUrl,
      );
      // final responseInfo = response.data;

      // Logger.d('Response ', responseInfo['status_code']);

      if (response.statusCode == 200) {
        Logger.d('Response statuscode', response.statusCode);
        //
        var data = response.data['products'] as List<dynamic>;
        Logger.d('Response Data', data);

        return data
            .map(
              (e) => Product(
                name: e['pname'],
                price: e['pprice'],
                desc: e['pdesc'],
                id: e['id'].toString(),
              ),
            )
            .toList();
      } else {
        return [];
        //
      }
    } catch (e) {
      Logger.e('Catched Error', e.toString());

      return [];
    }
  }

  // update product api
  Future updateProduct(id, body) async {
    var dioUrl = "${baseUrl}update/$id";
    final sBody = jsonEncode(body);
    try {
      Logger.clap('Remote Service get porduct url', dioUrl);
      Logger.clap('Remote Service get porduct body', sBody);
      var response = await dio.put(dioUrl, data: body);
      Logger.clap('Remote Service get porduct response', response);

      if (response.statusCode == 200) {
        Logger.d('Response statuscode', response.data);
      } else {
        Logger.d('Response Else state', response.statusMessage);
      }
    } catch (e) {
      Logger.e('Catched Error', e.toString());
    }
  }

  // delete product api
  Future deleteProduct(id, body) async {
    var dioUrl = "${baseUrl}delete/$id";
    final sBody = jsonEncode(body);
    try {
      Logger.clap('Remote Service get porduct url', dioUrl);
      Logger.clap('Remote Service get porduct body', sBody);
      var response = await dio.put(dioUrl, data: body);
      Logger.clap('Remote Service get porduct response', response);

      if (response.statusCode == 200) {
        Logger.d('Response statuscode', response.data);
      } else {
        Logger.d('Response Else state', response.statusMessage);
      }
    } catch (e) {
      Logger.e('Catched Error', e.toString());
    }
  }
}
