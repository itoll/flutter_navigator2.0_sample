import 'package:flutter_navigator2_sample/network/http_handler.dart';

class FetchPopularMovies {
  final HttpHandler http;

  FetchPopularMovies({required this.http});

  Future call() async => await http.get('/movie/popular');
}
