import 'package:api_weather_call/Blocs/weather_bloc.dart';
import 'package:api_weather_call/Colors/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/Screens/weather_home_screen.dart';

void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  ThemeData base = ThemeData.dark();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: MaterialApp(
        theme: _appTheme(base),
        debugShowCheckedModeBanner: false,
        home: WeatherScreen(),
      ),
    );
  }

  ThemeData _appTheme(ThemeData base) {
    return base.copyWith(
      primaryColor: ColorsTheme.primaryColor,
      secondaryHeaderColor: ColorsTheme.secondaryColor

    );
  }
}
