import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCachedWeather implements UseCase<Weather?, NoParams> {
  final WeatherRepository repository;

  GetCachedWeather(this.repository);

  @override
  Future<Either<Failure, Weather?>> call(NoParams params) async {
    return await repository.getCachedWeather();
  }
}
