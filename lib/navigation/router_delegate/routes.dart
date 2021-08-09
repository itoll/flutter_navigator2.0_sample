import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/navigation/type_aliases.dart';
import 'package:flutter_navigator2_sample/presentation/page/home_page.dart';
import 'package:flutter_navigator2_sample/presentation/page/loading_page.dart';
import 'package:flutter_navigator2_sample/presentation/page/movie_detail_page.dart';
import 'package:flutter_navigator2_sample/presentation/page/not_found_page.dart';
import 'package:flutter_navigator2_sample/presentation/page/splash_page.dart';

var routes = <String, PageBuilder>{
  '/${PageKeys.Splash}': (route) => SplashPage(),
  '/${PageKeys.Home}': (route) => HomePage(),
  '/${PageKeys.MovieDetail}/:movieId': (route) {
    var movieId = route.getParameter('movieId');
    if (movieId != null) {
      return MovieDetailPage(movieId: int.tryParse(movieId)!!);
    } else {
      return NotFoundPage();
    }
  },
  '/${PageKeys.Loading}': (route) => LoadingPage(),
};
