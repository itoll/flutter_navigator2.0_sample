class RoutePath {
  /// e.g: /home/:carId/:fragment/:filterTypes
  final Uri routeTemplate;

  /// e.g: /home/12/Debts/FREEWAY,TEHRAN
  final Uri route;

  String? getParameter(String tag) {
    var index = routeTemplate.pathSegments.indexWhere((element) => element == ':$tag');

    if (index > route.pathSegments.length - 1) {
      return null;
    }

    return route.pathSegments.elementAt(index);
  }

  RoutePath({
    required this.routeTemplate,
    required this.route,
  });
}
