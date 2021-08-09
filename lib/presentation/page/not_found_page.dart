import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/navigation/custom_page_route.dart';
import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/presentation/screen/not_found_screen.dart';

class NotFoundPage extends Page {
  const NotFoundPage({LocalKey? key}) : super(key: key, name: PageKeys.Home);

  @override
  Route createRoute(BuildContext context) {
    return CustomPageRoute(
      settings: this,
      child: NotFoundScreen(),
    ).build();
  }
}
