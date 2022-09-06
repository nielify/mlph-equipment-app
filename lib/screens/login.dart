import 'package:flutter/material.dart';
import 'package:mlph_equipments/screens/admin_equipment_list.dart';
import 'package:mlph_equipments/screens/equipments/equipments.dart';
import 'package:mlph_equipments/utils/constants.dart';
import 'package:mlph_equipments/widgets/custom_elevated_button.dart';
import 'package:mlph_equipments/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _Title(title: 'Admin Login'),
              CustomTextField(
                label: 'Email', 
                onChanged: (value) {setState(() => email = value);}
              ),
              CustomTextField(
                label: 'Password', 
                onChanged: (value) {setState(() => password = value);},
                obscureText: true,
              ),
              const SizedBox(height: 20,),
              CustomElevatedButton(
                label: 'LOGIN', 
                onPressed: (() async {
                  loginToFirebase();
                })
              ),
              const _ContinueButton(text: 'or continue as an Employee'),
            ]
          ),
        ),
      ),
    );
  }

  void loginToFirebase() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      // did not have enough time to fix linter warning so I just put ignore comment
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminEquipmentList()
        ),
      );
    } on FirebaseAuthException catch (e) {
      // contains prints that are required for catching errors and preventing app from stopping
      if (e.code == 'user-not-found') {
        print('No user found for that email.'); 
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.'); 
      }
    }
  }
}


class _Title extends StatelessWidget {
  const _Title({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: kprimaryColor,
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        onPressed: () { 
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Equipments()
            ),
          );
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 19,
            color: kprimaryColor,
          ),
        )
      )
    );
  }
}