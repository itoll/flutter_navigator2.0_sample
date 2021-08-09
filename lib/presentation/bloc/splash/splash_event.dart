import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashConfigurationFetched extends SplashEvent {}

class SplashHomePageNavigatedTo extends SplashEvent {}
