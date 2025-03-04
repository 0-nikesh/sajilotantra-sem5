import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/post_entity.dart';

part 'post_api_model.g.dart';

// @JsonSerializable()
// class PostApiModel {
//   @JsonKey(name: '_id', defaultValue: '') // ✅ Prevents null error
//   final String id;

//   @JsonKey(defaultValue: "No caption available") // ✅ Handles null caption
//   final String caption;

//   @JsonKey(defaultValue: "Uncategorized") // ✅ Handles null category
//   final String category;

//   @JsonKey(defaultValue: []) // ✅ Ensures an empty list if null
//   final List<String> images;

//   @JsonKey(defaultValue: 0) // ✅ Prevents null error
//   final int likeCount;

//   @JsonKey(defaultValue: []) // ✅ Ensures empty list for comments
//   final List<CommentApiModel> comments;

//   @JsonKey(name: "user_id", defaultValue: "Unknown") // ✅ Handles null user_id
//   final String userId;

//   @JsonKey(name: "created_at", fromJson: _parseDateTime) // ✅ Prevents null error
//   final DateTime createdAt;

//   const PostApiModel({
//     required this.id,
//     required this.caption,
//     required this.category,
//     required this.images,
//     required this.likeCount,
//     required this.comments,
//     required this.userId,
//     required this.createdAt,
//   });

//   /// Convert JSON to Model
//   factory PostApiModel.fromJson(Map<String, dynamic> json) =>
//       _$PostApiModelFromJson(json);

//   /// Convert Model to JSON
//   Map<String, dynamic> toJson() => _$PostApiModelToJson(this);

//   /// Convert to Entity
//   PostEntity toEntity() {
//     return PostEntity(
//       id: id.isNotEmpty ? id : "Unknown ID",
//       caption: caption.isNotEmpty ? caption : "No caption provided",
//       category: category.isNotEmpty ? category : "Uncategorized",
//       images: images.isNotEmpty ? images : [],
//       likeCount: likeCount,
//       comments: comments.map((e) => e.toEntity()).toList(),
//       userId: userId.isNotEmpty ? userId : "Unknown User",
//       createdAt: createdAt,
//     );
//   }

//   /// Convert from Entity
//   factory PostApiModel.fromEntity(PostEntity entity) {
//     return PostApiModel(
//       id: entity.id,
//       caption: entity.caption,
//       category: entity.category,
//       images: entity.images,
//       likeCount: entity.likeCount,
//       comments:
//           entity.comments.map((e) => CommentApiModel.fromEntity(e)).toList(),
//       userId: entity.userId,
//       createdAt: entity.createdAt,
//     );
//   }

//   /// ✅ Handles `null` or invalid date parsing
//   static DateTime _parseDateTime(dynamic value) {
//     if (value == null) {
//       return DateTime.now(); // Default to current time if `null`
//     }
//     return DateTime.tryParse(value.toString()) ?? DateTime.now();
//   }
// }

// /// ✅ Fix Comment API Model
// @JsonSerializable()
// class CommentApiModel {
//   @JsonKey(defaultValue: "Anonymous") // ✅ Handles null user
//   final String user;

//   @JsonKey(defaultValue: "No comment") // ✅ Handles null text
//   final String text;

//   @JsonKey(fromJson: PostApiModel._parseDateTime) // ✅ Handles null date
//   final DateTime createdAt;

//   const CommentApiModel({
//     required this.user,
//     required this.text,
//     required this.createdAt,
//   });

//   factory CommentApiModel.fromJson(Map<String, dynamic> json) =>
//       _$CommentApiModelFromJson(json);
//   Map<String, dynamic> toJson() => _$CommentApiModelToJson(this);

//   CommentEntity toEntity() {
//     return CommentEntity(
//       user: user.isNotEmpty ? user : "Anonymous",
//       text: text.isNotEmpty ? text : "No comment",
//       createdAt: createdAt,
//     );
//   }

//   factory CommentApiModel.fromEntity(CommentEntity entity) {
//     return CommentApiModel(
//       user: entity.user,
//       text: entity.text,
//       createdAt: entity.createdAt,
//     );
//   }
// }

