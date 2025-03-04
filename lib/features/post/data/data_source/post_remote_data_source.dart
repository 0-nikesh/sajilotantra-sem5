import 'package:dio/dio.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../domain/entity/post_entity.dart';
import '../model/post_api_model.dart';
import 'post_data_source.dart';

class PostRemoteDataSource implements IPostDataSource {
  final Dio _dio;

  PostRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<PostEntity>> getAllPosts() async {
    try {
      var response =
          await _dio.get("${ApiEndpoints.baseUrl}${ApiEndpoints.getAllPost}");
      if (response.statusCode == 200) {
        // Check if response.data is a Map and extract the "posts" list
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;
          if (data.containsKey('posts')) {
            List<PostApiModel> postModels = (data['posts'] as List)
                .map((json) => PostApiModel.fromJson(json))
                .toList();
            return postModels.map((e) => e.toEntity()).toList();
          } else {
            throw Exception(
                'Unexpected response format: "posts" key not found');
          }
        } else {
          throw Exception('Unexpected response format: Expected a Map');
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PostEntity?> getPostById(String id) async {
    try {
      var response = await _dio.get("${ApiEndpoints.baseUrl}posts/$id");
      if (response.statusCode == 200) {
        return PostApiModel.fromJson(response.data).toEntity();
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> createPost(PostEntity post) async {
    try {
      final formData = FormData.fromMap({
        'caption': post.caption,
        'category': post.category,
        'user_id': post.userId, // Match backend field name
        if (post.images.isNotEmpty)
          'images': await Future.wait(
            post.images.map((imagePath) => MultipartFile.fromFile(imagePath)),
          ),
      });

      print('FormData fields: ${formData.fields}');
      print('FormData files: ${formData.files}');

      final response = await _dio.post(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.createPost}", // Use ApiEndpoints
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          // connectTimeout: ApiEndpoints.connectionTimeout,
          receiveTimeout: ApiEndpoints.receiveTimeout,
        ),
      );

      if (response.statusCode != 201) {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> likePost(String postId) async {
    try {
      await _dio.post("${ApiEndpoints.baseUrl}posts/$postId/like");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addComment(String postId, String commentText) async {
    try {
      await _dio.post("${ApiEndpoints.baseUrl}posts/$postId/comment",
          data: {"commentText": commentText});
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
