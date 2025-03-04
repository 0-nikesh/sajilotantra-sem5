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
import '../../features/post/data/data_source/post_remote_data_source.dart';
import '../../features/post/data/repository/post_repository_impl.dart';
import '../../features/post/domain/repository/post_repository.dart';
import '../../features/post/domain/use_case/add_comment_usecase.dart';
import '../../features/post/domain/use_case/crearte_posts_usecase.dart';
import '../../features/post/domain/use_case/fetch_posts_usecase.dart';
import '../../features/post/domain/use_case/get_post_by_id.dart';
import '../../features/post/domain/use_case/like_posts_usecase.dart';
import '../../features/post/presentation/view_model/post_bloc.dart';
import '../../features/userprofile/data/data_source/user_remote_data_source.dart';
import '../../features/userprofile/data/repository/user_remote_repository.dart';
import '../../features/userprofile/domain/repository/user_repository.dart';
import '../../features/userprofile/domain/use_case/get_user_profile_usecase.dart';
import '../../features/userprofile/presentation/view_model/user_bloc.dart';
import '../shared_prefs/token_shared_prefs.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  _initApiService();
  await _initSharedPreferences();
  _initAuthDependencies();
  _initHomeDependencies();
  _initGuidanceDependencies();
  _initPostDependencies();
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

void _initPostDependencies() {
  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSource(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<IPostRepository>(
    () => PostRepositoryImpl(postDataSource: getIt<PostRemoteDataSource>()),
  );

  getIt.registerLazySingleton<FetchPostsUseCase>(
    () => FetchPostsUseCase(getIt<IPostRepository>()),
  );

  getIt.registerLazySingleton<LikePostUseCase>(
    () => LikePostUseCase(getIt<IPostRepository>()),
  );

  getIt.registerLazySingleton<AddCommentUseCase>(
    () => AddCommentUseCase(getIt<IPostRepository>()),
  );

  getIt.registerLazySingleton<CreatePostUseCase>(
    () => CreatePostUseCase(getIt<IPostRepository>()),
  );

  getIt.registerLazySingleton<GetPostByIdUseCase>(
    () => GetPostByIdUseCase(getIt<IPostRepository>()),
  );

  getIt.registerFactory<PostBloc>(
    () => PostBloc(
      fetchPostsUseCase: getIt<FetchPostsUseCase>(),
      likePostUseCase: getIt<LikePostUseCase>(),
      addCommentUseCase: getIt<AddCommentUseCase>(),
      createPostUseCase: getIt<CreatePostUseCase>(),
      getPostByIdUseCase: getIt<GetPostByIdUseCase>(),
    ),
  );
}

void _initAuthDependencies() {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRemoteRepositoryImpl(
        getIt<UserRemoteDataSource>(), getIt<TokenSharedPrefs>()),
  );

  getIt.registerLazySingleton<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(getIt<UserRepository>()),
  );

  getIt.registerFactory<UserBloc>(
    () => UserBloc(getIt<GetUserProfileUseCase>()),
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
