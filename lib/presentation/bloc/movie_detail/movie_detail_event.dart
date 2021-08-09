import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailFetched extends MovieDetailEvent {
  final int movieId;

  MovieDetailFetched({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class MovieDetailImageBaseUrlFetched extends MovieDetailEvent {}
