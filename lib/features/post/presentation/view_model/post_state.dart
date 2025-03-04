import 'package:equatable/equatable.dart';

import '../../domain/entity/post_entity.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the post feature
class PostInitial extends PostState {}

/// State when posts are being loaded
class PostLoading extends PostState {}

/// State when posts are successfully loaded
class PostLoaded extends PostState {
  final List<PostEntity> posts;

  const PostLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

/// State when an error occurs
class PostError extends PostState {
  final String message;

  const PostError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// State when a post is successfully created
class PostCreated extends PostState {}

/// State when a post is liked
class PostLiked extends PostState {}

/// State when a comment is added
class CommentAdded extends PostState {}

// Uncomment if needed
// class PostByIdLoaded extends PostState {
//   final PostEntity post;
//
//   const PostByIdLoaded({required this.post});
//
//   @override
//   List<Object?> get props => [post];
// }
