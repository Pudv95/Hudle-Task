import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class LocationParams extends Equatable {
  final double latitude;
  final double longitude;

  const LocationParams({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}

class GetWeatherByLocation implements UseCase<Weather, LocationParams> {
  final WeatherRepository repository;

  GetWeatherByLocation(this.repository);

  @override
  Future<Either<Failure, Weather>> call(LocationParams params) async {
    return await repository.getWeatherByLocation(
      params.latitude,
      params.longitude,
    );
  }
}
