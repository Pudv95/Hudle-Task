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
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
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
                child: Column(
                  children: [
                    const WeatherSearchBar(),
                    const SizedBox(height: 24),
                    Expanded(child: _buildWeatherContent(state)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeatherContent(WeatherState state) {
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
      return error_widget.WeatherError(message: state.message);
    }
    return const SizedBox.shrink();
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.cloud,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Search for a city to get weather information',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Popular Cities',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AppConstants.popularCities.take(6).map((city) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            context.read<WeatherBloc>().add(
                              FetchWeatherByCity(city),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(
                              city,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
