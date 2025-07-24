import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Icons.cloud,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: const Duration(seconds: 2))
              .then()
              .shake(duration: const Duration(milliseconds: 500)),
          const SizedBox(height: 24),
          Text(
            'Loading weather data...',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 200,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
