import 'package:poloniexapp/src/domain/entities/either.dart';
import 'package:poloniexapp/src/domain/entities/failure.dart';
import 'package:poloniexapp/src/domain/entities/user.dart';
import 'package:poloniexapp/src/domain/repositories/authentication_repository.dart';

class RegisterUserUseCase {
  final AuthenticationRepository _userRepository;

  RegisterUserUseCase(this._userRepository);

  Future<Either<Failure, User>> call(User user) async {
    return await _userRepository.registerUser(user);
  }
}
