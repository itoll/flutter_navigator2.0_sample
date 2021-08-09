import 'package:equatable/equatable.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';

class SplashState extends Equatable {
  final StateHolder<Map<String, dynamic>>? configuration;

  SplashState({this.configuration});

  SplashState.initial() : configuration = StateHolder.empty();

  SplashState copyWith({StateHolder<Map<String, dynamic>>? configuration}) {
    return SplashState(
      configuration: configuration,
    );
  }

  @override
  List<Object?> get props => [configuration];
}
