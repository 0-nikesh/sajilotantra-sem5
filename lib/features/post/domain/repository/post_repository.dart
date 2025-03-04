import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';

abstract class IPostRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, PostEntity?>> getPostById(String id);
  Future<Either<Failure, void>> createPost(PostEntity post);
  Future<Either<Failure, void>> likePost(String postId);
  Future<Either<Failure, void>> addComment(String postId, String commentText);
}
