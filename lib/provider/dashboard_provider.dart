import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/util/api_calling.dart';

import '../model/location_model.dart';
import '../model/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardProvider extends ChangeNotifier {

  String ipAddress = "";
  String city = '';

  TextEditingController controller = TextEditingController();

  bool isLoaded = false;

  WeatherModel weatherModel = WeatherModel();
  LocationModel locationModel = LocationModel();

  List<WeatherModel> filteredData = [];


  DashboardProvider(){
    fetchIp();
  }

  Future fetchIp() async {
    var res = await ApiCalling.fetchData('https://api.ipify.org/?format=json');
    ipAddress = res['ip'];
    notifyListeners();
    fetchCity();
  }
  
  Future fetchCity() async{
    var res = await ApiCalling.fetchData('https://ipinfo.io/$ipAddress/geo');
    city = res['city'];
    notifyListeners();
    fetchWeatherData();
  }

  Future fetchWeatherData() async{
    var res = await ApiCalling.fetchData('http://api.weatherapi.com/v1/current.json?key=a372d3b686be43d48d552834232106&q=$city&aqi=no');
    weatherModel = WeatherModel.fromJson(res['current']);
    locationModel = LocationModel.fromJson(res['location']);
    notifyListeners();
    print(res);
    isLoaded = true;
    notifyListeners();
    saveDataToSP();
  }

  Future saveDataToSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonData = json.encode(weatherModel.toJson());
    await sharedPreferences.setString(
        'weatherData', jsonData);
  }

  Future getWeatherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('weatherData');
    if (jsonData != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonData);
      weatherModel = WeatherModel.fromJson(jsonMap);
    }
  }


  void filterData(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('weatherData');

    if (jsonData != null) {
      WeatherModel weatherModel = WeatherModel.fromJson(json.decode(jsonData));

      filteredData.clear();
      }
    }
  }




