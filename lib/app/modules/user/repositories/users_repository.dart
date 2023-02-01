import '../../../core/interfaces/http_client/http_client.dart';
import '../models/user_model.dart';

class UsersRepository {
  final HttpClient _httpClient;

  const UsersRepository(this._httpClient);

  Future<List<UserModel>> getUsers({String id = ''}) async {
    final param = id.isNotEmpty ? '/$id' : '';
    final result = await _httpClient.get('/user$param');
    return UserModel.fromMapList(result.data);
  }
}
