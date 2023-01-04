import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_project/models/post_model.dart';
import 'package:fire_base_project/screens/add_post_screen.dart';
import 'package:fire_base_project/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';

class GetPostWithModelScreen extends StatefulWidget {
  const GetPostWithModelScreen({super.key});

  @override
  State<GetPostWithModelScreen> createState() => _GetPostWithModelScreenState();
}

class _GetPostWithModelScreenState extends State<GetPostWithModelScreen> {
  Future<List<PostModel>> getDataFromFireBase() async {
    CollectionReference postReference =
        FirebaseFirestore.instance.collection("post");
    List<PostModel> postList = [];
    await postReference.get().then((QuerySnapshot querySnapshot) {
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
    return Expanded(
      child: FutureBuilder<List<PostModel>>(
        future: getDataFromFireBase(),
        builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                PostModel detail = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return PostDetailScreen(detail: detail);
                      },
                    ));
                  },
                  title: Text(detail.title),
                  subtitle: Text(detail.body),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