// @JsonSerializable()
// class PostApiModel {
//   @JsonKey(name: '_id', defaultValue: '') // Prevents null error
//   final String id;

//   @JsonKey(defaultValue: "No caption available") // Handles null caption
//   final String caption;

//   @JsonKey(defaultValue: "Uncategorized") // Handles null category
//   final String category;

//   @JsonKey(defaultValue: []) // Ensures an empty list if null
//   final List<String> images;

//   @JsonKey(
//       name: "like_count", defaultValue: 0) // Maps "like_count" to likeCount
//   final int likeCount;

//   @JsonKey(defaultValue: []) // Ensures empty list for comments
//   final List<CommentApiModel> comments;

//   @JsonKey(name: "user_id") // Handles nested user_id object
//   final UserApiModel userId;

//   @JsonKey(name: "created_at", fromJson: _parseDateTime) // Prevents null error
//   final DateTime createdAt;

//   const PostApiModel({
//     required this.id,
//     required this.caption,
//     required this.category,
//     required this.images,
//     required this.likeCount,
//     required this.comments,
//     required this.userId,
//     required this.createdAt,
//   });

//   factory PostApiModel.fromJson(Map<String, dynamic> json) =>
//       _$PostApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$PostApiModelToJson(this);

//   PostEntity toEntity() {
//     return PostEntity(
//       id: id.isNotEmpty ? id : "Unknown ID",
//       caption: caption.isNotEmpty ? caption : "No caption provided",
//       category: category.isNotEmpty ? category : "Uncategorized",
//       images: images.isNotEmpty ? images : [],
//       likeCount: likeCount,
//       comments: comments.map((e) => e.toEntity()).toList(),
//       userId: userId.id, // Extract the user ID from the nested object
//       createdAt: createdAt,
//     );
//   }

//   factory PostApiModel.fromEntity(PostEntity entity) {
//     return PostApiModel(
//       id: entity.id,
//       caption: entity.caption,
//       category: entity.category,
//       images: entity.images,
//       likeCount: entity.likeCount,
//       comments:
//           entity.comments.map((e) => CommentApiModel.fromEntity(e)).toList(),
//       userId: UserApiModel(id: entity.userId),
//       createdAt: entity.createdAt,
//     );
//   }

//   static DateTime _parseDateTime(dynamic value) {
//     if (value == null) {
//       return DateTime.now(); // Default to current time if `null`
//     }
//     return DateTime.tryParse(value.toString()) ?? DateTime.now();
//   }
// }

// @JsonSerializable()
// class UserApiModel {
//   @JsonKey(name: '_id', defaultValue: 'Unknown') // Prevents null error
//   final String id;

//   const UserApiModel({required this.id});

//   factory UserApiModel.fromJson(Map<String, dynamic> json) =>
//       _$UserApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$UserApiModelToJson(this);
// }

// @JsonSerializable()
// class CommentApiModel {
//   @JsonKey(defaultValue: "Anonymous") // Handles null user
//   final String user;

//   @JsonKey(defaultValue: "No comment") // Handles null text
//   final String text;

//   @JsonKey(
//       name: "createdAt",
//       fromJson: PostApiModel._parseDateTime) // Matches JSON key
//   final DateTime createdAt;

//   const CommentApiModel({
//     required this.user,
//     required this.text,
//     required this.createdAt,
//   });

//   factory CommentApiModel.fromJson(Map<String, dynamic> json) =>
//       _$CommentApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$CommentApiModelToJson(this);

//   CommentEntity toEntity() {
//     return CommentEntity(
//       user: user.isNotEmpty ? user : "Anonymous",
//       text: text.isNotEmpty ? text : "No comment",
//       createdAt: createdAt,
//     );
//   }

//   factory CommentApiModel.fromEntity(CommentEntity entity) {
//     return CommentApiModel(
//       user: entity.user,
//       text: entity.text,
//       createdAt: entity.createdAt,
//     );
//   }
// }

