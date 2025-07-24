import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../widgets/weather_search_bar.dart';
import '../widgets/weather_display.dart';
import '../widgets/weather_error.dart' as error_widget;
import '../widgets/weather_loading.dart' as loading_widget;
import '../widgets/theme_toggle_button.dart';
import '../../../../core/constants/app_constants.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    // Load default city weather when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherBloc>().add(const LoadCachedWeather());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: const [ThemeToggleButton()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<WeatherBloc>().add(const RefreshWeather());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const WeatherSearchBar(),
                const SizedBox(height: 24),
                Expanded(
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherInitial) {
                        return _buildInitialState();
                      } else if (state is WeatherLoading) {
                        return const loading_widget.WeatherLoading();
                      } else if (state is WeatherLoaded) {
                        return WeatherDisplay(weather: state.weather)
                            .animate()
                            .fadeIn(duration: const Duration(milliseconds: 500))
                            .slideY(begin: 0.3, end: 0);
                      } else if (state is WeatherError) {
                        return error_widget.WeatherError(
                          message: state.message,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Search for a city to get weather information',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Popular Cities',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: AppConstants.popularCities.take(8).map((city) {
              return ActionChip(
                label: Text(city),
                onPressed: () {
                  context.read<WeatherBloc>().add(FetchWeatherByCity(city));
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
