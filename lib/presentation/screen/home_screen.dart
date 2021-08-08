import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/home/home_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/home/home_event.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/home/home_state.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';
import 'package:flutter_navigator2_sample/presentation/widget/movie_list_item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _fetchImageBaseUrl();
    _fetchPopularMovies();
    super.initState();
  }

  void _fetchPopularMovies() {
    BlocProvider.of<HomeBloc>(context).add(HomePopularMoviesFetched());
  }

  void _fetchImageBaseUrl() {
    BlocProvider.of<HomeBloc>(context).add(HomeImageBaseUrlFetched());
  }

  void _onMoviePressed(Map<String, dynamic> item) {
    var id = item['id'];
    BlocProvider.of<HomeBloc>(context).add(HomeMovieDetailPageOpened(
      movieId: id,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Moviez'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.movies?.status) {
            case Status.COMPLETED:
              final List moviesList = state.movies?.data?['results'] ?? [];
              return ListView.builder(
                itemExtent: 100,
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                itemCount: moviesList.length,
                itemBuilder: (context, index) {
                  var item = moviesList.elementAt(index);
                  return MovieListItem(onPressed: () => _onMoviePressed(item), item: item, imageBaseUrl: state.imageBaseUrl ?? '');
                },
              );
              break;
            case Status.LOADING:
              return Container(
                child: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.black,
                    size: 24.0,
                  ),
                ),
              );
            case Status.ERROR:
              return Container(
                child: Center(
                  child: GestureDetector(
                    onTap: _fetchPopularMovies,
                    child: Text("Failed to fetch, please try again..."),
                  ),
                ),
              );
            default:
              return Container();
          }
          return Container();
        },
      ),
    );
  }
}
