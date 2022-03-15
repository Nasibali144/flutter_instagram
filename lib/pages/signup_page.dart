import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/signin_page.dart';
import 'package:flutter_instagram/services/theme_service.dart';
import 'package:flutter_instagram/services/utils.dart';
import 'package:flutter_instagram/views/button_widget.dart';
import 'package:flutter_instagram/views/textfield_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String id = "signup_page";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _openSignInPage() {
    String fullName = fullNameController.text.trim().toString();
    String email = emailController.text.trim().toString();
    String confirmPassword = confirmPasswordController.text.trim().toString();
    String password = passwordController.text.trim().toString();

    if((email.isEmpty || password.isEmpty || fullName.isEmpty || confirmPassword.isEmpty) && password == confirmPassword) {
      Utils.fireSnackBar("Please complete all the fields", context);
      return;
    }

    // server connect
    // response success
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: ThemeService.backgroundGradient,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // #app_name
                    Text("Instagram", style: TextStyle(color: Colors.white, fontSize: 45, fontFamily: ThemeService.fontHeader),),
                    SizedBox(height: 20,),

                    // #fullname
                    textField(hintText: "FullName", controller: fullNameController),
                    SizedBox(height: 10,),

                    // #email
                    textField(hintText: "Email", controller: emailController),
                    SizedBox(height: 10,),

                    // #password
                    textField(hintText: "Password", controller: passwordController),
                    SizedBox(height: 10,),

                    // #password
                    textField(hintText: "Confirm Password", controller: confirmPasswordController),
                    SizedBox(height: 10,),

                    // #signin
                    button(title: "Sign Up", onPressed: _openSignInPage),
                  ],
                ),
              ),
              RichText(text: TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.pushReplacementNamed(context, SignInPage.id);
                      },
                    )
                  ]
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