@JsonSerializable()
class PostApiModel {
  @JsonKey(name: '_id', defaultValue: '') // Prevents null error
  final String id;

  @JsonKey(defaultValue: "No caption available") // Handles null caption
  final String caption;

  @JsonKey(defaultValue: "Uncategorized") // Handles null category
  final String category;

  @JsonKey(defaultValue: []) // Ensures an empty list if null
  final List<String> images;

  @JsonKey(
      name: "like_count", defaultValue: 0) // Maps "like_count" to likeCount
  final int likeCount;

  @JsonKey(defaultValue: []) // Ensures empty list for comments
  final List<CommentApiModel> comments;

  @JsonKey(name: "user_id") // Handles nested user_id object
  final UserApiModel userId;

  @JsonKey(name: "created_at", fromJson: _parseDateTime) // Prevents null error
  final DateTime createdAt;

  const PostApiModel({
    required this.id,
    required this.caption,
    required this.category,
    required this.images,
    required this.likeCount,
    required this.comments,
    required this.userId,
    required this.createdAt,
  });

  factory PostApiModel.fromJson(Map<String, dynamic> json) =>
      _$PostApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostApiModelToJson(this);

  PostEntity toEntity() {
    return PostEntity(
      id: id.isNotEmpty ? id : "Unknown ID",
      caption: caption.isNotEmpty ? caption : "No caption provided",
      category: category.isNotEmpty ? category : "Uncategorized",
      images: images.isNotEmpty ? images : [],
      likeCount: likeCount,
      comments: comments.map((e) => e.toEntity()).toList(),
      userId: userId.id, // Keep userId as the _id for compatibility
      username: '${userId.fname} ${userId.lname}'
          .trim(), // Combine fname and lname for username
      userImage: userId.image, // Use user image from the JSON
      createdAt: createdAt,
    );
  }

  factory PostApiModel.fromEntity(PostEntity entity) {
    return PostApiModel(
      id: entity.id,
      caption: entity.caption,
      category: entity.category,
      images: entity.images,
      likeCount: entity.likeCount,
      comments:
          entity.comments.map((e) => CommentApiModel.fromEntity(e)).toList(),
      userId: UserApiModel(
        id: entity.userId,
        fname: entity.username?.split(' ').first ?? 'Unknown',
        lname: entity.username?.split(' ').last ?? 'User',
        image: entity.userImage ?? '',
      ),
      createdAt: entity.createdAt,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now(); // Default to current time if `null`
    }
    return DateTime.tryParse(value.toString()) ?? DateTime.now();
  }
}

@JsonSerializable()
class UserApiModel {
  @JsonKey(name: '_id', defaultValue: 'Unknown') // Prevents null error
  final String id;

  @JsonKey(name: 'fname', defaultValue: 'Unknown') // Handles null fname
  final String fname;

  @JsonKey(name: 'lname', defaultValue: 'User') // Handles null lname
  final String lname;

  @JsonKey(name: 'image', defaultValue: '') // Handles null image
  final String image;

  const UserApiModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.image,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);
}

@JsonSerializable()
class CommentApiModel {
  @JsonKey(defaultValue: "Anonymous") // Handles null user
  final String user;

  @JsonKey(defaultValue: "No comment") // Handles null text
  final String text;

  @JsonKey(
      name: "createdAt",
      fromJson: PostApiModel._parseDateTime) // Matches JSON key
  final DateTime createdAt;

  const CommentApiModel({
    required this.user,
    required this.text,
    required this.createdAt,
  });

  factory CommentApiModel.fromJson(Map<String, dynamic> json) =>
      _$CommentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentApiModelToJson(this);

  CommentEntity toEntity() {
    return CommentEntity(
      user: user.isNotEmpty ? user : "Anonymous",
      text: text.isNotEmpty ? text : "No comment",
      createdAt: createdAt,
    );
  }

  factory CommentApiModel.fromEntity(CommentEntity entity) {
    return CommentApiModel(
      user: entity.user,
      text: entity.text,
      createdAt: entity.createdAt,
    );
  }
}
