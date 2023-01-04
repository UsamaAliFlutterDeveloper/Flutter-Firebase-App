import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuth {
  static CollectionReference userRefrence =
      FirebaseFirestore.instance.collection("user");
  static Future<bool> signUpUser(
      {required String email,
      required String password,
      required String fullName,
      required String phoneNo}) async {
    bool status = false;
    try {
      status = true;
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? currentUser = credential.user;
      if (currentUser != null) {
        DocumentReference currentUserReference =
            userRefrence.doc(currentUser.uid);
        Map<String, dynamic> userProfileData = {
          "name": fullName,
          "phone": phoneNo,
          "email": email,
          "password": password,
          "uid": currentUser.uid,
        };
        await currentUserReference.set(userProfileData);
      }
      status = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return status;
  }

  static Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    bool status = false;
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? currentUser = credential.user;
      // if (currentUser != null) {
      //   DocumentReference currentUserReference =
      //       userRefrence.doc(currentUser.uid);
      //   Map<String, dynamic> userProfileData = {
      //     "email": email,
      //     "password": password,
      //   };
      //   await currentUserReference.set(userProfileData);
      // }

      status = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: avoid_print
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // ignore: avoid_print
        print('Wrong password provided for that user.');
      }
    }
    return status;
  }
}
