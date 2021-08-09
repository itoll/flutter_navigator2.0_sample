import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_navigator2_sample/presentation/command/fetch_image_base_url.dart';
import 'package:flutter_navigator2_sample/presentation/command/fetch_movie_detail.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final FetchMovieDetail fetchMovieDetail;
  final FetchImageBaseUrl fetchImageBaseUrl;

  MovieDetailBloc({required this.fetchMovieDetail, required this.fetchImageBaseUrl, required MovieDetailState initialState}) : super(initialState);

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is MovieDetailFetched) {
      yield* _mapMovieDetailFetchedToState(event.movieId);
    } else if (event is MovieDetailImageBaseUrlFetched) {
      yield* _mapImageBaseUrlFetchedToState();
    }
  }

  Stream<MovieDetailState> _mapMovieDetailFetchedToState(int movieId) async* {
    yield state.copyWith(detail: StateHolder.loading());
    try {
      var response = await fetchMovieDetail(movieId);
      var responseJson = jsonDecode(response.body);
      yield state.copyWith(detail: StateHolder.completed(responseJson));
    } on Exception catch (exception) {
      yield state.copyWith(detail: StateHolder.error(failure: exception));
    }
  }

  Stream<MovieDetailState> _mapImageBaseUrlFetchedToState() async* {
    try {
      var response = fetchImageBaseUrl();
      yield state.copyWith(imageBaseUrl: response);
    } on Exception catch (exception) {
      yield state.copyWith(imageBaseUrl: '');
    }
  }
}
