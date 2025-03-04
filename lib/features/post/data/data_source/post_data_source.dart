import '../../domain/entity/post_entity.dart';

abstract class IPostDataSource {
  Future<List<PostEntity>> getAllPosts();
  Future<PostEntity?> getPostById(String id);
  Future<void> createPost(PostEntity post);
  Future<void> likePost(String postId);
  Future<void> addComment(String postId, String commentText);
}
