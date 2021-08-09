import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/navigation/transition/page_transition_type.dart';

const DEFAULT_TRANSITION_TYPE = PageTransitionType.SlideLeft;

class CustomPageRoute {
  final PageTransitionType transitionType;
  final Curve transitionCurve;
  final Duration transitionDuration;
  final RouteSettings settings;
  final Widget child;

  CustomPageRoute({
    required this.settings,
    required this.child,
    this.transitionType = DEFAULT_TRANSITION_TYPE,
    this.transitionCurve = Curves.easeOut,
    this.transitionDuration = const Duration(seconds: 1),
  });

  Route<dynamic> build() {
    switch (transitionType) {
      case PageTransitionType.ScaleOut:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: transitionDuration,
          reverseTransitionDuration: transitionDuration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var scaleAnimation = Tween(begin: 0.0, end: 0.2).animate(CurvedAnimation(
              curve: transitionCurve,
              reverseCurve: transitionCurve,
              parent: secondaryAnimation,
            ));
            return Transform.scale(
              scale: 1.0 - scaleAnimation.value,
              child: child,
            );
          },
        );
      case PageTransitionType.SlideLeft:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: transitionDuration,
          reverseTransitionDuration: transitionDuration,
          pageBuilder: (context, animation, secondaryAnimation) => Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(-5.0, 0.0),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: child,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FractionalTranslation(
              translation: Offset(
                1.0 -
                    CurvedAnimation(
                      parent: animation,
                      curve: transitionCurve,
                      reverseCurve: transitionCurve,
                    ).value,
                0.0,
              ),
              child: child,
            );
          },
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => child,
        );
    }
  }
}
