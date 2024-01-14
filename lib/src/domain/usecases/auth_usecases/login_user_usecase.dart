import 'package:poloniexapp/src/domain/entities/either.dart';
import 'package:poloniexapp/src/domain/entities/failure.dart';
import 'package:poloniexapp/src/domain/entities/user.dart';
import 'package:poloniexapp/src/domain/repositories/authentication_repository.dart';

class LoginUserUsecase {
  final AuthenticationRepository repository;

  LoginUserUsecase(this.repository);

  Future<Either<Failure, User>> call(User params) async {
    return await repository.loginUser(params);
  }
}
