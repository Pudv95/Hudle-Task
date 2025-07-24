import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_data_source.dart';
import '../models/weather_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getWeatherByCity(String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherModel = await remoteDataSource.getWeatherByCity(cityName);
        await localDataSource.cacheWeather(weatherModel);
        await localDataSource.addToSearchHistory(cityName);
        return Right(weatherModel);
      } catch (e) {
        if (e.toString().contains('City not found')) {
          return const Left(
            ServerFailure('City not found. Please check the spelling.'),
          );
        } else if (e.toString().contains('Connection timeout')) {
          return const Left(
            NetworkFailure('Connection timeout. Please try again.'),
          );
        } else {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      return const Left(NetworkFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, Weather>> getWeatherByLocation(
    double lat,
    double lon,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherModel = await remoteDataSource.getWeatherByLocation(
          lat,
          lon,
        );
        await localDataSource.cacheWeather(weatherModel);
        return Right(weatherModel);
      } catch (e) {
        if (e.toString().contains('Connection timeout')) {
          return const Left(
            NetworkFailure('Connection timeout. Please try again.'),
          );
        } else {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      return const Left(NetworkFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, Weather?>> getCachedWeather() async {
    try {
      final weatherModel = await localDataSource.getCachedWeather();
      return Right(weatherModel);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheWeather(Weather weather) async {
    try {
      final weatherModel = WeatherModel(
        cityName: weather.cityName,
        temperature: weather.temperature,
        description: weather.description,
        icon: weather.icon,
        humidity: weather.humidity,
        windSpeed: weather.windSpeed,
        timestamp: weather.timestamp,
      );
      await localDataSource.cacheWeather(weatherModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getSearchHistory() async {
    try {
      final history = await localDataSource.getSearchHistory();
      return Right(history);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToSearchHistory(String cityName) async {
    try {
      await localDataSource.addToSearchHistory(cityName);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
