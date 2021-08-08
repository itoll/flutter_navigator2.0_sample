import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AppRouteInformationParser extends RouteInformationParser<Uri> {
  @override
  SynchronousFuture<Uri> parseRouteInformation(RouteInformation routeInformation) {
    var location = Uri.parse(routeInformation.location ?? '/');
    return SynchronousFuture(location);
  }

  @override
  RouteInformation restoreRouteInformation(Uri uri) {
    return RouteInformation(location: uri.toString());
  }
}
