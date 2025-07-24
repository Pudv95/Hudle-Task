import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/constants/app_constants.dart';
import 'core/network/network_info.dart';
import 'features/weather/data/datasources/weather_local_data_source.dart';
import 'features/weather/data/datasources/weather_remote_data_source.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/usecases/get_weather_by_city.dart';
import 'features/weather/domain/usecases/get_weather_by_location.dart';
import 'features/weather/domain/usecases/get_cached_weather.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'features/weather/presentation/bloc/theme_bloc.dart';
import 'features/weather/presentation/pages/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Theme Bloc
        BlocProvider<ThemeBloc>(
          create: (context) =>
              ThemeBloc(sharedPreferences: sharedPreferences)
                ..add(const LoadTheme()),
        ),

        // Weather Bloc
        BlocProvider<WeatherBloc>(create: (context) => _createWeatherBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: AppConstants.appName,
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: themeState is ThemeLoaded
                ? themeState.themeMode
                : ThemeMode.system,
            home: const WeatherPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  WeatherBloc _createWeatherBloc() {
    // Create Dio instance
    final dio = Dio();

    // Create data sources
    final remoteDataSource = WeatherRemoteDataSourceImpl(dio);
    final localDataSource = WeatherLocalDataSourceImpl(sharedPreferences);

    // Create network info
    final networkInfo = NetworkInfoImpl(dio);

    // Create repository
    final repository = WeatherRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );

    // Create use cases
    final getWeatherByCity = GetWeatherByCity(repository);
    final getWeatherByLocation = GetWeatherByLocation(repository);
    final getCachedWeather = GetCachedWeather(repository);

    // Create and return WeatherBloc
    return WeatherBloc(
      getWeatherByCity: getWeatherByCity,
      getWeatherByLocation: getWeatherByLocation,
      getCachedWeather: getCachedWeather,
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
