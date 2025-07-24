import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class SearchHistoryManager {
  static const int maxHistorySize = 5;

  static Future<void> addToHistory(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();

    history.removeWhere(
      (element) => element.toLowerCase() == cityName.toLowerCase(),
    );

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
        return historyList.cast<String>();
      } catch (e) {
        return [];
      }
    }

    return [];
  }

  static Future<List<String>> getSuggestions(String query) async {
    final history = await getHistory();

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
      // For search queries, combine history and popular cities without duplicates
      final allCities = <String>[];
      final seen = <String>{};

      // Add history first (they have priority)
      for (final city in history) {
        if (!seen.contains(city)) {
          allCities.add(city);
          seen.add(city);
        }
      }

      // Add popular cities (excluding duplicates)
      for (final city in AppConstants.popularCities) {
        if (!seen.contains(city)) {
          allCities.add(city);
          seen.add(city);
        }
      }

      // Filter and return
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
