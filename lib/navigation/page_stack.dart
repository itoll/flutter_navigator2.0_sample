import 'package:flutter/material.dart';

class PageStack extends ChangeNotifier {
  List<Page> _pages;

  PageStack.initial() : _pages = List<Page>.empty(growable: true);

  List<Page> get pages => <Page>[..._pages];

  RouteSettings get last => _pages.last;

  bool get isEmpty => _pages.isEmpty;

  void push(Page page) {
    _pages.add(page);
    notifyListeners();
  }

  void pushBeforePage(Page page, String pageKey) {
    var index = _pages.indexWhere((element) => element.name == pageKey);
    _pages = <Page>[
      ..._pages.sublist(0, index),
      page,
      ..._pages.sublist(index + 1),
    ];
    notifyListeners();
  }

  void popLastPage() {
    _pages.removeLast();
    notifyListeners();
  }

  void popPageByKey(String key) {
    _pages.removeWhere((element) => element.name == key);
    notifyListeners();
  }

  void replaceAllPagesWith(Page page) {
    _pages = <Page>[page];
    notifyListeners();
  }

  void notify([VoidCallback? action]) {
    action?.call();
    notifyListeners();
  }
}
