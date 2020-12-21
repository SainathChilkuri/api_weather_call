import 'package:api_weather_call/Blocs/weather_event.dart';
import 'package:api_weather_call/Blocs/weather_state.dart';
import 'package:api_weather_call/Model/weather_model.dart';
import 'package:api_weather_call/Network/network_call.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
  WeatherBloc() : super(InitialState());


  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
   if(event is WeatherIdRequested){
     yield WeatherLoading();
     print("---------------");
     var data;
     try{
       data = await NetworkCall().getWeatherId(event.cityname);
       int id = data["woeid"];
       var latlon = data["latt_long"];
       if(id !=null && latlon!=null) {
         print(data);
         //print(NetworkCall().getWeatherDetails(id));
         var details = await NetworkCall().getWeatherDetails(id);
         print("--------------");
         print(details.time);
         try {
           yield WeatherLoadedSuccess(weather: details);
         }catch(e) {
           yield WeatherError(error: "Invalid City Name");
         }
       }
     }catch(e){
       yield WeatherError(error: "City Not Found");
     }
     }
  }
}