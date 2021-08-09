import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/navigation/custom_page_route.dart';
import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/presentation/screen/loading_screen.dart';

class LoadingPage extends Page {
  const LoadingPage({LocalKey? key}) : super(key: key, name: PageKeys.Loading);

  @override
  Route createRoute(BuildContext context) {
    return CustomPageRoute(
      settings: this,
      child: LoadingScreen(),
    ).build();
  }
}
