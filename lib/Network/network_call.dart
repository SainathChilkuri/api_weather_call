
import 'package:api_weather_call/Blocs/weather_bloc.dart';
import 'package:api_weather_call/Model/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NetworkCall{
  Dio dio;
  NetworkCall(){
    BaseOptions base  = BaseOptions(
     connectTimeout: 5000,
     receiveTimeout: 3000,
    );
    dio = Dio(base);
  }
  Future<dynamic> getWeatherId(String _cityname)async{
    Dio _dio = await addInterceptors(dio);
    final URL = "https://www.metaweather.com/api/location/search/?query=$_cityname";
    Response response  = await _dio.get(URL);
    if(response.statusCode == 200){
      print("Succesfully fetched data");
      print(response.data);
      print(response.data[0]["woeid"]);
      return response.data[0];
    }else{
      throw Exception("Data Not Found");
    }

  }

  Future<WeatherModel> getWeatherDetails(int _id) async {
    Dio _diocall = await addInterceptors(dio);
    final URL = "https://www.metaweather.com/api/location/$_id";
    Response response = await _diocall.get(URL);
    if(response.statusCode == 200){
      print(response.data);
      return WeatherModel.fromJson(response.data);
    }else{
      throw Exception("Data Not Found");
    }
  }
}

Future<dynamic> addInterceptors(Dio dio) async {
  return dio..interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options) => requestData(options),
    onResponse: (Response response) => responseData(response),
    onError: (DioError error) => errorData(error)
  ));
}

errorData(DioError error) {
if( error == DioErrorType.CONNECT_TIMEOUT){
  throw Exception("No data Found");
}
}

responseData(Response response) {
  if(response.headers != null){
    print("----Response Data-----");
    print(response.headers.toString());
  }
}

requestData(RequestOptions options) {
  print("----Request Data-----");
  print(options.headers);
}