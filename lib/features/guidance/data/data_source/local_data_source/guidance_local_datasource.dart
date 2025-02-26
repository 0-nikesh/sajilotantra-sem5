import 'package:sajilotantra/core/network/hive_service.dart';
import 'package:sajilotantra/features/guidance/data/data_source/guidance_data_source.dart';
import 'package:sajilotantra/features/guidance/data/model/guidance_hive_model.dart';
import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';

class GuidanceLocalDataSource implements IGuidanceDataSource {
  final HiveService hiveService;

  GuidanceLocalDataSource({required this.hiveService});

  @override
  Future<void> createGuidance(GuidanceEntity guidance) async {
    try {
      final guidanceHiveModel = GuidanceHiveModel.fromEntity(guidance);
      await hiveService.addGuidance(guidanceHiveModel);
    } catch (e) {
      throw Exception("Failed to create guidance locally: $e");
    }
  }

  @override
  Future<void> deleteGuidance(String id) async {
    try {
      await hiveService.deleteGuidance(id);
    } catch (e) {
      throw Exception("Failed to delete guidance locally: $e");
    }
  }

  @override
  Future<List<GuidanceEntity>> getAllGuidances() async {
    try {
      var guidanceList = await hiveService.getAllGuidance();
      return guidanceList.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception("Failed to fetch all guidances locally: $e");
    }
  }

  @override
  Future<GuidanceEntity?> getGuidanceById(String id) async {
    try {
      var guidance = await hiveService.getGuidanceById(id);
      return guidance?.toEntity();
    } catch (e) {
      throw Exception("Failed to fetch guidance by ID locally: $e");
    }
  }

  @override
  Future<void> updateGuidance(String id, GuidanceEntity guidance) async {
    try {
      final guidanceHiveModel = GuidanceHiveModel.fromEntity(guidance);
      await hiveService.updateGuidance(id, guidanceHiveModel);
    } catch (e) {
      throw Exception("Failed to update guidance locally: $e");
    }
  }
}
