import 'package:first_flutter_app/services/auth/auth_user.dart';

abstract class AuthProvider{
  AuthUser? get currentUser;

  Future<void> initialize();
  Future<AuthUser> logIn({required String email, required String password});
  Future<AuthUser> createUser({required String email, required String password});
  Future<void> logout();
  Future<void> sendEmailVerification();
}