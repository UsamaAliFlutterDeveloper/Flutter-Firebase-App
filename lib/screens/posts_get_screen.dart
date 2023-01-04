import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  CollectionReference postReference =
      FirebaseFirestore.instance.collection("post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post List"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: postReference.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data!.docs[index]["title"]),
                          subtitle: Text(snapshot.data!.docs[index]["body"]),
                        );
                      },
                    );
                  }
                }
                return const Text("Loading....");
              },
            ),
            // ignore: sized_box_for_whitespace
          ],
        ));
  }
}
