import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherByCity extends WeatherEvent {
  final String cityName;

  const FetchWeatherByCity(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class FetchWeatherByLocation extends WeatherEvent {
  const FetchWeatherByLocation();
}

class LoadCachedWeather extends WeatherEvent {
  const LoadCachedWeather();
}

class RefreshWeather extends WeatherEvent {
  const RefreshWeather();
}
