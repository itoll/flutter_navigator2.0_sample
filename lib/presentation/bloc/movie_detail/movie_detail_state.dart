import 'package:equatable/equatable.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';

class MovieDetailState extends Equatable {
  final StateHolder<Map<String, dynamic>>? detail;
  final String? imageBaseUrl;

  MovieDetailState({this.detail, this.imageBaseUrl});

  MovieDetailState.initial()
      : detail = StateHolder<Map<String, dynamic>>.empty(),
        imageBaseUrl = null;

  MovieDetailState copyWith({StateHolder<Map<String, dynamic>>? detail, String? imageBaseUrl}) {
    return MovieDetailState(
      detail: detail ?? this.detail,
      imageBaseUrl: imageBaseUrl ?? this.imageBaseUrl,
    );
  }

  @override
  List<Object?> get props => [detail, imageBaseUrl];
}
