import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_project/models/post_model.dart';
import 'package:fire_base_project/screens/add_post_screen.dart';
import 'package:fire_base_project/screens/post_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SpecificUserPostScreen extends StatefulWidget {
  const SpecificUserPostScreen({super.key});

  @override
  State<SpecificUserPostScreen> createState() => _SpecificUserPostScreenState();
}

class _SpecificUserPostScreenState extends State<SpecificUserPostScreen> {
  Future<List<PostModel>> getDataFromFireBase() async {
    List<PostModel> postList = [];

    CollectionReference postReference =
        FirebaseFirestore.instance.collection("post");
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';
    if (user != null) {
      uid = user.uid;
    }
    await postReference
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
        postList.add(PostModel.fromJson(docData, doc.id));
      }
    }).catchError((error, stackTrace) {
      // ignore: avoid_print
      print("$error");
    });
    setState(() {});
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        FutureBuilder<List<PostModel>>(
          future: getDataFromFireBase(),
          builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  PostModel detail = snapshot.data![index];
                  return Card(
                    color: Colors.amber,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return PostDetailScreen(detail: detail);
                          },
                        ));
                      },
                      title: Text(detail.title),
                      subtitle: Text(detail.body),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        Container(
            height: 50,
            width: 120,
            color: Colors.amber,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddPostScreen(),
                  ));
                },
                child: const Text(
                  "Add Post",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )))
      ],
    ));
  }
}
