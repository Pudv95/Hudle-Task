import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/usecases/get_weather_by_city.dart';
import '../../domain/usecases/get_weather_by_location.dart';
import '../../domain/usecases/get_cached_weather.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/search_history_manager.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherByCity getWeatherByCity;
  final GetWeatherByLocation getWeatherByLocation;
  final GetCachedWeather getCachedWeather;

  WeatherBloc({
    required this.getWeatherByCity,
    required this.getWeatherByLocation,
    required this.getCachedWeather,
  }) : super(WeatherInitial()) {
    on<FetchWeatherByCity>(_onFetchWeatherByCity);
    on<FetchWeatherByLocation>(_onFetchWeatherByLocation);
    on<LoadCachedWeather>(_onLoadCachedWeather);
    on<RefreshWeather>(_onRefreshWeather);
  }

  Future<void> _onFetchWeatherByCity(
    FetchWeatherByCity event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    final result = await getWeatherByCity(event.cityName);

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) {
        SearchHistoryManager.addToHistory(event.cityName);
        emit(WeatherLoaded(weather));
      },
    );
  }

  Future<void> _onFetchWeatherByLocation(
    FetchWeatherByLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    // Check location permission
    final permission = await Permission.location.request();
    log('permission: $permission');
    if (permission.isDenied) {
      emit(const WeatherError('Location permission is required.'));
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final result = await getWeatherByLocation(
        LocationParams(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );

      result.fold(
        (failure) => emit(WeatherError(failure.message)),
        (weather) => emit(WeatherLoaded(weather)),
      );
    } catch (e) {
      emit(WeatherError('Failed to get location: $e'));
    }
  }

  Future<void> _onLoadCachedWeather(
    LoadCachedWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    final result = await getCachedWeather(const NoParams());

    result.fold((failure) => emit(WeatherError(failure.message)), (weather) {
      if (weather != null) {
        emit(WeatherLoaded(weather));
      } else {
        // If no cached weather, load default city
        add(FetchWeatherByCity(AppConstants.defaultCity));
      }
    });
  }

  Future<void> _onRefreshWeather(
    RefreshWeather event,
    Emitter<WeatherState> emit,
  ) async {
    if (state is WeatherLoaded) {
      final currentWeather = (state as WeatherLoaded).weather;
      add(FetchWeatherByCity(currentWeather.cityName));
    }
  }
}
