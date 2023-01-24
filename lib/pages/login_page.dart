import 'package:flutter/material.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/signin_btn.dart';
import '../widgets/social_media_signin_btn.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // sign in user
  void _signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              const SizedBox(height: 50),
              const Icon(
                Icons.lock,
                size: 100,
              ),

              // welcome back message
              const SizedBox(height: 50),
              Text(
                'Welcome back! You have been missed!',
                style: TextStyle(color: Colors.grey[700]),
              ),

              // email textfield
              const SizedBox(height: 35),
              CustomTextField(
                controller: _emailController,
                hintText: 'email',
                obscureText: false,
              ),

              // password textfield
              const SizedBox(height: 10),
              CustomTextField(
                controller: _passwordController,
                hintText: 'password',
                obscureText: true,
              ),

              // forgot password
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
              ),

              // signin btn
              const SizedBox(height: 15),
              SignInButton(onPressed: _signUserIn),

              // or Continue with
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with:',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),

              // google and apple sign in btns
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // google sign in
                  SocialMediaSignInButtons(
                      imagePath: 'assets/images/google.png'),

                  SizedBox(width: 10),

                  // apple sign in
                  SocialMediaSignInButtons(
                      imagePath: 'assets/images/apple.png'),
                ],
              ),

              // not a member?
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register Now!',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
