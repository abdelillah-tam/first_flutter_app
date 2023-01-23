
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter_app/constants/routes.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                      const InputDecoration(hintText: 'Enter email'),
                    ),
                    TextField(
                        controller: _password,
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:
                        const InputDecoration(hintText: 'Enter password')),
                    TextButton(
                        onPressed: () async {

                          final email = _email.text;
                          final password = _password.text;

                          final userCredential = FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                          print(userCredential);
                        },
                        child: const Text('Create an account')),
                    TextButton(onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                    }, child: const Text('Already registered? Log in here!'))
                  ],
                );
              default:
                return const Text('Loading ..');
            }
          }),
    );
  }
}
