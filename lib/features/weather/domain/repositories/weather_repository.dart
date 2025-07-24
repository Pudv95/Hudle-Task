import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeatherByCity(String cityName);
  Future<Either<Failure, Weather>> getWeatherByLocation(double lat, double lon);
  Future<Either<Failure, Weather?>> getCachedWeather();
  Future<Either<Failure, void>> cacheWeather(Weather weather);
  Future<Either<Failure, List<String>>> getSearchHistory();
  Future<Either<Failure, void>> addToSearchHistory(String cityName);
}
