import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';

import 'package:hudle_task/features/weather/domain/entities/weather.dart';

void main() {
  group('Weather Entity', () {
    test('should create a Weather instance with all properties', () {
      // Arrange
      final timestamp = DateTime.now();
      final sunrise = DateTime.now().add(const Duration(hours: 6));
      final sunset = DateTime.now().add(const Duration(hours: 18));

      // Act
      final weather = Weather(
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

      // Assert
      expect(weather.cityName, equals('London'));
      expect(weather.country, equals('GB'));
      expect(weather.temperature, equals(20.0));
      expect(weather.feelsLike, equals(22.0));
      expect(weather.tempMin, equals(18.0));
      expect(weather.tempMax, equals(25.0));
      expect(weather.description, equals('clear sky'));
      expect(weather.icon, equals('01d'));
      expect(weather.humidity, equals(65));
      expect(weather.windSpeed, equals(5.2));
      expect(weather.windDirection, equals(180));
      expect(weather.pressure, equals(1013.0));
      expect(weather.visibility, equals(10000));
      expect(weather.uvIndex, equals(5.0));
      expect(weather.timestamp, equals(timestamp));
      expect(weather.sunrise, equals(sunrise));
      expect(weather.sunset, equals(sunset));
    });

    test('should support equality', () {
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
    });

    test('should not be equal when properties differ', () {
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
        cityName: 'Paris',
        country: 'FR',
        temperature: 25.0,
        feelsLike: 27.0,
        tempMin: 22.0,
        tempMax: 30.0,
        description: 'partly cloudy',
        icon: '02d',
        humidity: 70,
        windSpeed: 3.5,
        windDirection: 90,
        pressure: 1015.0,
        visibility: 8000,
        uvIndex: 7.0,
        timestamp: timestamp,
        sunrise: sunrise,
        sunset: sunset,
      );

      // Act & Assert
      expect(weather1, isNot(equals(weather2)));
      expect(weather1.hashCode, isNot(equals(weather2.hashCode)));
    });

    test('should extend Equatable', () {
      // Arrange
      final timestamp = DateTime.now();
      final sunrise = DateTime.now().add(const Duration(hours: 6));
      final sunset = DateTime.now().add(const Duration(hours: 18));

      final weather = Weather(
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
      expect(weather, isA<Equatable>());
    });

    test('should have correct props list', () {
      // Arrange
      final timestamp = DateTime.now();
      final sunrise = DateTime.now().add(const Duration(hours: 6));
      final sunset = DateTime.now().add(const Duration(hours: 18));

      final weather = Weather(
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

      // Act
      final props = weather.props;

      // Assert
      expect(props.length, equals(17));
      expect(props, contains('London'));
      expect(props, contains('GB'));
      expect(props, contains(20.0));
      expect(props, contains(timestamp));
      expect(props, contains(sunrise));
      expect(props, contains(sunset));
    });
  });
}
