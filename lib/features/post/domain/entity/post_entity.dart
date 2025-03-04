import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String caption;
  final String category;
  final List<String> images;
  final int likeCount;
  final List<CommentEntity> comments;
  final String userId;
  final String? username; // New field for username (fname + lname)
  final String? userImage; // New field for user image
  final DateTime createdAt;

  const PostEntity({
    required this.id,
    required this.caption,
    required this.category,
    required this.images,
    this.likeCount = 0, // Default to 0
    required this.comments,
    required this.userId,
    this.username, // Optional
    this.userImage, // Optional
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        caption,
        category,
        images,
        likeCount,
        comments,
        userId,
        username,
        userImage,
        createdAt
      ];
}

/// Fix Comment Entity
class CommentEntity extends Equatable {
  final String user;
  final String text;
  final DateTime createdAt;

  const CommentEntity({
    required this.user,
    required this.text,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [user, text, createdAt];
}
