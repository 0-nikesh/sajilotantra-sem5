import 'package:dio/dio.dart';
import 'package:sajilotantra/app/constants/api_endpoints.dart';
import 'package:sajilotantra/features/guidance/data/data_source/guidance_data_source.dart';
import 'package:sajilotantra/features/guidance/data/model/guidance_api_model.dart';
import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';

class GuidanceRemoteDataSource implements IGuidanceDataSource {
  final Dio _dio;

  GuidanceRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<void> createGuidance(GuidanceEntity guidance) async {
    try {
      var guidanceApiModel = GuidanceApiModel.fromEntity(guidance);
      var response = await _dio.post(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.createGuidance}",
        data: guidanceApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteGuidance(String id) async {
    try {
      var response = await _dio
          .delete("${ApiEndpoints.baseUrl}${ApiEndpoints.getGuidanceById}$id");
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<GuidanceEntity>> getAllGuidances() async {
    try {
      var response = await _dio
          .get("${ApiEndpoints.baseUrl}${ApiEndpoints.getAllGuidances}");
      if (response.statusCode == 200) {
        List<GuidanceApiModel> guidanceList = (response.data as List)
            .map((json) => GuidanceApiModel.fromJson(json))
            .toList();
        return guidanceList.map((e) => e.toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<GuidanceEntity?> getGuidanceById(String id) async {
    try {
      var url = "${ApiEndpoints.baseUrl}${ApiEndpoints.getGuidanceById}$id";
      print("Fetching Guidance Details from URL: $url");

      var response = await _dio.get(url);
      print("Response Status: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return GuidanceApiModel.fromJson(response.data).toEntity();
      } else {
        print("Failed to fetch guidance: ${response.statusMessage}");
        return null;
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data ?? e.message}");
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      print("Unexpected Error: $e");
      throw Exception("Unexpected Error: $e");
    }
  }

  @override
  Future<void> updateGuidance(String id, GuidanceEntity guidance) async {
    try {
      var guidanceApiModel = GuidanceApiModel.fromEntity(guidance);
      var response = await _dio.put(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.updateGuidance}$id",
        data: guidanceApiModel.toJson(),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
