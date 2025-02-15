import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repository/remote/auth_remote_repository.dart';
import '../../features/auth/domain/use_case/login_usecase.dart';
import '../../features/auth/domain/use_case/register_usecase.dart';
import '../../features/auth/domain/use_case/verify_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/register/register_bloc.dart';
import '../../features/guidance/data/data_source/remote_data_source/guidance_remote_datasource.dart';
import '../../features/guidance/data/repository/guidance_remote_repository.dart';
import '../../features/guidance/domain/repository/guidance_repository.dart';
import '../../features/guidance/domain/use_case/create_guidance_usecase.dart';
import '../../features/guidance/domain/use_case/delete_guidance_usecase.dart';
import '../../features/guidance/domain/use_case/get_all_guidance_usecase.dart';
import '../../features/guidance/domain/use_case/get_guidance_by_id_usecase.dart';
import '../../features/guidance/domain/use_case/update_guidance_usecase.dart';
import '../../features/guidance/presentation/view_model/guidance_bloc.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../shared_prefs/token_shared_prefs.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  _initApiService();
  await _initSharedPreferences();
  _initAuthDependencies();
  _initHomeDependencies();
  _initGuidanceDependencies();
}

void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initApiService() {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

void _initAuthDependencies() {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<VerifyEmailUsecase>(
    () => VerifyEmailUsecase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: getIt<LoginUsecase>(),
      homeCubit: getIt<HomeCubit>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUsecase>(),
      verifyEmailUsecase: getIt<VerifyEmailUsecase>(),
    ),
  );
}

void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}

void _initGuidanceDependencies() {
  // Data Sources
  getIt.registerLazySingleton<GuidanceRemoteDataSource>(
    () => GuidanceRemoteDataSource(dio: getIt<Dio>()),
  );

  // Repositories
  getIt.registerLazySingleton<IGuidanceRepository>(
    () => GuidanceRemoteRepository(
      guidanceRemoteDataSource: getIt<GuidanceRemoteDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<GetAllGuidancesUseCase>(
    () => GetAllGuidancesUseCase(
        guidanceRepository: getIt<IGuidanceRepository>()),
  );

  getIt.registerLazySingleton<GetGuidanceByIdUseCase>(
    () => GetGuidanceByIdUseCase(
        guidanceRepository: getIt<IGuidanceRepository>()),
  );

  getIt.registerLazySingleton<CreateGuidanceUseCase>(
    () =>
        CreateGuidanceUseCase(guidanceRepository: getIt<IGuidanceRepository>()),
  );

  getIt.registerLazySingleton<UpdateGuidanceUseCase>(
    () =>
        UpdateGuidanceUseCase(guidanceRepository: getIt<IGuidanceRepository>()),
  );

  getIt.registerLazySingleton<DeleteGuidanceUseCase>(
    () =>
        DeleteGuidanceUseCase(guidanceRepository: getIt<IGuidanceRepository>()),
  );

  // Bloc
  getIt.registerFactory<GuidanceBloc>(
    () => GuidanceBloc(
      getAllGuidancesUseCase: getIt<GetAllGuidancesUseCase>(),
      getGuidanceByIdUseCase: getIt<GetGuidanceByIdUseCase>(),
    ),
  );
}
