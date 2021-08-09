import 'package:http/http.dart' as http;

const API_KEY = '1edb69b073722b271a250bfe5dd5b2d8';

const BASE_URL = 'https://api.themoviedb.org/3';

class HttpHandler {
  final http.Client client;

  HttpHandler({required this.client});

  Future<http.Response> get(String url) async {
    var uri = Uri.parse(BASE_URL + url + '?api_key=$API_KEY');
    return await client.get(uri);
  }

  Future<http.Response> post(String url, Object body) async {
    var uri = Uri.parse(BASE_URL + url + '?api_key=$API_KEY');
    return await client.post(uri, body: body);
  }
}
