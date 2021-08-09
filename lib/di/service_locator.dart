import 'package:flutter_navigator2_sample/navigation/information/app_route_information_parser.dart';
import 'package:flutter_navigator2_sample/navigation/page_stack.dart';
import 'package:flutter_navigator2_sample/navigation/router_delegate/app_router_delegate.dart';
import 'package:flutter_navigator2_sample/network/http_handler.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/home/home_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/home/home_state.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_state.dart';
import 'package:flutter_navigator2_sample/presentation/command/fetch_and_store_configuration.dart';
import 'package:flutter_navigator2_sample/presentation/command/fetch_image_base_url.dart';
import 'package:flutter_navigator2_sample/presentation/command/fetch_movie_detail.dart';
import 'package:flutter_navigator2_sample/presentation/command/fetch_popular_movies.dart';
import 'package:flutter_navigator2_sample/storage/shared_preferences_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> bootstrapServiceLocator() async {
  sl.registerLazySingleton<AppRouterDelegate>(() => AppRouterDelegate.instance);
  sl.registerLazySingleton<AppRouteInformationParser>(() => AppRouteInformationParser());
  sl.registerLazySingleton<PageStack>(() => PageStack.initial());

  var httpClient = http.Client();
  sl.registerLazySingleton<HttpHandler>(() => HttpHandler(client: httpClient));

  var sp = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => SharedPreferencesManager(prefs: sp));

  sl.registerFactory<FetchAndStoreConfiguration>(() => FetchAndStoreConfiguration(http: sl(), sp: sl()));
  sl.registerFactory<FetchPopularMovies>(() => FetchPopularMovies(http: sl()));
  sl.registerFactory<FetchImageBaseUrl>(() => FetchImageBaseUrl(sharedPreferencesManager: sl()));
  sl.registerFactory<FetchMovieDetail>(() => FetchMovieDetail(http: sl()));

  sl.registerLazySingleton<SplashBloc>(() => SplashBloc(router: sl(), fetchAndStoreConfiguration: sl(), initialState: SplashState.initial()));
  sl.registerLazySingleton<HomeBloc>(
      () => HomeBloc(router: sl(), fetchPopularMovies: sl(), fetchImageBaseUrl: sl(), initialState: HomeState.initial()));
  sl.registerLazySingleton<MovieDetailBloc>(
      () => MovieDetailBloc(fetchMovieDetail: sl(), fetchImageBaseUrl: sl(), initialState: MovieDetailState.initial()));
}
