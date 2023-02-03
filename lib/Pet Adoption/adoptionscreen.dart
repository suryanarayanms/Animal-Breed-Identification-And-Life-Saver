import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_dog_project/Pet%20Adoption/auth_service.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({Key key}) : super(key: key);

  @override
  State<AdoptionScreen> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(FirebaseAuth.instance.currentUser.uid),
            GestureDetector(
              onTap: () => {AuthService().signOut()},
              child: Icon(
                Icons.note,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
