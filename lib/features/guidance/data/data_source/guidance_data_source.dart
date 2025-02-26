import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';

abstract interface class IGuidanceDataSource {
  /// Fetches all guidances.
  Future<List<GuidanceEntity>> getAllGuidances();

  /// Fetches a specific guidance by its ID.
  Future<GuidanceEntity?> getGuidanceById(String id);

  /// Creates a new guidance.
  Future<void> createGuidance(GuidanceEntity guidance);

  /// Updates an existing guidance.
  Future<void> updateGuidance(String id, GuidanceEntity guidance);

  /// Deletes a guidance by its ID.
  Future<void> deleteGuidance(String id);
}
