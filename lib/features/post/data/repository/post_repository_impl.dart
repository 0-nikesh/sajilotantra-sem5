import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/repository/post_repository.dart';
import '../data_source/post_data_source.dart';

class PostRepositoryImpl implements IPostRepository {
  final IPostDataSource _postDataSource;

  PostRepositoryImpl({required IPostDataSource postDataSource}) : _postDataSource = postDataSource;

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    try {
      final posts = await _postDataSource.getAllPosts();
      return Right(posts);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostEntity?>> getPostById(String id) async {
    try {
      final post = await _postDataSource.getPostById(id);
      return Right(post);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createPost(PostEntity post) async {
    try {
      await _postDataSource.createPost(post);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likePost(String postId) async {
    try {
      await _postDataSource.likePost(postId);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addComment(String postId, String commentText) async {
    try {
      await _postDataSource.addComment(postId, commentText);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
