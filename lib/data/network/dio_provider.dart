import 'package:riverpod/riverpod.dart';
import '../repository/stadium_repository.dart';
import 'api_service.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.read(dioProvider);
  return ApiService(dio);
});

final userRepositoryProvider = Provider<StadiumRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return StadiumRepository(apiService);
});
