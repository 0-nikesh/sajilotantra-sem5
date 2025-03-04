import 'package:equatable/equatable.dart';

import '../../domain/entity/post_entity.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch all posts
class FetchPostsEvent extends PostEvent {}

/// Event to like a post
class LikePostEvent extends PostEvent {
  final String postId;

  const LikePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

/// Event to add a comment to a post
class AddCommentEvent extends PostEvent {
  final String postId;
  final String commentText;

  const AddCommentEvent({required this.postId, required this.commentText});

  @override
  List<Object?> get props => [postId, commentText];
}

/// Event to create a new post
class CreatePostEvent extends PostEvent {
  final PostEntity post;

  const CreatePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

// Uncomment if needed
// class GetPostByIdEvent extends PostEvent {
//   final String postId;
//
//   const GetPostByIdEvent({required this.postId});
//
//   @override
//   List<Object?> get props => [postId];
// }
