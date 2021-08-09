import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/navigation/router_delegate/app_router_delegate.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  MovieDetailScreen({required this.movieId});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    _fetchMovieDetail();
    _fetchImageBaseUrl();
    super.initState();
  }

  void _fetchImageBaseUrl() {
    BlocProvider.of<MovieDetailBloc>(context).add(MovieDetailImageBaseUrlFetched());
  }

  void _fetchMovieDetail() {
    BlocProvider.of<MovieDetailBloc>(context).add(MovieDetailFetched(movieId: widget.movieId));
  }

  void _onBackButtonPressed() {
    sl<AppRouterDelegate>().pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: null,
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            switch (state.detail?.status) {
              case Status.COMPLETED:
                var detail = state.detail!.data!;
                var backdropUrl = (state.imageBaseUrl ?? '') + 'original/' + (detail['backdrop_path'] as String).substring(1);
                var posterUrl = (state.imageBaseUrl ?? '') + 'original/' + (detail['poster_path'] as String).substring(1);
                return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_rounded),
                        color: Colors.white,
                        onPressed: _onBackButtonPressed,
                      ),
                      pinned: true,
                      backgroundColor: Colors.black,
                      // title: Text(detail['title']),
                      // centerTitle: true,
                      // stretch: true,
                      // collapsedHeight: 100.0,
                      expandedHeight: 200.0,
                      // backgroundColor: Colors.red,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          backdropUrl,
                          fit: BoxFit.cover,
                        ),
                        // background: ExtendedImage.network(
                        //   backdropUrl,
                        //   fit: BoxFit.fitHeight,
                        //   cache: true,
                        //   width: double.infinity,
                        //   height: 400,
                        //   borderRadius: BorderRadius.all(Radius.circular(6)),
                        //   loadStateChanged: (ExtendedImageState state) {
                        //     switch (state.extendedImageLoadState) {
                        //       case LoadState.loading:
                        //         return SpinKitDoubleBounce(
                        //           color: Colors.black,
                        //           size: 16.0,
                        //         );
                        //       case LoadState.completed:
                        //         return ExtendedRawImage(
                        //           image: state.extendedImageInfo?.image,
                        //           width: double.infinity,
                        //           scale: 2,
                        //         );
                        //       case LoadState.failed:
                        //         return Container(
                        //           child: Center(
                        //             child: Icon(
                        //               Icons.error_rounded,
                        //               color: Colors.red,
                        //             ),
                        //           ),
                        //         );
                        //       default:
                        //         return SizedBox();
                        //     }
                        //   },
                        // ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == 0) {
                          return Container(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(6)),
                                    child: Image.network(
                                      posterUrl,
                                      fit: BoxFit.contain,
                                      width: 64,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Text(detail['original_title']),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(padding: const EdgeInsets.all(24.0), child: Text(detail['overview']));
                        }
                      },
                      childCount: 2,
                    )),
                  ],
                );
              // return Container(
              //   child: Column(
              //     children: [
              //       Text(detail['title']),
              //       SizedBox(height: 32.0),
              //       Text(detail['overview']),
              //     ],
              //   ),
              // );
              case Status.LOADING:
                return Container(
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Colors.black,
                      size: 32.0,
                    ),
                  ),
                );
              case Status.ERROR:
                return Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: _fetchMovieDetail,
                      child: Text('Fetching detail failed, please retry...'),
                    ),
                  ),
                );
              default:
                return Container();
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
