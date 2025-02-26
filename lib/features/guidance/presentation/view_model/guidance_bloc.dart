import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:sajilotantra/core/error/failure.dart';

import '../../domain/entity/guidance_entity.dart';
import '../../domain/use_case/get_all_guidance_usecase.dart';
import '../../domain/use_case/get_guidance_by_id_usecase.dart';
import 'guidance_event.dart';
import 'guidance_state.dart';

class GuidanceBloc extends Bloc<GuidanceEvent, GuidanceState> {
  final GetAllGuidancesUseCase getAllGuidancesUseCase;
  final GetGuidanceByIdUseCase getGuidanceByIdUseCase;

  GuidanceBloc({
    required this.getAllGuidancesUseCase,
    required this.getGuidanceByIdUseCase,
  }) : super(GuidanceInitialState()) {
    on<LoadAllGuidancesEvent>(_onLoadAllGuidances);
    on<LoadGuidanceDetailsEvent>(_onLoadGuidanceDetails);
  }

  Future<void> _onLoadAllGuidances(
      LoadAllGuidancesEvent event, Emitter<GuidanceState> emit) async {
    emit(GuidanceLoadingState());

    final Either<Failure, List<GuidanceEntity>> result =
        await getAllGuidancesUseCase.call();

    result.fold(
      (failure) => emit(GuidanceErrorState(message: failure.message)),
      (guidances) => emit(GuidanceLoadedState(guidances: guidances)),
    );
  }

  Future<void> _onLoadGuidanceDetails(
      LoadGuidanceDetailsEvent event, Emitter<GuidanceState> emit) async {
    emit(GuidanceLoadingState());

    final Either<Failure, GuidanceEntity?> result = await getGuidanceByIdUseCase
        .call(GetGuidanceByIdParams(id: event.guidanceId));

    result.fold(
      (failure) => emit(GuidanceErrorState(message: failure.message)),
      (guidance) => emit(GuidanceDetailsLoadedState(guidance: guidance!)),
    );
  }
}
