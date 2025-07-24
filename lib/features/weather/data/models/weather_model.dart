import 'dart:developer';

import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.cityName,
    required super.country,
    required super.temperature,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.description,
    required super.icon,
    required super.humidity,
    required super.windSpeed,
    required super.windDirection,
    required super.pressure,
    required super.visibility,
    required super.uvIndex,
    required super.timestamp,
    required super.sunrise,
    required super.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    final main = json['main'] ?? {};
    final weather = json['weather']?[0] ?? {};
    final wind = json['wind'] ?? {};
    final sys = json['sys'] ?? {};

    return WeatherModel(
      cityName: json['name'] ?? '',
      country: sys['country'] ?? '',
      temperature: (main['temp'] ?? 0.0).toDouble(),
      feelsLike: (main['feels_like'] ?? 0.0).toDouble(),
      tempMin: (main['temp_min'] ?? 0.0).toDouble(),
      tempMax: (main['temp_max'] ?? 0.0).toDouble(),
      description: weather['description'] ?? '',
      icon: weather['icon'] ?? '',
      humidity: main['humidity'] ?? 0,
      windSpeed: (wind['speed'] ?? 0.0).toDouble(),
      windDirection: wind['deg'] ?? 0,
      pressure: (main['pressure'] ?? 0.0).toDouble(),
      visibility: json['visibility'] ?? 0,
      uvIndex: 0.0, // OpenWeatherMap doesn't provide UV index in basic API
      timestamp: DateTime.now(),
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        (sys['sunrise'] ?? 0) * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch((sys['sunset'] ?? 0) * 1000),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'sys': {
        'country': country,
        'sunrise': sunrise.millisecondsSinceEpoch ~/ 1000,
        'sunset': sunset.millisecondsSinceEpoch ~/ 1000,
      },
      'main': {
        'temp': temperature,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'humidity': humidity,
        'pressure': pressure,
      },
      'weather': [
        {'description': description, 'icon': icon},
      ],
      'wind': {'speed': windSpeed, 'deg': windDirection},
      'visibility': visibility,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory WeatherModel.fromCache(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['cityName'] ?? '',
      country: json['country'] ?? '',
      temperature: (json['temperature'] ?? 0.0).toDouble(),
      feelsLike: (json['feelsLike'] ?? 0.0).toDouble(),
      tempMin: (json['tempMin'] ?? 0.0).toDouble(),
      tempMax: (json['tempMax'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      humidity: json['humidity'] ?? 0,
      windSpeed: (json['windSpeed'] ?? 0.0).toDouble(),
      windDirection: json['windDirection'] ?? 0,
      pressure: (json['pressure'] ?? 0.0).toDouble(),
      visibility: json['visibility'] ?? 0,
      uvIndex: (json['uvIndex'] ?? 0.0).toDouble(),
      timestamp: DateTime.parse(
        json['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
      sunrise: DateTime.parse(
        json['sunrise'] ?? DateTime.now().toIso8601String(),
      ),
      sunset: DateTime.parse(
        json['sunset'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toCache() {
    return {
      'cityName': cityName,
      'country': country,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'description': description,
      'icon': icon,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'windDirection': windDirection,
      'pressure': pressure,
      'visibility': visibility,
      'uvIndex': uvIndex,
      'timestamp': timestamp.toIso8601String(),
      'sunrise': sunrise.toIso8601String(),
      'sunset': sunset.toIso8601String(),
    };
  }
}
