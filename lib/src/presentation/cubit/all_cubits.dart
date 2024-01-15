import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poloniexapp/src/presentation/core/globals.dart';
import 'package:poloniexapp/src/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:poloniexapp/src/presentation/cubit/auth_cubit/auth_state.dart';

class AppCubits {
  AppCubits._();


  static AuthCubit get authCubit => mainContext.read<AuthCubit>();
  static AuthState get authState => authCubit.state;
}
