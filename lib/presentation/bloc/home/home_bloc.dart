import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/navigation/router_delegate/app_router_delegate.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/home/home_event.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/home/home_state.dart';
import 'package:flutter_navigator2_sample/presentation/command/fetch_image_base_url.dart';
import 'package:flutter_navigator2_sample/presentation/command/fetch_popular_movies.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppRouterDelegate router;

  final FetchPopularMovies fetchPopularMovies;
  final FetchImageBaseUrl fetchImageBaseUrl;

  HomeBloc({required this.router, required this.fetchPopularMovies, required this.fetchImageBaseUrl, required HomeState initialState})
      : super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomePopularMoviesFetched) {
      yield* _mapPopularMoviesFetchedToState();
    } else if (event is HomeImageBaseUrlFetched) {
      yield* _mapImageBaseUrlFetchedToState();
    } else if (event is HomeMovieDetailPageOpened) {
      _openMovieDetailPage(event.movieId);
    }
  }

  Stream<HomeState> _mapPopularMoviesFetchedToState() async* {
    yield state.copyWith(movies: StateHolder.loading());
    try {
      await Future.delayed(Duration(seconds: 1));
      var response = await fetchPopularMovies();
      var responseJson = jsonDecode(response.body);
      yield state.copyWith(movies: StateHolder.completed(responseJson));
    } on Exception catch (exception) {
      yield state.copyWith(movies: StateHolder.error(failure: exception));
    }
  }

  Stream<HomeState> _mapImageBaseUrlFetchedToState() async* {
    try {
      var response = fetchImageBaseUrl();
      yield state.copyWith(imageBaseUrl: response);
    } on Exception catch (exception) {
      yield state.copyWith(imageBaseUrl: '');
    }
  }

  void _openMovieDetailPage(int movieId) {
    var destination = Uri.parse('/${PageKeys.MovieDetail}/$movieId');
    router.push(destination);
  }
}
