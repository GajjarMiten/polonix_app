import 'package:poloniexapp/src/data/datasources/local/user_datasource/user_datasource.dart';
import 'package:poloniexapp/src/domain/entities/either.dart';
import 'package:poloniexapp/src/domain/entities/failure.dart';
import 'package:poloniexapp/src/domain/entities/user.dart';
import 'package:poloniexapp/src/domain/repositories/authentication_repository.dart';

class LocalAuthenticationRepoImpl implements AuthenticationRepository {
  final LocalUserDataSource _localDataSource;

  LocalAuthenticationRepoImpl(this._localDataSource);

  @override
  Future<Either<Failure, User>> loginUser(String email, String password) async {
    final isExist = await _localDataSource.isUserExist(email);
    if (!isExist) {
      return Either.left(Failure('Invalid email or password'));
    }

    final user = await _localDataSource.getUser(email);

    if (user == null) {
      return Either.left(Failure('Invalid email or password'));
    }

    if (user.password != password) {
      return Either.left(Failure('Invalid email or password'));
    }

    return Either.right(user);
  }

  @override
  Future<Either<Failure, User>> registerUser(User user) async {
    try {
      final isExist = await _localDataSource.isUserExist(user.id);
      if (isExist) {
        return Either.left(Failure('User already exist'));
      }

      await _localDataSource.saveUser(user);

      return Either.right(user);
    } catch (e) {
      return Future.value(Either.left(Failure(e.toString())));
    }
  }
}
