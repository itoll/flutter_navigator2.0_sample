import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/navigation/router_delegate/app_router_delegate.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_event.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_state.dart';
import 'package:flutter_navigator2_sample/presentation/command/fetch_and_store_configuration.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppRouterDelegate router;

  final FetchAndStoreConfiguration fetchAndStoreConfiguration;

  SplashBloc({required this.router, required this.fetchAndStoreConfiguration, required SplashState initialState}) : super(initialState);

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is SplashConfigurationFetched) {
      yield* _mapConfigurationFetchedToState();
    } else if (event is SplashHomePageNavigatedTo) {
      _navigateToHomePage();
    }
  }

  Stream<SplashState> _mapConfigurationFetchedToState() async* {
    try {
      var response = await fetchAndStoreConfiguration();
      var jsonResponse = jsonDecode(response.body);
      yield state.copyWith(configuration: StateHolder.completed(jsonResponse));
    } on Exception catch (exception) {
      yield state.copyWith(configuration: StateHolder.error(failure: exception));
    }
  }

  void _navigateToHomePage() {
    var destination = Uri.parse('/${PageKeys.Home}');
    if (kDebugMode) {
      router.push(destination);
      return;
    }
    router.replaceAllPagesWith(destination);
  }
}
