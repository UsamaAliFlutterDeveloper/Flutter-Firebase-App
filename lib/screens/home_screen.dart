import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_project/models/post_model.dart';
import 'package:fire_base_project/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<PostModel>> getPostofAllUsers() async {
    CollectionReference postReference =
        FirebaseFirestore.instance.collection("post");
    List<PostModel> usersPostList = [];
    await postReference.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
        usersPostList.add(PostModel.fromJson(docData, doc.id));
      }
    }).catchError((error, stackTrace) {
      // ignore: avoid_print
      print("$error");
    });
    setState(() {});
    return usersPostList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Post of Users"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<PostModel>>(
              future: getPostofAllUsers(),
              builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      PostModel detail = snapshot.data![index];
                      return Card(
                        color: Colors.amber,
                        child: ListTile(
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
              }),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(),
                ));
              },
              child: const Text(
                "Go To Profile Screen",
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
