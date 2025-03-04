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
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          cardColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            foregroundColor: Colors.white,
            elevation: 2,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 24, color: Colors.black87),
            titleMedium: TextStyle(fontSize: 18, color: Colors.black87),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          useMaterial3: true, // Optional: Enables Material 3 design
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.grey[900],
          cardColor: Colors.grey[850],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
            foregroundColor: Colors.white,
            elevation: 2,
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 24, color: Colors.white),
            titleMedium: TextStyle(fontSize: 18, color: Colors.white),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          useMaterial3: true, // Optional: Enables Material 3 design
        ),
        themeMode: ThemeMode.system, // Switch based on system settings
        home: const SplashScreen(), // Your initial screen
      ),
    );
  }
}
