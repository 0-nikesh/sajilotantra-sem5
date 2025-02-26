import 'package:equatable/equatable.dart';
import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';

abstract class GuidanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GuidanceInitialState extends GuidanceState {}

class GuidanceLoadingState extends GuidanceState {}

class GuidanceLoadedState extends GuidanceState {
  final List<GuidanceEntity> guidances;

  GuidanceLoadedState({required this.guidances});

  @override
  List<Object?> get props => [guidances];
}

class GuidanceDetailsLoadedState extends GuidanceState {
  final GuidanceEntity guidance;

  GuidanceDetailsLoadedState({required this.guidance});

  @override
  List<Object?> get props => [guidance];
}

class GuidanceErrorState extends GuidanceState {
  final String message;

  GuidanceErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
