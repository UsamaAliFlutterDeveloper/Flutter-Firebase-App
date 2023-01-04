import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_project/models/user_model_firebase.dart';
import 'package:fire_base_project/screens/specific_user_post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  CollectionReference userReference =
      FirebaseFirestore.instance.collection("user");
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "User Profile Screen",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        FutureBuilder<DocumentSnapshot>(
            future: userReference.doc(user!.uid).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                UserModelFireBase detail =
                    UserModelFireBase.fromJson(data, snapshot.data!.id);

                return Card(
                  color: Colors.amber,
                  child: Column(
                    children: [
                      Text(detail.name),
                      Text(detail.email),
                      Text(detail.password),
                      Text(detail.phone),
                    ],
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
        Expanded(child: SpecificUserPostScreen()),
      ]),
    );
  }
}
