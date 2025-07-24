import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByCity extends UseCase<Weather, String> {
  final WeatherRepository repository;

  GetWeatherByCity(this.repository);

  @override
  Future<Either<Failure, Weather>> call(String cityName) async {
    return await repository.getWeatherByCity(cityName);
  }
}
