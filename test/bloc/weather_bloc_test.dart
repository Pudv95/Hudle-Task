import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:hudle_task/features/weather/domain/usecases/get_weather_by_city.dart';
import 'package:hudle_task/features/weather/domain/usecases/get_weather_by_location.dart';
import 'package:hudle_task/features/weather/domain/usecases/get_cached_weather.dart';
import 'package:hudle_task/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:hudle_task/features/weather/presentation/bloc/weather_state.dart';

// Mock classes
class MockGetWeatherByCity extends Mock implements GetWeatherByCity {}

class MockGetWeatherByLocation extends Mock implements GetWeatherByLocation {}

class MockGetCachedWeather extends Mock implements GetCachedWeather {}

void main() {
  group('WeatherBloc', () {
    late MockGetWeatherByCity mockGetWeatherByCity;
    late MockGetWeatherByLocation mockGetWeatherByLocation;
    late MockGetCachedWeather mockGetCachedWeather;
    late WeatherBloc weatherBloc;

    setUp(() {
      mockGetWeatherByCity = MockGetWeatherByCity();
      mockGetWeatherByLocation = MockGetWeatherByLocation();
      mockGetCachedWeather = MockGetCachedWeather();
      weatherBloc = WeatherBloc(
        getWeatherByCity: mockGetWeatherByCity,
        getWeatherByLocation: mockGetWeatherByLocation,
        getCachedWeather: mockGetCachedWeather,
      );
    });

    tearDown(() {
      weatherBloc.close();
    });

    test('initial state should be WeatherInitial', () {
      expect(weatherBloc.state, isA<WeatherInitial>());
    });

    test('should create WeatherBloc with required dependencies', () {
      final bloc = WeatherBloc(
        getWeatherByCity: mockGetWeatherByCity,
        getWeatherByLocation: mockGetWeatherByLocation,
        getCachedWeather: mockGetCachedWeather,
      );

      expect(bloc, isA<WeatherBloc>());
      expect(bloc.state, isA<WeatherInitial>());

      bloc.close();
    });
  });
}
