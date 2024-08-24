import '../models/stadium_model.dart';
import '../network/api_service.dart';

class StadiumRepository {
  final ApiService apiService;

  StadiumRepository(this.apiService);

  Future<List<StaduimModel>> fetchUsers() async {
    return await apiService.getStadiums();
  }
}
