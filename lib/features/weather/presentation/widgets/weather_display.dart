import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // City Name
          Text(
            weather.cityName,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Date
          Text(
            DateFormat('EEEE, MMMM d').format(weather.timestamp),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          // Weather Icon and Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Weather Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Image.network(
                  'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      _getWeatherIcon(weather.description),
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),

              // Temperature
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.temperature.round()}°C',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    weather.description.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Additional Weather Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherInfo(
                context,
                Icons.water_drop,
                'Humidity',
                '${weather.humidity}%',
              ),
              _buildWeatherInfo(
                context,
                Icons.air,
                'Wind Speed',
                '${weather.windSpeed} m/s',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Last Updated
          Text(
            'Last updated: ${DateFormat('HH:mm').format(weather.timestamp)}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  IconData _getWeatherIcon(String description) {
    final desc = description.toLowerCase();
    if (desc.contains('rain')) return Icons.water_drop;
    if (desc.contains('cloud')) return Icons.cloud;
    if (desc.contains('clear')) return Icons.wb_sunny;
    if (desc.contains('snow')) return Icons.ac_unit;
    if (desc.contains('thunder')) return Icons.thunderstorm;
    if (desc.contains('fog') || desc.contains('mist')) return Icons.cloud;
    return Icons.cloud;
  }
}
