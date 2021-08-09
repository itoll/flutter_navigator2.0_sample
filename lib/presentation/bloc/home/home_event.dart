import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeImageBaseUrlFetched extends HomeEvent {}

class HomePopularMoviesFetched extends HomeEvent {}

class HomeMovieDetailPageOpened extends HomeEvent {
  final int movieId;

  HomeMovieDetailPageOpened({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
