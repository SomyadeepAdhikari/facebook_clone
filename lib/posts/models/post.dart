import 'package:facebook_clone/core/constants/firebase_field_names.dart';
import 'package:flutter/foundation.dart';

@immutable
class Post{
  final String postId;
  final String posterId;
  final String content;
  final String fileUrl;
  final String postType;
  final DateTime createdAt;
  final List<String> likes;

  const Post( {
    required this.postId,
    required this.posterId,
    required this.content,
    required this.fileUrl,
    required this.postType,
    required this.createdAt,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.postId: postId,
      FirebaseFieldNames.posterId: posterId,
      FirebaseFieldNames.content: content,
      FirebaseFieldNames.fileUrl: fileUrl,
      FirebaseFieldNames.postType: postType,
      FirebaseFieldNames.createdAt: createdAt.millisecondsSinceEpoch,
      FirebaseFieldNames.likes: likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      likes: List<String>.from((map[FirebaseFieldNames.likes] ?? [])),
      postId: map[FirebaseFieldNames.postId] ?? '',
      posterId: map[FirebaseFieldNames.posterId] ?? '',
      content: map[FirebaseFieldNames.content] ?? '',
      fileUrl: map[FirebaseFieldNames.fileUrl] ?? '',
      postType: map[FirebaseFieldNames.postType] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[FirebaseFieldNames.createdAt] ?? 0),
    );
  }
}