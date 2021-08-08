import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/navigation/custom_page_route.dart';
import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/screen/movie_detail_screen.dart';

class MovieDetailPage extends Page {
  final int movieId;

  const MovieDetailPage({LocalKey? key, required this.movieId}) : super(key: key, name: PageKeys.Home);

  @override
  Route createRoute(BuildContext context) {
    return CustomPageRoute(
      settings: this,
      child: BlocProvider<MovieDetailBloc>(
        create: (context) => sl<MovieDetailBloc>(),
        child: MovieDetailScreen(movieId: movieId),
      ),
    ).build();
  }
}
