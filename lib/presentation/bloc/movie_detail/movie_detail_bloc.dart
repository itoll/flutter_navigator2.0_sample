import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({required MovieDetailState initialState}) : super(initialState);

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
