import 'package:flutter_navigator2_sample/storage/shared_preferences_manager.dart';

class FetchImageBaseUrl {
  final SharedPreferencesManager sharedPreferencesManager;

  FetchImageBaseUrl({required this.sharedPreferencesManager});

  String? call() => sharedPreferencesManager.getString('IMAGE_BASE_URL');
}
