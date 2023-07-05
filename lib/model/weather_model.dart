import 'package:freezed_annotation/freezed_annotation.dart';
part 'weather_model.freezed.dart';
part 'weather_model.g.dart';


@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    @JsonKey(name: 'temp_c')double? tempC,
    @JsonKey(name: 'temp_f')double? tempF,
    @JsonKey(name: 'wind_kph')double? windKph,
    @JsonKey(name: 'wind_mph')double? windMph,
    @JsonKey(name: 'wind_dir')String? windDirection,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}
