import 'package:fire_base_project/authentication/firebase_auth.dart';
import 'package:fire_base_project/custom_widgets/textformfield_custom_widget.dart';
import 'package:fire_base_project/screens/login_screen.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('SignUpScreen'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormFieldCustomWidget(
                  hint: "Full Name",
                  iconss: const Icon(Icons.group),
                  customController: fullNameController),
              TextFormFieldCustomWidget(
                  hint: "Email",
                  iconss: const Icon(Icons.email),
                  customController: emailController),
              TextFormFieldCustomWidget(
                  hint: "Password",
                  iconss: const Icon(Icons.key),
                  customController: passwordController),
              TextFormFieldCustomWidget(
                  hint: "Phone",
                  iconss: const Icon(Icons.phone),
                  customController: phoneController),
              Container(
                  height: 50,
                  width: 120,
                  color: Colors.amber,
                  child: TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          FireBaseAuth.signUpUser(
                              email: emailController.text,
                              password: passwordController.text,
                              fullName: fullNameController.text,
                              phoneNo: phoneController.text);
                        }
                      },
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ))),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
                },
                child: const Text(
                  "Already have account?Login",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
