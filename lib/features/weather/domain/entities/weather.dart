import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final DateTime timestamp;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
    cityName,
    temperature,
    description,
    icon,
    humidity,
    windSpeed,
    timestamp,
  ];

  Weather copyWith({
    String? cityName,
    double? temperature,
    String? description,
    String? icon,
    int? humidity,
    double? windSpeed,
    DateTime? timestamp,
  }) {
    return Weather(
      cityName: cityName ?? this.cityName,
      temperature: temperature ?? this.temperature,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
