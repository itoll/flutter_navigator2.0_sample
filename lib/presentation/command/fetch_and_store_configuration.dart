import 'dart:convert';

import 'package:flutter_navigator2_sample/network/http_handler.dart';
import 'package:flutter_navigator2_sample/storage/shared_preferences_manager.dart';
import 'package:http/http.dart';

class FetchAndStoreConfiguration {
  final HttpHandler http;
  final SharedPreferencesManager sp;

  FetchAndStoreConfiguration({required this.http, required this.sp});

  Future<Response> call() async {
    var response = await http.get('/configuration');
    var jsonResponse = jsonDecode(response.body);
    await sp.storeString('IMAGE_BASE_URL', jsonResponse['images']['base_url']);
    return response;
  }
}
