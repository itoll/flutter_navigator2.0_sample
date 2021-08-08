import 'package:flutter/cupertino.dart';

import 'app_router_delegate_stub.dart' if (dart.library.io) 'app_router_delegate_native.dart' if (dart.library.js) 'app_router_delegate_web.dart';

abstract class AppRouterDelegate<T> extends RouterDelegate<T> with PopNavigatorRouterDelegateMixin, ChangeNotifier {
  static AppRouterDelegate? _instance;

  static AppRouterDelegate get instance {
    _instance ??= getDelegate();
    return _instance!;
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  void openWebPageOnCurrentTab(String url) {
    throw UnimplementedError();
  }

  void push(Uri input) {
    throw UnimplementedError();
  }

  void pushBefore(Uri input, String pageKey) {
    throw UnimplementedError();
  }

  void pop([var result]) {
    throw UnimplementedError();
  }

  void replaceAllPagesWith(Uri input) {
    throw UnimplementedError();
  }
}
