import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:the_dog_project/Pet%20Adoption/adoptionscreen.dart';
import 'package:the_dog_project/Pet%20Adoption/login.dart';
import 'package:the_dog_project/Pet%20Adoption/theme.dart';

String name;
String uid;
String email;
String data;
String profile;

class AuthService {
// keytool -exportcert -list -v -alias upload-keystore -keystore C:/Users/Acer/upload-keystore.jks
  //Determine if the user is authenticated.
  Widget handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            name = FirebaseAuth.instance.currentUser.displayName;
            uid = FirebaseAuth.instance.currentUser.uid;
            email = FirebaseAuth.instance.currentUser.email;
            profile = FirebaseAuth.instance.currentUser.photoURL;
            context.read<TemporaryData>().retrieveData(uid);

//new user
            if (context.watch<TemporaryData>().name != name) {
              FirebaseFirestore.instance.collection("users").doc(uid).set({
                "uid": uid,
                "name": name,
                "email": email,
                "accountName": name,
                "theme": true,
              });
              print('new user');
            } else {
              print('old user');
            }
//old user

            // late DocumentReference documentReference =
            //     FirebaseFirestore.instance.collection("users").doc();
            return const AdoptionScreen();
          } else {
            return const Login();
          }
        });
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign out
  signOut() async {
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    String name = '';
    String uid = '';
    String data = '';
    String email = '';
    String profile = '';
  }
}
