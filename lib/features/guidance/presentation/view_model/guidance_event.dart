import 'package:equatable/equatable.dart';

abstract class GuidanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllGuidancesEvent extends GuidanceEvent {}

class LoadGuidanceDetailsEvent extends GuidanceEvent {
  final String guidanceId;

  LoadGuidanceDetailsEvent({required this.guidanceId});

  @override
  List<Object?> get props => [guidanceId];
}
