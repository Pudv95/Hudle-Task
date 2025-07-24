import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherByCity(String cityName);
  Future<WeatherModel> getWeatherByLocation(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl(this.dio);

  @override
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.weatherEndpoint}',
        queryParameters: {
          'q': cityName,
          'appid': AppConstants.apiKey,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('City not found');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<WeatherModel> getWeatherByLocation(double lat, double lon) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.weatherEndpoint}',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': AppConstants.apiKey,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
