import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/navigation/custom_page_route.dart';
import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/home/home_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/screen/home_screen.dart';

class HomePage extends Page {
  const HomePage({LocalKey? key}) : super(key: key, name: PageKeys.Home);

  @override
  Route createRoute(BuildContext context) {
    return CustomPageRoute(
      settings: this,
      child: BlocProvider<HomeBloc>(
        create: (context) => sl<HomeBloc>(),
        child: HomeScreen(),
      ),
    ).build();
  }
}
