 import 'package:api_weather_call/Model/weather_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherState extends Equatable{
  const WeatherState(): super();
}
class InitialState extends WeatherState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class WeatherLoading extends WeatherState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class WeatherLoadedSuccess extends WeatherState{
  final WeatherModel weather;
  WeatherLoadedSuccess({@required this.weather}): assert(weather!=null);
  @override
  // TODO: implement props
  List<Object> get props => [weather];
}
class WeatherError extends WeatherState{
  final error;
  WeatherError({@required this.error}): assert(error!=null);
  @override
  List<Object> get props => [error];

}