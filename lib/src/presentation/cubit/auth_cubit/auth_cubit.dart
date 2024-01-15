import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poloniexapp/src/domain/entities/user.dart';
import 'package:poloniexapp/src/domain/usecases/auth_usecases/login_user_usecase.dart';
import 'package:poloniexapp/src/domain/usecases/auth_usecases/register_user_usecase.dart';
import 'package:poloniexapp/src/presentation/core/enums/routes_enum.dart';
import 'package:poloniexapp/src/presentation/cubit/auth_cubit/auth_state.dart';
import 'package:poloniexapp/src/presentation/routing/app_router.dart';
import 'package:poloniexapp/src/presentation/utils/utils.dart';
import 'package:poloniexapp/src/presentation/utils/validations.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUserUseCase loginUserUseCase,
    required RegisterUserUseCase registerUserUseCase,
  })  : _loginUserUsecase = loginUserUseCase,
        _registerUserUsecase = registerUserUseCase,
        super(AuthInitial());
  final LoginUserUseCase _loginUserUsecase;
  final RegisterUserUseCase _registerUserUsecase;

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      bool isValid = _checkValidEmailPassword(email, password);

      if (!isValid) return;

      emit(const LoadingAuthState());

      await Future.delayed(1.seconds);

      final response = await _loginUserUsecase(email, password);

      response.fold(
        (failure) {
          emit(ErrorAuthState(failure.message));
          Utils.showError(failure.message);
        },
        (user) {
          emit(Authenticated(user));
          AppRouter.pushReplace(Routes.homeScreen);
        },
      );
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  Future<void> registerUser(
      {required String email, required String password}) async {
    try {
      bool isValid = _checkValidEmailPassword(email, password);
      if (!isValid) return;

      emit(const LoadingAuthState());

      final user = User(
          email: email,
          password: password,
          firstName: 'demo',
          lastName: 'user');

      final response = await _registerUserUsecase(user);

      response.fold(
        (failure) => emit(ErrorAuthState(failure.message)),
        (user) {
          emit(Authenticated(user));
          AppRouter.pushReplace(Routes.homeScreen);
        },
      );
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  bool _checkValidEmailPassword(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      Utils.showError('Email and password cannot be empty');
      return false;
    } else if (!Validator.isValidEmail(email)) {
      Utils.showError('Please enter a valid email');
      return false;
    } else if (!Validator.isValidPassword(password)) {
      Utils.showError('Password must be at least 6 characters');
      return false;
    }
    return true;
  }
}
