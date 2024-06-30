import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:riverpod/riverpod.dart';
import 'package:voice_notes/domain/database.dart';

class ChapterListNotifier
    extends FamilyStreamNotifier<RealmListChanges<Chapter>, Subject> {
  @override
  Stream<RealmListChanges<Chapter>> build(Subject arg) {
    return arg.chapters.changes;
  }
}

final chapterListNotifierProvider = StreamNotifierProviderFamily<
    ChapterListNotifier,
    RealmListChanges<Chapter>,
    Subject>(ChapterListNotifier.new);
