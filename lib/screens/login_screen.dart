
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Welcome'),
          Center(child: SignInButton(Buttons.Google, onPressed: () {
            manageLogin();
          }))
        ],
      ),
    );
  }

  manageLogin() async {
    try {
      UserCredential _user=await signInWithGoogle();
      if(_user.user!=null) {
            // FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
            //   // List<QueryDocumentSnapshot> documentSnap=event.docs.where((element) => element.data()['id']==_user.user!.uid).toList();
            //   // print(documentSnap);
            // });
      //     }else{
      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Unable to connect')));
          }
    } catch (e) {
      print(e);
    }
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
