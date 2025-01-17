import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sajilotantra/app/di/di.dart';
import 'package:sajilotantra/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sajilotantra/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:sajilotantra/features/home/presentation/view_model/home_cubit.dart';
import 'package:sajilotantra/features/splash/presentation/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => getIt<RegisterBloc>(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => getIt<HomeCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Sajilotantra',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(), // Replace with your initial screen
      ),
    );
  }
}
