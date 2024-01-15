import 'package:poloniexapp/src/domain/entities/either.dart';
import 'package:poloniexapp/src/domain/entities/failure.dart';
import 'package:poloniexapp/src/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> registerUser(User user);

  Future<Either<Failure, User>> loginUser(String email, String password);
}
