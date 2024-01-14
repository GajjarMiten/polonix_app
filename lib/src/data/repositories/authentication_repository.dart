import 'package:poloniexapp/src/domain/entities/either.dart';
import 'package:poloniexapp/src/domain/entities/failure.dart';
import 'package:poloniexapp/src/domain/entities/user.dart';
import 'package:poloniexapp/src/domain/repositories/authentication_repository.dart';

class LocalAuthenticationRepoImpl implements AuthenticationRepository {
  
  @override
  Future<Either<Failure, User>> loginUser(User user) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> registerUser(User user) {
    throw UnimplementedError();
  }
}
