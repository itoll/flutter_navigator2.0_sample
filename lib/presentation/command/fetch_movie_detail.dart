import 'package:flutter_navigator2_sample/network/http_handler.dart';
import 'package:http/http.dart';

class FetchMovieDetail {
  final HttpHandler http;

  FetchMovieDetail({required this.http});

  Future<Response> call(int movieId) async => await http.get('/movie/$movieId');
}
