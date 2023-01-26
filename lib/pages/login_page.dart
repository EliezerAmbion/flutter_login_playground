import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/my_button.dart';
import '../widgets/social_media_button.dart';

class LoginPage extends StatefulWidget {
  // final VoidCallback onClickedSignUp;

  LoginPage({
    super.key,
    // required this.onClickedSignUp,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  // sign in user
  void _login() async {
    final bool isValid = _key.currentState!.validate();

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'email and/or password incorrect!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red.shade400,
          ),
        );
      }
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
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
                  labelText: 'Email',
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email can\'t be empty';
                    }
                    if (value.isNotEmpty && !EmailValidator.validate(value)) {
                      return 'please enter a valid email';
                    }
                    return null;
                  },
                ),

                // password textfield
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password can\'t be empty';
                    }
                    return null;
                  },
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
                MyButton(onPressed: _login),

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
                    SocialMediaButton(imagePath: 'assets/images/google.png'),

                    SizedBox(width: 10),

                    // apple sign in
                    SocialMediaButton(imagePath: 'assets/images/apple.png'),
                  ],
                ),

                // not a member?
                const SizedBox(height: 50),
                RichText(
                  text: TextSpan(
                    text: 'Not a member? ',
                    style: TextStyle(color: Colors.grey.shade800),
                    children: [
                      TextSpan(
                        text: 'Register Now!',
                        // recognizer: TapGestureRecognizer()
                        //   ..onTap = widget.onClickedSignUp,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
