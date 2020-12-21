
 import 'package:api_weather_call/UI/Screens/weather_home_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
 }
 class WeatherIdRequested extends WeatherEvent{
  final String cityname;
  WeatherIdRequested({@required this.cityname}): assert(cityname!=null);
  @override

  List<Object> get props => [cityname];
 }