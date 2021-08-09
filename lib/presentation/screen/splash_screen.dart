import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_bloc.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_event.dart';
import 'package:flutter_navigator2_sample/presentation/bloc/splash/splash_state.dart';
import 'package:flutter_navigator2_sample/presentation/state_holder.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // BlocProvider.of<SplashBloc>(context).add(SplashConfigurationFetched());
    super.initState();
  }

  bool _splashBlocListenWhen(SplashState pState, SplashState cState) {
    if (pState.configuration?.status != Status.COMPLETED && cState.configuration?.status == Status.COMPLETED) return true;
    return false;
  }

  void _splashBlocListener(BuildContext context, SplashState state) {
    if (state.configuration?.status == Status.COMPLETED) {
      BlocProvider.of<SplashBloc>(context).add(SplashHomePageNavigatedTo());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: null,
        body: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              'Moviez',
              style: GoogleFonts.blackOpsOne().copyWith(
                color: Colors.white,
                fontSize: 48.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
