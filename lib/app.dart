import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/navigation/information/app_route_information_parser.dart';
import 'package:flutter_navigator2_sample/navigation/router_delegate/app_router_delegate.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late var _routerDelegate;
  late var _routeInformationParser;

  @override
  void initState() {
    _routerDelegate = sl<AppRouterDelegate>();
    _routeInformationParser = sl<AppRouteInformationParser>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Moviez',
      debugShowCheckedModeBanner: false,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
