import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voice_notes/injection.dart';

class RealmInitNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return injectRealmDependency();
  }
}

final realmInitProvider =
    AsyncNotifierProvider<RealmInitNotifier, void>(RealmInitNotifier.new);
