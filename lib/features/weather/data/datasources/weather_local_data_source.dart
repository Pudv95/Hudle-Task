import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel?> getCachedWeather();
  Future<void> cacheWeather(WeatherModel weather);
  Future<List<String>> getSearchHistory();
  Future<void> addToSearchHistory(String cityName);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<WeatherModel?> getCachedWeather() async {
    try {
      final jsonString = sharedPreferences.getString(
        AppConstants.lastSearchedCityKey,
      );
      if (jsonString != null) {
        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return WeatherModel.fromCache(jsonMap);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    try {
      final jsonString = json.encode(weather.toCache());
      await sharedPreferences.setString(
        AppConstants.lastSearchedCityKey,
        jsonString,
      );
    } catch (e) {
      throw Exception('Failed to cache weather data');
    }
  }

  @override
  Future<List<String>> getSearchHistory() async {
    try {
      final jsonString = sharedPreferences.getString(
        AppConstants.searchHistoryKey,
      );
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.cast<String>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addToSearchHistory(String cityName) async {
    try {
      final history = await getSearchHistory();
      if (!history.contains(cityName)) {
        history.insert(0, cityName);
        if (history.length > 10) {
          history.removeRange(10, history.length);
        }
        final jsonString = json.encode(history);
        await sharedPreferences.setString(
          AppConstants.searchHistoryKey,
          jsonString,
        );
      }
    } catch (e) {
      throw Exception('Failed to add to search history');
    }
  }
}
