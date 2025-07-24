import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final double pressure;
  final int visibility;
  final double uvIndex;
  final DateTime timestamp;
  final DateTime sunrise;
  final DateTime sunset;

  const Weather({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
    required this.visibility,
    required this.uvIndex,
    required this.timestamp,
    required this.sunrise,
    required this.sunset,
  });

  @override
  List<Object?> get props => [
    cityName,
    country,
    temperature,
    feelsLike,
    tempMin,
    tempMax,
    description,
    icon,
    humidity,
    windSpeed,
    windDirection,
    pressure,
    visibility,
    uvIndex,
    timestamp,
    sunrise,
    sunset,
  ];

  Weather copyWith({
    String? cityName,
    String? country,
    double? temperature,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    String? description,
    String? icon,
    int? humidity,
    double? windSpeed,
    int? windDirection,
    double? pressure,
    int? visibility,
    double? uvIndex,
    DateTime? timestamp,
    DateTime? sunrise,
    DateTime? sunset,
  }) {
    return Weather(
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
      temperature: temperature ?? this.temperature,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      pressure: pressure ?? this.pressure,
      visibility: visibility ?? this.visibility,
      uvIndex: uvIndex ?? this.uvIndex,
      timestamp: timestamp ?? this.timestamp,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }
}
