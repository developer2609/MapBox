import 'package:riverpod/riverpod.dart';
import '../../data/models/stadium_model.dart';
import '../../data/network/dio_provider.dart';
import '../../data/repository/stadium_repository.dart';

class StadiumNotifier extends StateNotifier<AsyncValue<List<StaduimModel>>> {
final StadiumRepository repository;

StadiumNotifier(this.repository) : super(const AsyncValue.loading()) {
fetchStadiums();
}

Future<void> fetchStadiums() async {
try {
final stadiums = await repository.fetchUsers();
state = AsyncValue.data(stadiums);
} catch (error, stackTrace) {
state = AsyncValue.error(error, stackTrace);
}
}
}

final stadiumNotifierProvider = StateNotifierProvider<StadiumNotifier, AsyncValue<List<StaduimModel>>>((ref) {
  final repository = ref.read(userRepositoryProvider);
  return StadiumNotifier(repository);
});
