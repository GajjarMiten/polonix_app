import 'package:poloniexapp/src/domain/entities/either.dart';
import 'package:poloniexapp/src/domain/entities/failure.dart';
import 'package:poloniexapp/src/domain/entities/user.dart';
import 'package:poloniexapp/src/domain/repositories/authentication_repository.dart';

class LoginUserUseCase {
  final AuthenticationRepository repository;

  LoginUserUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.loginUser(email, password);
  }
}
