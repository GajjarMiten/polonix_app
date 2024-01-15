import 'package:poloniexapp/src/data/datasources/local/base/base_local_datasource.dart';
import 'package:poloniexapp/src/domain/entities/user.dart';

class LocalUserDataSource {
  final BaseLocalDataSource _localDataSource;

  LocalUserDataSource(this._localDataSource);

  Future<bool> isUserExist(String userId) async {
    return await _localDataSource.containsKey(userId);
  }

  Future<void> saveUser(User user) async {
    await _localDataSource.save(user.id, user.toMap());
  }

  Future<User?> getUser(String userId) async {
    final userMap = await _localDataSource.get<Map<String, dynamic>>(userId);
    if (userMap == null) {
      return null;
    }
    return User.fromMap(userMap);
  }
}
