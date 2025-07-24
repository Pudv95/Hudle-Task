import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Hero Weather Card
            _buildHeroWeatherCard(context),
            const SizedBox(height: 24),

            // Quick Stats Row
            _buildQuickStatsRow(context),
            const SizedBox(height: 24),

            // Detailed Weather Grid
            _buildDetailedWeatherGrid(context),
            const SizedBox(height: 24),

            // Sun & Time Info
            _buildSunTimeInfo(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroWeatherCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 28),
              const SizedBox(width: 8),
              Text(
                '${weather.cityName}, ${weather.country}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          // Weather Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
            child: Image.network(
              'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
              errorBuilder: (context, error, stackTrace) {
                return Icon(_getWeatherIcon(weather.description), size: 60);
              },
            ),
          ),

          // Temperature
          Text(
            '${weather.temperature.round()}°',
            style: TextStyle(
              fontSize: 86,
              fontWeight: FontWeight.w300,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            weather.description.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),

          // Feels like
          Text(
            'Feels like ${weather.feelsLike.round()}°',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickStatCard(
            context,
            Icons.arrow_downward,
            'Min',
            '${weather.tempMin.round()}°',
            Colors.blue[400]!,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildQuickStatCard(
            context,
            Icons.arrow_upward,
            'Max',
            '${weather.tempMax.round()}°',
            Colors.red[400]!,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildQuickStatCard(
            context,
            Icons.water_drop,
            'Humidity',
            '${weather.humidity}%',
            Colors.cyan[400]!,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStatCard(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedWeatherGrid(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  context,
                  Icons.air,
                  'Wind Speed',
                  '${weather.windSpeed.toStringAsFixed(1)} m/s',
                  Colors.green[400]!,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDetailItem(
                  context,
                  Icons.compass_calibration,
                  'Wind Direction',
                  '${weather.windDirection}°',
                  Colors.orange[400]!,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  context,
                  Icons.speed,
                  'Pressure',
                  '${weather.pressure.round()} hPa',
                  Colors.purple[400]!,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDetailItem(
                  context,
                  Icons.visibility,
                  'Visibility',
                  '${(weather.visibility / 1000).toStringAsFixed(1)} km',
                  Colors.teal[400]!,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSunTimeInfo(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSunTimeCard(
            context,
            Icons.wb_sunny,
            'Sunrise',
            DateFormat('HH:mm').format(weather.sunrise),
            Colors.orange[400]!,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSunTimeCard(
            context,
            Icons.nightlight_round,
            'Sunset',
            DateFormat('HH:mm').format(weather.sunset),
            Colors.deepOrange[400]!,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSunTimeCard(
            context,
            Icons.access_time,
            'Updated',
            DateFormat('HH:mm').format(weather.timestamp),
            Colors.grey[400]!,
          ),
        ),
      ],
    );
  }

  Widget _buildSunTimeCard(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
        ],
      ),
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
