import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/home_page.dart';
import 'package:flutter_instagram/pages/signup_page.dart';
import 'package:flutter_instagram/services/auth_service.dart';
import 'package:flutter_instagram/services/pref_service.dart';
import 'package:flutter_instagram/services/theme_service.dart';
import 'package:flutter_instagram/services/utils.dart';
import 'package:flutter_instagram/views/button_widget.dart';
import 'package:flutter_instagram/views/textfield_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String id = "signin_page";

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void _openHomePage() async {
    String email = emailController.text.trim().toString();
    String password = passwordController.text.trim().toString();

    if(email.isEmpty || password.isEmpty) {
      Utils.fireSnackBar("Please complete all the fields", context);
      return;
    }

    setState(() {
      isLoading = true;
    });

    await AuthService.signInUser(email, password).then((response) {
      _getFirebaseUser(response);
    });
  }

  void _getFirebaseUser(Map<String, User?> map) async {
    setState(() {
      isLoading = false;
    });

    if(!map.containsKey("SUCCESS")) {
      if(map.containsKey("user-not-found")) Utils.fireSnackBar("No user found for that email.", context);
      if(map.containsKey("wrong-password")) Utils.fireSnackBar("Wrong password provided for that user.", context);
      if(map.containsKey("ERROR")) Utils.fireSnackBar("Check Your Information.", context);
      return;
    }

    User? user = map["SUCCESS"];
    if(user == null) return;

    await Prefs.store(StorageKeys.UID, user.uid);
    Navigator.pushReplacementNamed(context, HomePage.id);
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

                    // #email
                    textField(hintText: "Email", controller: emailController),
                    SizedBox(height: 10,),

                    // #password
                    textField(hintText: "Password", controller: passwordController),
                    SizedBox(height: 10,),

                    // #signin
                    button(title: "Sign In", onPressed: _openHomePage),
                  ],
                ),
              ),
              RichText(text: TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.pushReplacementNamed(context, SignUpPage.id);
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
