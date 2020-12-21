import 'package:api_weather_call/Blocs/weather_bloc.dart';
import 'package:api_weather_call/Blocs/weather_event.dart';
import 'package:api_weather_call/Blocs/weather_state.dart';
import 'package:api_weather_call/Network/network_call.dart';
import 'package:api_weather_call/UI/Screens/weather_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Vatavaran"),
        centerTitle: true,
      ),*/
        body: SingleChildScrollView(
            child: Column(
             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              SafeArea(
                child: Container(
                  padding: EdgeInsets.all(9.0),
                  margin: EdgeInsets.all(5.0),
                  child: TextField(
                    onSubmitted: (value){
                        BlocProvider.of<WeatherBloc>(context).add(WeatherIdRequested(cityname: value));
                    },
                   decoration: InputDecoration(
                     prefixIcon: Icon(Icons.search),
                     labelText: "Enter City Name",
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5.0)
                     )
                   ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: BlocBuilder<WeatherBloc,WeatherState>(
                  buildWhen: (previousstate,currentState){
                    return previousstate == currentState ? false : true;
                  },
                  builder: (_context,state){
                    if( state is InitialState) {
                      return initialWidget();
                    }
                    if( state is WeatherLoading){
                      return  Center(child: CircularProgressIndicator());
                    }
                    if(state is WeatherLoadedSuccess){
                      return WeatherDetailsSrceen(weather: state.weather);
                      /*Center(
                        child: Text(
                          "City Id is ${state.weather.time}\n Longitude and Latitude is ${state.weather.title}"
                        ),
                      );*/
                    }
                    if(state is WeatherError){
                      return  Center(child: Text("${state.error.toString()}"));
                    }
                  }
                ),
              ),
            ])
          ),

    );


  }

  Widget initialWidget() {
    return  Container(
    alignment: Alignment.bottomCenter,
    child: Center(child: Text("Let's Search the weather of cities")));

  }
}
