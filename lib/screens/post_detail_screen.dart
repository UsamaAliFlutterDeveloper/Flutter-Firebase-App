import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_project/models/post_model.dart';
import 'package:fire_base_project/custom_widgets/textformfield_custom_widget.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final PostModel detail;
  const PostDetailScreen({super.key, required this.detail});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  TextEditingController commentController = TextEditingController();
  CollectionReference commentReference =
      FirebaseFirestore.instance.collection("comments");
  Future<bool> addCommentToPost() async {
    Map<String, dynamic> commentData = {
      "PostId": widget.detail.id,
      "comments": commentController.text,
    };
    bool status = false;
    commentReference.add(commentData).then((value) {
      status = true;
    }).onError((error, stackTrace) {
      status = false;
    });
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.amber,
                child: Column(
                  children: [
                    Text(widget.detail.title),
                    Text(widget.detail.body),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormFieldCustomWidget(
                  hint: "comments",
                  iconss: const Icon(Icons.comment),
                  customController: commentController),
              TextButton(
                  onPressed: () async {
                    bool status = await addCommentToPost();
                    // ignore: avoid_print
                    print("status: $status");
                    if (status) {
                      // ignore: avoid_print
                      print("posted");
                    } else {
                      // ignore: avoid_print
                      print("error");
                    }
                  },
                  child: const Text("Add Comments")),
              FutureBuilder<QuerySnapshot>(
                future: commentReference
                    .where("PostId", isEqualTo: widget.detail.id)
                    .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data!.docs[index]["comments"]),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
