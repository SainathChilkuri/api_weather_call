import 'package:api_weather_call/Colors/colors_theme.dart';
import 'package:api_weather_call/Model/weather_model.dart';
import 'package:api_weather_call/UI/Screens/weather_map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class WeatherDetailsSrceen extends StatefulWidget {
  final WeatherModel weather;
  WeatherDetailsSrceen({
    this.weather
   });
  @override
  _WeatherDetailsSrceenState createState() => _WeatherDetailsSrceenState();
}

class _WeatherDetailsSrceenState extends State<WeatherDetailsSrceen> {

  @override
  Widget build(BuildContext context) {
    final _weather = widget.weather;
    return  ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            nameOfWeather(_weather.title, _weather.locationType),
            nameOfCountry(_weather.parent.title),
          ],
        ),
        divider(),
        currentTime(_weather.time.split('T')[0], _weather.time.split('.')[0]),
        divider(),
        timeZone(_weather.timezone),
        displayCard(_weather),
        sunriseTime(_weather.sunRise.split('.')[0]),
        sunsetTime(_weather.sunRise.split('.')[0]),
        divider(),
        displayAdditionalInformation(_weather),
        displayMap(_weather.parent.lattLong.split(',')[0], _weather.parent.lattLong.split(',')[1])
      ]);
  }

  Widget nameOfWeather(String title,String type) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          title + " " + type + ", ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
      ),
    );
  }
  Widget nameOfCountry(String country) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          "Country: $country",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
      ),
    );
  }
  Widget currentTime(String day, String time) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          "Date: ${day} \nTime : ${time.split('T')[1]}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
      ),
    );
  }
  Widget sunriseTime( String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Icon(Icons.wb_sunny),
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              " : ${time.split('T')[1]} AM",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget sunsetTime( String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Icon(Icons.nightlight_round),
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              " : ${time.split('T')[1]} PM",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget timeZone(String zone){
    return Container(
      alignment: Alignment.center,
      child: Text(" Timezone: ${zone}",
      style: TextStyle(
        fontStyle: FontStyle.italic
      ),),
    );
  }
  Widget temperatures(ConsolidatedWeather consolidatedWeather) {
    return Container(
      margin: EdgeInsets.only(top: 10.0,bottom: 20.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.temperatureLow),
          Container(
            margin: EdgeInsets.only(left: 5.0,right: 10.0),
            child: Text(
                " Min: ${consolidatedWeather.minTemp.toStringAsFixed(2)}, "
            ),
          ),
          Icon(FontAwesomeIcons.temperatureHigh),
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text(
                "Max: ${consolidatedWeather.maxTemp.toStringAsFixed(2)}"
            ),

          )
        ],
      ),
    );

  }
  Widget weatherImage(String weatherStateName) {
    switch(weatherStateName){
      case "Clear":
        return Icon(
          FontAwesomeIcons.cloud,size: 100.0,
        );
        break;
      case "Light Cloud":
        return Icon(
          FontAwesomeIcons.cloudSun,size: 100.0,
        );
        break;
      case "Heavy Cloud":
        return Icon(
          FontAwesomeIcons.cloudRain,size: 100.0,
        );
        break;
    }
  }
  Widget displayCard(WeatherModel weather) {

    return Container(
      //color: Colors.greenAccent,
      height: MediaQuery.of(context).size.height/4.5,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: ColorsTheme.primaryColor,
        borderRadius: BorderRadius.circular(9.0),
        //color: ColorsTheme.secondaryColor
      ),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                weatherImage(weather.consolidatedWeather[0].weatherStateName),
                Container(
                  //alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(left: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "${weather.consolidatedWeather[0].weatherStateName}.",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Container(
                              child: Icon(
                                  FontAwesomeIcons.temperatureHigh
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(left: 9.0),
                              child: Text(
                                "${weather.consolidatedWeather[0].theTemp.toStringAsFixed(2)} \u2103",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
                child: temperatures(weather.consolidatedWeather[0])),
          ],
        )

      ),
    );
  }
  Widget divider() {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Divider(thickness: 2.0,color: Colors.blueGrey));
  }
  Widget displayAdditionalInformation(WeatherModel weather) {
    return Container(
      margin: EdgeInsets.only(left: 15.0,right: 15.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  showwind(weather),
                  showHumidity(weather)
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  airpressue(weather),
                  predictibility(weather)
                ],
                ),
              )
            ],
          ),
        ),
      ),
    );


}
  Widget showwind(WeatherModel weather) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(
            FontAwesomeIcons.wind
          ),
        ),
        Text(
          "${weather.consolidatedWeather[0].windSpeed.toStringAsFixed(2)} mph"
        )
      ],
    );
  }
  Widget showHumidity(WeatherModel weather) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(
              Icons.wb_sunny_outlined
          ),
        ),
        Text(
            "${weather.consolidatedWeather[0].humidity} %"
        )
      ],
    );
  }
  Widget airpressue(WeatherModel weather) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Text(
            "Pressure: "
          ),
        ),
        Text(
            "${weather.consolidatedWeather[0].airPressure} mb"
        )
      ],
    );
  }
  Widget predictibility(WeatherModel weather) {
   return Row(
     children: [
       Container(
         margin: EdgeInsets.only(right: 5.0),
         child: Text(
           "Predictibility: "
         )
       ),
       Text(
           "${weather.consolidatedWeather[0].predictability} mI"
       )
     ],
   );
 }

  displayMap(String lat , String long) {
    return FlatButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return GoogleMapScreen(lat: lat,long: long);
          }));
        },
        child: Text("Show Maps"));
  }
}
