import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StreamNotifier<User?> {
  @override
  Stream<User?> build() {
    return FirebaseAuth.instance.authStateChanges();
  }
}

final authProvider =
    StreamNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);
