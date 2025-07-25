import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';

import 'package:hudle_task/features/weather/domain/entities/weather.dart';
import 'package:hudle_task/core/errors/failures.dart';

void main() {
  group('Weather Integration Tests', () {
    group('Weather Entity Integration', () {
      test(
        'should create weather with all properties and support equality',
        () {
          // Arrange
          final timestamp = DateTime.now();
          final sunrise = DateTime.now().add(const Duration(hours: 6));
          final sunset = DateTime.now().add(const Duration(hours: 18));

          final weather1 = Weather(
            cityName: 'London',
            country: 'GB',
            temperature: 20.0,
            feelsLike: 22.0,
            tempMin: 18.0,
            tempMax: 25.0,
            description: 'clear sky',
            icon: '01d',
            humidity: 65,
            windSpeed: 5.2,
            windDirection: 180,
            pressure: 1013.0,
            visibility: 10000,
            uvIndex: 5.0,
            timestamp: timestamp,
            sunrise: sunrise,
            sunset: sunset,
          );

          final weather2 = Weather(
            cityName: 'London',
            country: 'GB',
            temperature: 20.0,
            feelsLike: 22.0,
            tempMin: 18.0,
            tempMax: 25.0,
            description: 'clear sky',
            icon: '01d',
            humidity: 65,
            windSpeed: 5.2,
            windDirection: 180,
            pressure: 1013.0,
            visibility: 10000,
            uvIndex: 5.0,
            timestamp: timestamp,
            sunrise: sunrise,
            sunset: sunset,
          );

          // Act & Assert
          expect(weather1, equals(weather2));
          expect(weather1.hashCode, equals(weather2.hashCode));
          expect(weather1, isA<Equatable>());
        },
      );

      test('should handle different weather conditions', () {
        // Arrange
        final clearWeather = Weather(
          cityName: 'London',
          country: 'GB',
          temperature: 20.0,
          feelsLike: 22.0,
          tempMin: 18.0,
          tempMax: 25.0,
          description: 'clear sky',
          icon: '01d',
          humidity: 65,
          windSpeed: 5.2,
          windDirection: 180,
          pressure: 1013.0,
          visibility: 10000,
          uvIndex: 5.0,
          timestamp: DateTime.now(),
          sunrise: DateTime.now(),
          sunset: DateTime.now(),
        );

        final rainyWeather = Weather(
          cityName: 'London',
          country: 'GB',
          temperature: 15.0,
          feelsLike: 13.0,
          tempMin: 12.0,
          tempMax: 18.0,
          description: 'rain',
          icon: '10d',
          humidity: 85,
          windSpeed: 8.5,
          windDirection: 270,
          pressure: 1005.0,
          visibility: 5000,
          uvIndex: 2.0,
          timestamp: DateTime.now(),
          sunrise: DateTime.now(),
          sunset: DateTime.now(),
        );

        // Act & Assert
        expect(clearWeather.description, equals('clear sky'));
        expect(rainyWeather.description, equals('rain'));
        expect(
          clearWeather.temperature,
          isNot(equals(rainyWeather.temperature)),
        );
        expect(clearWeather.humidity, lessThan(rainyWeather.humidity));
      });
    });

    group('Failure Integration', () {
      test('should handle different failure types correctly', () {
        // Arrange
        const serverFailure = ServerFailure('Server error');
        const cacheFailure = CacheFailure('Cache error');
        const locationFailure = LocationFailure('Location error');
        const networkFailure = NetworkFailure('Network error');

        // Act & Assert
        expect(serverFailure.message, equals('Server error'));
        expect(cacheFailure.message, equals('Cache error'));
        expect(locationFailure.message, equals('Location error'));
        expect(networkFailure.message, equals('Network error'));

        expect(serverFailure, isA<Equatable>());
        expect(cacheFailure, isA<Equatable>());
        expect(locationFailure, isA<Equatable>());
        expect(networkFailure, isA<Equatable>());
      });

      test('should support failure equality and comparison', () {
        // Arrange
        const failure1 = ServerFailure('Same error message');
        const failure2 = ServerFailure('Same error message');
        const failure3 = ServerFailure('Different error message');

        // Act & Assert
        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
        expect(failure1, isNot(equals(failure3)));
        expect(failure1.hashCode, isNot(equals(failure3.hashCode)));
      });
    });

    group('Weather Data Validation', () {
      test('should validate weather data ranges', () {
        // Arrange
        final validWeather = Weather(
          cityName: 'London',
          country: 'GB',
          temperature: 20.0,
          feelsLike: 22.0,
          tempMin: 18.0,
          tempMax: 25.0,
          description: 'clear sky',
          icon: '01d',
          humidity: 65,
          windSpeed: 5.2,
          windDirection: 180,
          pressure: 1013.0,
          visibility: 10000,
          uvIndex: 5.0,
          timestamp: DateTime.now(),
          sunrise: DateTime.now(),
          sunset: DateTime.now(),
        );

        // Act & Assert
        expect(validWeather.temperature, isA<double>());
        expect(validWeather.humidity, isA<int>());
        expect(validWeather.humidity, greaterThanOrEqualTo(0));
        expect(validWeather.humidity, lessThanOrEqualTo(100));
        expect(validWeather.windSpeed, greaterThanOrEqualTo(0));
        expect(validWeather.pressure, greaterThan(0));
        expect(validWeather.visibility, greaterThanOrEqualTo(0));
        expect(validWeather.uvIndex, greaterThanOrEqualTo(0));
        expect(validWeather.cityName, isNotEmpty);
        expect(validWeather.country, isNotEmpty);
        expect(validWeather.description, isNotEmpty);
        expect(validWeather.icon, isNotEmpty);
      });

      test('should handle extreme weather conditions', () {
        // Arrange
        final extremeWeather = Weather(
          cityName: 'Antarctica',
          country: 'AQ',
          temperature: -40.0,
          feelsLike: -50.0,
          tempMin: -45.0,
          tempMax: -35.0,
          description: 'blizzard',
          icon: '13d',
          humidity: 95,
          windSpeed: 25.0,
          windDirection: 0,
          pressure: 950.0,
          visibility: 100,
          uvIndex: 0.0,
          timestamp: DateTime.now(),
          sunrise: DateTime.now(),
          sunset: DateTime.now(),
        );

        // Act & Assert
        expect(extremeWeather.temperature, lessThan(0));
        expect(extremeWeather.humidity, greaterThan(90));
        expect(extremeWeather.windSpeed, greaterThan(20));
        expect(extremeWeather.visibility, lessThan(1000));
        expect(extremeWeather.uvIndex, equals(0.0));
      });
    });

    group('Weather Icon Mapping', () {
      test('should have valid weather icon codes', () {
        // Arrange
        final weatherIcons = [
          '01d', '01n', // clear sky
          '02d', '02n', // few clouds
          '03d', '03n', // scattered clouds
          '04d', '04n', // broken clouds
          '09d', '09n', // shower rain
          '10d', '10n', // rain
          '11d', '11n', // thunderstorm
          '13d', '13n', // snow
          '50d', '50n', // mist
        ];

        // Act & Assert
        for (final icon in weatherIcons) {
          expect(icon, matches(r'^\d{2}[dn]$'));
          expect(icon.length, equals(3));
        }
      });

      test('should map weather descriptions to appropriate icons', () {
        // Arrange
        final weatherData = [
          {'description': 'clear sky', 'icon': '01d'},
          {'description': 'few clouds', 'icon': '02d'},
          {'description': 'scattered clouds', 'icon': '03d'},
          {'description': 'broken clouds', 'icon': '04d'},
          {'description': 'shower rain', 'icon': '09d'},
          {'description': 'rain', 'icon': '10d'},
          {'description': 'thunderstorm', 'icon': '11d'},
          {'description': 'snow', 'icon': '13d'},
          {'description': 'mist', 'icon': '50d'},
        ];

        // Act & Assert
        for (final data in weatherData) {
          final weather = Weather(
            cityName: 'Test',
            country: 'XX',
            temperature: 20.0,
            feelsLike: 22.0,
            tempMin: 18.0,
            tempMax: 25.0,
            description: data['description']!,
            icon: data['icon']!,
            humidity: 65,
            windSpeed: 5.2,
            windDirection: 180,
            pressure: 1013.0,
            visibility: 10000,
            uvIndex: 5.0,
            timestamp: DateTime.now(),
            sunrise: DateTime.now(),
            sunset: DateTime.now(),
          );

          expect(weather.description, equals(data['description']));
          expect(weather.icon, equals(data['icon']));
        }
      });
    });
  });
}
