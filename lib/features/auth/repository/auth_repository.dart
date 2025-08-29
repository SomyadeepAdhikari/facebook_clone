import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/constants/firebases_collection_names.dart';
import 'package:facebook_clone/core/constants/storage_folder_names.dart';
import 'package:facebook_clone/features/auth/models/user.dart';
import 'package:facebook_clone/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  // This class will handle authentication-related operations
  // such as sign in, sign up, sign out, and user management.

  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    // Implement sign-in logic here
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credentials;
    } catch (e) {
      // Handle sign-in errors
      showToastMessage(text: 'Sign-in failed');
      return null;
    }
  }

  // Example method for creating a new account
  Future<UserCredential?> createAccount({
    required String fullName,
    required String email,
    required String password,
    required DateTime birthday,
    required String gender,
    required File? image,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Upload the profile image to Firebase Storage
      final path = _storage
          .ref(StorageFolderNames.profilePics)
          .child(FirebaseAuth.instance.currentUser!.uid);
      if (image == null) {
        return null;
      }

      final taskSnapshot = await path.putFile(image);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      UserModel user = UserModel(
        fullName: fullName,
        email: email,
        birthday: birthday,
        gender: gender,
        password: password,
        profilePicUrl: downloadUrl,
        uid: FirebaseAuth.instance.currentUser!.uid,
        friends: [],
        sentRequests: [],
        receivedRequests: [],
      );
      // Save the user data to Firestore or Realtime Database
      await _firestore
          .collection(FirebasesCollectionNames.users)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toMap());
      return credential;
    } catch (e) {
      showToastMessage(text: e.toString());
      return null;
    }
  }

  // Verify email
  Future<String?> verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        user.sendEmailVerification();
      }
      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  // get user info
  Future<UserModel?> getUserInfo() async{
    final userData = await _firestore
        .collection(FirebasesCollectionNames.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final user = UserModel.fromMap(userData.data()!);
    return user;
  }

  // Example method for signing out the current user
  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return 'Sign-out successful';
    } catch (e) {
      showToastMessage(text: 'Sign-out failed');
      return null;
    }
  }
}
