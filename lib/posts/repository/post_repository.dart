import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/constants/firebases_collection_names.dart';
import 'package:facebook_clone/posts/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';

@immutable
class PostRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // make post
  Future<String?> makePost({
    required String content,
    required File file,
    required String postType,
  }) async {
    try {
      final postId = const Uuid().v1();
      final posterId = _auth.currentUser!.uid;
      final now = DateTime.now();

      // Post file to Storage
      final fileUid = const Uuid().v1();
      final path = _storage.ref(postType).child(fileUid);
      final taskSnapshot = await path.putFile(file);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // create our post
      Post post = Post(
        postId: postId,
        posterId: posterId,
        content: content,
        fileUrl: downloadUrl,
        postType: postType,
        createdAt: now,
        likes: [],
      );

      // Post  to firestore
      await _firestore.collection('posts').doc(postId).set(post.toMap());

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Like a post
  Future<String?> likeDislikePost({
    required String postId,
    required List<String> likes,
  }) async {
    try {
        final authorId = _auth.currentUser!.uid;
        if(likes.contains(authorId)){
          // dislike the post
          _firestore.collection(FirebasesCollectionNames.posts).doc(postId).update({
            'likes': FieldValue.arrayRemove([authorId])
          });
        } else {
          // like the post
            _firestore.collection(FirebasesCollectionNames.posts).doc(postId).update({
                'likes': FieldValue.arrayUnion([authorId])
            });
        }
        return null;
    } catch (e) {
      return e.toString();
    }
  }
}
