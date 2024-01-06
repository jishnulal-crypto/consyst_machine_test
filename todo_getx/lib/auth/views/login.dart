import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/auth/auth.controller.dart';

import '../signin_enum.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = AuthController.to;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: authController.emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: authController.passwordController,
              decoration: InputDecoration(hintText: "Password"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      authController.handleSignIn(SignInType.EMAIL_PASSWORD);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.all(8),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authController.handleSignIn(SignInType.GOOGLE);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.primaries[0],
                      padding: EdgeInsets.all(8),
                    ),
                    child: Text(
                      "SignIn with Google",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed("/register");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("No account? Register Here!"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
