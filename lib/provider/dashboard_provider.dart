import 'package:flutter/material.dart';
import 'package:weather/util/api_calling.dart';

class DashboardProvider extends ChangeNotifier {

  String ipAddress = "";
  String city = '';
  double temp = 0;
  bool isLoaded = false;

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
    temp = res['current']['temp_c'];
    notifyListeners();
    isLoaded = true;
    notifyListeners();

  }

}
