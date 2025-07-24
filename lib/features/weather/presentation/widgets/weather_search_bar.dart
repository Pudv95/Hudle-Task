import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../../../../core/constants/app_constants.dart';

class WeatherSearchBar extends StatefulWidget {
  const WeatherSearchBar({super.key});

  @override
  State<WeatherSearchBar> createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _filteredCities = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _filteredCities = AppConstants.popularCities;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _filterCities(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredCities = AppConstants.popularCities;
        _showSuggestions = true;
      });
    } else {
      setState(() {
        _filteredCities = AppConstants.popularCities
            .where((city) => city.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _showSuggestions = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showSuggestions = false;
        });
        _focusNode.unfocus();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter city name...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: _filterCities,
                    onTap: () {
                      setState(() {
                        _showSuggestions = true;
                      });
                    },
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        context.read<WeatherBloc>().add(
                          FetchWeatherByCity(value.trim()),
                        );
                        _controller.clear();
                        _focusNode.unfocus();
                        setState(() {
                          _showSuggestions = false;
                        });
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<WeatherBloc>().add(
                      const FetchWeatherByLocation(),
                    );
                  },
                  icon: const Icon(Icons.my_location),
                  tooltip: 'Get weather for current location',
                ),
              ],
            ),
          ),
          if (_showSuggestions && _filteredCities.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCities.length,
                itemBuilder: (context, index) {
                  final city = _filteredCities[index];
                  return ListTile(
                    leading: const Icon(Icons.location_city),
                    title: Text(city),
                    onTap: () {
                      _controller.text = city;
                      context.read<WeatherBloc>().add(FetchWeatherByCity(city));
                      _focusNode.unfocus();
                      setState(() {
                        _showSuggestions = false;
                      });
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
