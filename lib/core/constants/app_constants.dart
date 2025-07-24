import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static String get apiKey => dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  static const String weatherEndpoint = '/weather';

  // App Settings
  static const String appName = 'Weather App';
  static String get defaultCity => dotenv.env['DEFAULT_CITY'] ?? 'London';

  // Storage Keys
  static const String lastSearchedCityKey = 'last_searched_city';
  static const String searchHistoryKey = 'search_history';
  static const String themeModeKey = 'theme_mode';
  static const String temperatureUnitKey = 'temperature_unit';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 300);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);

  // Error Messages
  static const String networkErrorMessage =
      'Network error. Please check your connection.';
  static const String cityNotFoundMessage =
      'City not found. Please check the spelling.';
  static const String apiErrorMessage =
      'Something went wrong. Please try again.';
  static const String locationPermissionMessage =
      'Location permission is required to get weather for your current location.';
}
