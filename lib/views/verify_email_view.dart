import 'package:first_flutter_app/constants/routes.dart';
import 'package:first_flutter_app/services/auth/auth_service.dart';
import 'package:first_flutter_app/services/auth/bloc/auth_bloc.dart';
import 'package:first_flutter_app/services/auth/bloc/auth_event.dart';
import 'package:first_flutter_app/services/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, listener) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify email'),
        ),
        body: Column(
          children: [
            const Text(
                "We've sent you an email verification, Please open it to verify your account"),
            const Text(
                "If you haven't received a verification email yet, press the button below"),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventSendEmailVerification(),
                      );
                },
                child: const Text('Verify your email')),
            TextButton(
                onPressed: () async {
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: const Text('Restart'))
          ],
        ),
      ),
    );
  }
}
