import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/navigation/router_delegate/app_router_delegate.dart';
import 'package:flutter_navigator2_sample/network/http_handler.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_event.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_state.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';
import 'package:flutter_navigator2_sample/storage/shared_preferences_manager.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppRouterDelegate router;
  final HttpHandler httpHandler;
  final SharedPreferencesManager sharedPreferencesManager;

  SplashBloc({required this.router, required this.httpHandler, required this.sharedPreferencesManager, required SplashState initialState})
      : super(initialState);

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
      var response = await httpHandler.get('/configuration');
      var jsonResponse = jsonDecode(response.body);
      await sharedPreferencesManager.storeString('IMAGE_BASE_URL', jsonResponse['images']['base_url']);
      yield state.copyWith(configuration: StateHolder.completed(jsonResponse));
    } on Exception catch (exception) {
      yield state.copyWith(configuration: StateHolder.error(failure: exception));
    }
  }

  void _navigateToHomePage() {
    var destination = Uri.parse('/${PageKeys.Home}');
    router.replaceAllPagesWith(destination);
  }
}
