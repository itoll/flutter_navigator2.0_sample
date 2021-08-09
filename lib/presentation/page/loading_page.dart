import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/navigation/custom_page_route.dart';
import 'package:flutter_navigator2_sample/presentation/screen/loading_screen.dart';

class LoadingPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return CustomPageRoute(
      settings: this,
      child: LoadingScreen(),
    ).build();
  }
}
