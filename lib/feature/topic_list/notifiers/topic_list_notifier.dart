import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:riverpod/riverpod.dart';
import 'package:voice_notes/domain/database.dart';

class TopicListNotifier
    extends FamilyStreamNotifier<RealmListChanges<Topic>, Chapter> {
  @override
  Stream<RealmListChanges<Topic>> build(Chapter arg) {
    return arg.topics.changes;
  }
}

final topicListNotifierProvider = StreamNotifierProviderFamily<
    TopicListNotifier,
    RealmListChanges<Topic>,
    Chapter>(TopicListNotifier.new);
