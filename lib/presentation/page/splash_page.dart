import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/navigation/custom_page_route.dart';
import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/navigation/transition/page_transition_type.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/screen/splash_screen.dart';

class SplashPage extends Page {
  const SplashPage({LocalKey? key}) : super(key: key, name: PageKeys.Home);

  @override
  Route createRoute(BuildContext context) {
    return CustomPageRoute(
      settings: this,
      transitionType: PageTransitionType.ScaleOut,
      child: BlocProvider<SplashBloc>(
        create: (context) => sl<SplashBloc>(),
        child: SplashScreen(),
      ),
    ).build();
  }
}
