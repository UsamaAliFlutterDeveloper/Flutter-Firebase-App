import 'package:fire_base_project/custom_widgets/textformfield_custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  var firebase = FirebaseFirestore.instance;
  CollectionReference postReference =
      FirebaseFirestore.instance.collection('post');

  void addPosttofirestore(String title, String body) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    Map<String, dynamic> data = {"title": title, "body": body, "uid": uid};

    postReference
        .add(data)
        // ignore: avoid_print
        .then((value) => print("Sucessfully data uploaded"))
        // ignore: avoid_print
        .onError((error, stackTrace) => print("Error:$error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormFieldCustomWidget(
              hint: "title",
              iconss: const Icon(Icons.message),
              customController: titleController),
          const SizedBox(
            height: 15,
          ),
          TextFormFieldCustomWidget(
              hint: "body",
              iconss: const Icon(Icons.message),
              customController: bodyController),
          TextButton(
              onPressed: () {
                addPosttofirestore(titleController.text, bodyController.text);
              },
              child: const Text("Submit")),
        ],
      ),
    );
  }
}
