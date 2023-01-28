import 'package:flutter_web_splash_screen/app/core/interfaces/http_client/http_client.dart';
import 'package:flutter_web_splash_screen/app/modules/user/errors/user_errors.dart';
import 'package:flutter_web_splash_screen/app/modules/user/models/user_model.dart';

class UsersRepository {
  final HttpClient _httpClient;

  const UsersRepository(this._httpClient);

  Future<List<UserModel>> getUsers({String id = ''}) async {
    final param = id.isNotEmpty ? '/id' : '';
    try {
      final result = await _httpClient.get('/user$param');
      return UserModel.fromMapList(result.data);
    } on Exception catch (e) {
      throw UserUnknownError(e.toString());
    }
  }
}
