import 'package:equatable/equatable.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';

class HomeState extends Equatable {
  final StateHolder<Map<String, dynamic>>? movies;

  final String? imageBaseUrl;

  HomeState({this.movies, this.imageBaseUrl});

  HomeState.initial()
      : movies = StateHolder.empty(),
        imageBaseUrl = null;

  HomeState copyWith({
    StateHolder<Map<String, dynamic>>? movies,
    String? imageBaseUrl,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      imageBaseUrl: imageBaseUrl ?? this.imageBaseUrl,
    );
  }

  @override
  List<Object?> get props => [movies, imageBaseUrl];
}
