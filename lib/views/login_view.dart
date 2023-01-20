import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(title: Text('Login')),
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
                          try {
                            final email = _email.text;
                            final password = _password.text;

                            final userCredential = FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: email, password: password);
                            print(userCredential);
                          } on FirebaseAuthException catch(e){
                            if(e.code == 'user-not-found') {
                              print(e.code);
                            }
                          }
                        },
                        child: const Text('Login')),
                  ],
                );
              default:
                return const Text('Loading ..');
            }
          }),
    );
  }
}
