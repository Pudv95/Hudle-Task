import 'package:dio/dio.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Dio dio;

  NetworkInfoImpl(this.dio);

  @override
  Future<bool> get isConnected async {
    try {
      final result = await dio.get('https://www.google.com');
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
