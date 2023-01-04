import 'package:fire_base_project/authentication/firebase_auth.dart';
import 'package:fire_base_project/custom_widgets/textformfield_custom_widget.dart';
import 'package:fire_base_project/screens/sign_up_screen.dart';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Login Screen"),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormFieldCustomWidget(
                    hint: "Email",
                    iconss: const Icon(Icons.email),
                    customController: emailController),
                const SizedBox(height: 15),
                TextFormFieldCustomWidget(
                    hint: "Password",
                    iconss: const Icon(Icons.key),
                    customController: passwordController),
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  width: 120,
                  color: Colors.amber,
                  child: TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          FireBaseAuth.loginUser(
                              email: emailController.text,
                              password: passwordController.text);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ));
                    },
                    child: const Text(
                      "Don't have a account? SignUp",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
