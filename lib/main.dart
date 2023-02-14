import 'package:first_flutter_app/constants/routes.dart';
import 'package:first_flutter_app/services/auth/bloc/auth_bloc.dart';
import 'package:first_flutter_app/services/auth/bloc/auth_event.dart';
import 'package:first_flutter_app/services/auth/bloc/auth_state.dart';
import 'package:first_flutter_app/services/auth/firebase_auth_provider.dart';
import 'package:first_flutter_app/views/login_view.dart';
import 'package:first_flutter_app/views/notes/create_update_note_view.dart';
import 'package:first_flutter_app/views/notes/note_view.dart';
import 'package:first_flutter_app/views/register_view.dart';
import 'package:first_flutter_app/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
          FirebaseAuthProvider()) /* [AuthBloc] will be injected to [context]*/,
      child: const HomePage(),
    ),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      noteRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
