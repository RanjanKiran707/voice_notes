import 'package:realm/realm.dart'; // import realm package

part 'database.realm.dart'; // declare a part file.

@RealmModel()
class _Subject {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String name;
  late List<_Chapter> chapters;

  @Indexed()
  @MapTo("owner_id")
  late String ownerId;
}

@RealmModel(ObjectType.embeddedObject)
class _Chapter {
  @MapTo("_id")
  late ObjectId id;
  late String name;

  late List<_Topic> topics;
}

@RealmModel(ObjectType.embeddedObject)
class _Topic {
  @MapTo("_id")
  late ObjectId id;
  late String name;
  late String? voiceLocalPath;
  late String remoteUrl;
}

@RealmModel()
class _SyncTable {
  @MapTo("_id")
  late ObjectId id;
  late String topicName;
  late DateTime uploadedAt;
  late String syncedBy;
}

@RealmModel()
class _LocalVoiceNote {
  late ObjectId id;
  late ObjectId topicId;
  late String voiceLocalPath;
}
