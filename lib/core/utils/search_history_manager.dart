import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class SearchHistoryManager {
  static const int maxHistorySize = 5;

  static Future<void> addToHistory(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();

    history.remove(cityName);

    history.insert(0, cityName.toLowerCase());

    if (history.length > maxHistorySize) {
      history.removeRange(maxHistorySize, history.length);
    }

    await prefs.setString(AppConstants.searchHistoryKey, jsonEncode(history));
  }

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(AppConstants.searchHistoryKey);

    if (historyJson != null) {
      try {
        final List<dynamic> historyList = jsonDecode(historyJson);
        return historyList
            .cast<String>()
            .map((e) => "${e[0].toUpperCase()}${e.substring(1)}")
            .toList();
      } catch (e) {
        return [];
      }
    }

    return [];
  }

  static Future<List<String>> getSuggestions(String query) async {
    final history = await getHistory();
    final allCities = [...history, ...AppConstants.popularCities];

    if (query.isEmpty) {
      final suggestions = <String>[];
      final seen = <String>{};

      for (final city in history) {
        if (suggestions.length >= maxHistorySize) break;
        if (!seen.contains(city)) {
          suggestions.add(city);
          seen.add(city);
        }
      }

      for (final city in AppConstants.popularCities) {
        if (suggestions.length >= maxHistorySize) break;
        if (!seen.contains(city)) {
          suggestions.add(city);
          seen.add(city);
        }
      }

      return suggestions;
    } else {
      return allCities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .take(maxHistorySize)
          .toList();
    }
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.searchHistoryKey);
  }
}
