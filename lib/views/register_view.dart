import 'package:first_flutter_app/constants/routes.dart';
import 'package:first_flutter_app/services/auth/auth_service.dart';
import 'package:first_flutter_app/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import '../services/auth/auth_exceptions.dart';

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
          future: AuthService.firebase().initialize(),
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
                          try {
                            await AuthService.firebase().createUser(
                              email: email,
                              password: password,
                            );

                            await AuthService.firebase()
                                .sendEmailVerification();
                            Navigator.of(context).pushNamed(verifyEmailRoute);
                          } on WeakPasswordAuthException catch (e) {
                            await showErrorDialog(
                              context,
                              'Weak password',
                            );
                          } on EmailAlreadyInUseAuthException catch (e) {
                            await showErrorDialog(
                              context,
                              'Email is already in use',
                            );
                          } on InvalidEmailAuthException catch (e) {
                            await showErrorDialog(
                              context,
                              'Invalid email address',
                            );
                          } on GenericAuthException catch (e) {
                            await showErrorDialog(
                              context,
                              'Failed to register',
                            );
                          }
                          ;
                        },
                        child: const Text('Create an account')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              loginRoute, (route) => false);
                        },
                        child: const Text('Already registered? Log in here!'))
                  ],
                );
              default:
                return const Text('Loading ..');
            }
          }),
    );
  }
}
