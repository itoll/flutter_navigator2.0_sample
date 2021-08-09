import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          child: Center(
            child: Text('Page Not Found :('),
          ),
        ),
      ),
    );
  }
}
