import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_project/custom_widgets/textformfield_custom_widget.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TextformFieldScreen extends StatefulWidget {
  const TextformFieldScreen({super.key});

  @override
  State<TextformFieldScreen> createState() => _TextformFieldScreenState();
}

class _TextformFieldScreenState extends State<TextformFieldScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController fathernameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // var firebase = FirebaseFirestore.instance;
  // CollectionReference postReference =
  //     FirebaseFirestore.instance.collection('post');
  // void addPosttofirestore(String title, String body) async {
  //   Map<String, dynamic> data = {"title": title, "body": body};
  //   postReference
  //       .add(data)
  //       // ignore: avoid_print
  //       .then((value) => print("Sucessfully data uploaded"))
  //       // ignore: avoid_print
  //       .onError((error, stackTrace) => print("Error:$error"));
  // }

  CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');
  void addUserdatatofirestore(String username, String fathername, String city,
      String phoneno, String cnic) async {
    Map<String, dynamic> data = {
      "username": username,
      "fathername": fathername,
      "city": city,
      "phoneno": phoneno,
      "cnic": cnic
    };
    userReference
        .add(data)
        // ignore: avoid_print
        .then((value) => print("Successfully Data Updated"))
        // ignore: avoid_print
        .onError((error, stackTrace) => print("error:$error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User Screen"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormFieldCustomWidget(
                    hint: "username",
                    iconss: const Icon(Icons.group),
                    customController: usernameController),
                TextFormFieldCustomWidget(
                  hint: "fathername",
                  iconss: const Icon(Icons.group),
                  customController: fathernameController,
                ),
                TextFormFieldCustomWidget(
                    hint: "city",
                    iconss: const Icon(Icons.location_city),
                    customController: cityController),
                TextFormFieldCustomWidget(
                    hint: "phoneno",
                    iconss: const Icon(Icons.phone),
                    customController: phoneController),
                TextFormFieldCustomWidget(
                    hint: "cnic",
                    iconss: const Icon(Icons.numbers),
                    customController: cnicController),
                Container(
                  height: 50,
                  width: 120,
                  color: Colors.amber,
                  child: TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          addUserdatatofirestore(
                            usernameController.text,
                            fathernameController.text,
                            cityController.text,
                            phoneController.text,
                            cnicController.text,
                          );
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
