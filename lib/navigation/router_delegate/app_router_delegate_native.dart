import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/navigation/extension/uri_extensions.dart';
import 'package:flutter_navigator2_sample/navigation/navigator_key.dart';
import 'package:flutter_navigator2_sample/navigation/page_keys.dart';
import 'package:flutter_navigator2_sample/navigation/page_stack.dart';
import 'package:flutter_navigator2_sample/navigation/route_path.dart';
import 'package:flutter_navigator2_sample/navigation/router_delegate/routes.dart';
import 'package:flutter_navigator2_sample/navigation/type_aliases.dart';
import 'package:flutter_navigator2_sample/presentation/page/not_found_page.dart';
import 'package:flutter_navigator2_sample/presentation/page/splash_page.dart';

import 'app_router_delegate.dart';

AppRouterDelegate getDelegate() => AppRouterDelegateNative(pageStack: sl<PageStack>(), routeMap: routes);

class AppRouterDelegateNative extends AppRouterDelegate<Uri> {
  final PageStack pageStack;

  final Map<String, PageBuilder> routeMap;

  AppRouterDelegateNative({
    required this.pageStack,
    required this.routeMap,
  }) {
    pageStack.addListener(_stateListener);
  }

  /// This will create a Navigator with:
  ///  - pages as a list of [Page]s
  ///  - onPopPage as a callback to handle [Navigator.of(context).pop()]
  ///  - transitionDelegate as a delegate to handle priorities of changing pages
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorGlobalKey,
      pages: pageStack.pages,
      onPopPage: _onPopPage,
      transitionDelegate: DefaultTransitionDelegate(),
    );
  }

  @override
  void push(Uri input) {
    var pageFound = false;

    routeMap.keys.forEachIndexed((index, key) {
      var uri = Uri.parse(key);
      if (input.formatIsEqualTo(uri)) {
        pageFound = true;
        var routePath = RoutePath(routeTemplate: uri, route: input);
        var pageBuilder = routeMap.values.elementAt(index);
        var page = pageBuilder(routePath);
        _pushPage(page);
      }
    });

    if (!pageFound) {
      // push not found page if there is no match between routeMap keys and input
      _pushPage(NotFoundPage());
    }

    return;
  }

  @override
  void pushBefore(Uri input, String pageKey) {
    routeMap.keys.forEachIndexed((index, key) {
      var uri = Uri.parse(key);
      if (input.formatIsEqualTo(uri)) {
        var routePath = RoutePath(routeTemplate: uri, route: input);
        var pageBuilder = routeMap.values.elementAt(index);
        var page = pageBuilder(routePath);
        _pushBeforePage(page, pageKey);
      }
    });
    return;
  }

  @override
  void replaceAllPagesWith(Uri input) {
    var pageFound = false;

    routeMap.keys.forEachIndexed((index, key) {
      var uri = Uri.parse(key);
      if (input.formatIsEqualTo(uri)) {
        pageFound = true;
        var routePath = RoutePath(routeTemplate: uri, route: input);
        var pageBuilder = routeMap.values.elementAt(index);
        var page = pageBuilder(routePath);
        _replaceAllPagesWith(page);
      }
    });

    if (!pageFound) {
      // push not found page if there is no match between routeMap keys and input
      _pushPage(NotFoundPage());
    }

    return;
  }

  void _pushPage(Page page) {
    pageStack.push(page);
  }

  void _pushBeforePage(Page page, String pageKey) {
    pageStack.pushBeforePage(page, pageKey);
  }

  void _replaceAllPagesWith(Page page) {
    pageStack.replaceAllPagesWith(page);
  }

  /// This is an api used by ui layer to pop current page.
  /// We transferred the logic to delegate so that there is
  /// a single source of truth for pop action
  @override
  void pop([var result]) {
    var currentContext = navigatorKey.currentContext;
    if (currentContext != null) {
      Navigator.of(currentContext).pop(result);
    }
    return;
  }

  /// This method is called after [popRoute]
  ///
  /// [route] parameter is the one found in pages and is going to be removed
  /// [result] parameter is the value route popped
  ///
  /// This callback is responsible for calling [Route.didPop] and returning
  /// whether this pop is successful. By returning false, it prevents navigator
  /// from rebuilding so that the page user is currently in wouldnt rebuild
  bool _onPopPage(Route<dynamic> route, dynamic result) {
    var didPop = route.didPop(result);

    if (didPop) {
      return tryGoBack();
    }

    return false;
  }

  /// This request comes from OS through [BackButtonDispatcher]
  /// If returns false, the entire app will be popped, else
  /// it will pop the last page
  @override
  Future<bool> popRoute() async => tryGoBack();

  /// This method is called either by back button press
  /// or when [Navigator.of(context).pop()] is called.
  /// This will handle back navigation by changing [NavigationState]
  /// By returning false, whole application will be closed and by returning
  /// true only our local navigator changes will be applied
  bool tryGoBack() {
    var lastPageName = pageStack.last.name;
    switch (lastPageName) {
      case PageKeys.Splash:
        return false;
      case PageKeys.Home:
        return false;
      case PageKeys.MovieDetail:
        pageStack.popLastPage();
        return true;
      default:
        pageStack.popLastPage();
        return true;
    }
  }

  /// Called by the [Router] when the [Router.routeInformationProvider] reports that a
  /// new route has been pushed to the application by the operating system.
  ///
  /// Consider using a [SynchronousFuture] if the result can be computed
  /// synchronously, so that the [Router] does not need to wait for the next
  /// micro-task to schedule a build.
  @override
  Future<void> setNewRoutePath(Uri uri) async {
    if (uri.toString() == '/') {
      push(Uri.parse('/${PageKeys.Splash}'));
      return SynchronousFuture(null);
    } else {
      if (pageStack.isEmpty) {
        // Application has been in terminated status, so we need to
        // push splash page with a callback to navigate to next destination
        _pushPage(SplashPage());
      } else {
        // Application has been in background status, so we need to clear
        // all current pages, push splash page and navigate to next page using
        // a callback passed to [SplashPage]
        _replaceAllPagesWith(SplashPage());
      }
    }
    return SynchronousFuture(null);
  }

  /// Called by the [Router] when it detects a route information may have
  /// changed as a result of rebuild.
  ///
  /// If this getter returns non-null, the [Router] will start to report new
  /// route information back to the engine. In web applications, the new
  /// route information is used for populating browser history in order to
  /// support the forward and the backward buttons.
  ///
  /// When overriding this method, the configuration returned by this getter
  /// must be able to construct the current app state and build the widget
  /// with the same configuration in the [build] method if it is passed back
  /// to the the [setNewRoutePath]. Otherwise, the browser backward and forward
  /// buttons will not work properly.
  ///
  /// By default, this getter returns null, which prevents the [Router] from
  /// reporting the route information. To opt in, a subclass can override this
  /// getter to return the current configuration.
  ///
  /// At most one [Router] can opt in to route information reporting. Typically,
  /// only the top-most [Router] created by [WidgetsApp.router] should opt for
  /// route information reporting.
  @override
  Uri get currentConfiguration => Uri.parse(pageStack.last.name ?? PageKeys.Splash);

  /// The key used for retrieving the current navigator.
  @override
  GlobalKey<NavigatorState> get navigatorKey => navigatorGlobalKey;

  void _stateListener() {
    notifyListeners();
  }

  @override
  void dispose() {
    pageStack.removeListener(_stateListener);
    super.dispose();
  }
}
