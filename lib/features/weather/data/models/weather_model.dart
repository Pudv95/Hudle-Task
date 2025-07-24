import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.description,
    required super.icon,
    required super.humidity,
    required super.windSpeed,
    required super.timestamp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? '',
      temperature: (json['main']?['temp'] ?? 0.0).toDouble(),
      description: json['weather']?[0]?['description'] ?? '',
      icon: json['weather']?[0]?['icon'] ?? '',
      humidity: json['main']?['humidity'] ?? 0,
      windSpeed: (json['wind']?['speed'] ?? 0.0).toDouble(),
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {'temp': temperature, 'humidity': humidity},
      'weather': [
        {'description': description, 'icon': icon},
      ],
      'wind': {'speed': windSpeed},
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory WeatherModel.fromCache(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['cityName'] ?? '',
      temperature: (json['temperature'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      humidity: json['humidity'] ?? 0,
      windSpeed: (json['windSpeed'] ?? 0.0).toDouble(),
      timestamp: DateTime.parse(
        json['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toCache() {
    return {
      'cityName': cityName,
      'temperature': temperature,
      'description': description,
      'icon': icon,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
