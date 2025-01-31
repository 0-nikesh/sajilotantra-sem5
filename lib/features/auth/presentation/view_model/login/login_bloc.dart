// import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/di/di.dart';
import '../../../../home/presentation/view/home.dart';
import '../../../../home/presentation/view_model/home_cubit.dart';
import '../../../domain/use_case/login_usecase.dart';
import '../register/register_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _loginUseCase;

  LoginBloc({required LoginUsecase loginUseCase, required HomeCubit homeCubit})
      : _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    // Handle Login Event
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final result = await _loginUseCase(
        LoginParams(
          email: event.email,
          password: event.password,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: Text('Invalid Credentials'),
              backgroundColor: Colors.red,
            ),
          );
        },
        (token) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ),
          );
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: Text('Login Successful'),
              backgroundColor: Color.fromARGB(255, 63, 149, 10),
            ),
          );
        },
      );
    });

    // Handle Navigation to Register Screen
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RegisterBloc>(),
            child: event.destination,
          ),
        ),
      );
    });
  }
}
