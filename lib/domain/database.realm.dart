// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Subject extends _Subject with RealmEntity, RealmObjectBase, RealmObject {
  Subject(
    ObjectId id,
    String name,
    String ownerId, {
    Iterable<Chapter> chapters = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<Chapter>>(
        this, 'chapters', RealmList<Chapter>(chapters));
    RealmObjectBase.set(this, 'owner_id', ownerId);
  }

  Subject._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<Chapter> get chapters =>
      RealmObjectBase.get<Chapter>(this, 'chapters') as RealmList<Chapter>;
  @override
  set chapters(covariant RealmList<Chapter> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  Stream<RealmObjectChanges<Subject>> get changes =>
      RealmObjectBase.getChanges<Subject>(this);

  @override
  Stream<RealmObjectChanges<Subject>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Subject>(this, keyPaths);

  @override
  Subject freeze() => RealmObjectBase.freezeObject<Subject>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'name': name.toEJson(),
      'chapters': chapters.toEJson(),
      'owner_id': ownerId.toEJson(),
    };
  }

  static EJsonValue _toEJson(Subject value) => value.toEJson();
  static Subject _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'chapters': EJsonValue chapters,
        'owner_id': EJsonValue ownerId,
      } =>
        Subject(
          fromEJson(id),
          fromEJson(name),
          fromEJson(ownerId),
          chapters: fromEJson(chapters),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Subject._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Subject, 'Subject', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('chapters', RealmPropertyType.object,
          linkTarget: 'Chapter', collectionType: RealmCollectionType.list),
      SchemaProperty('ownerId', RealmPropertyType.string,
          mapTo: 'owner_id', indexType: RealmIndexType.regular),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Chapter extends _Chapter
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  Chapter(
    ObjectId id,
    String name, {
    Iterable<Topic> topics = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<Topic>>(
        this, 'topics', RealmList<Topic>(topics));
  }

  Chapter._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<Topic> get topics =>
      RealmObjectBase.get<Topic>(this, 'topics') as RealmList<Topic>;
  @override
  set topics(covariant RealmList<Topic> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Chapter>> get changes =>
      RealmObjectBase.getChanges<Chapter>(this);

  @override
  Stream<RealmObjectChanges<Chapter>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Chapter>(this, keyPaths);

  @override
  Chapter freeze() => RealmObjectBase.freezeObject<Chapter>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'name': name.toEJson(),
      'topics': topics.toEJson(),
    };
  }

  static EJsonValue _toEJson(Chapter value) => value.toEJson();
  static Chapter _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'topics': EJsonValue topics,
      } =>
        Chapter(
          fromEJson(id),
          fromEJson(name),
          topics: fromEJson(topics),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Chapter._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.embeddedObject, Chapter, 'Chapter', [
      SchemaProperty('id', RealmPropertyType.objectid, mapTo: '_id'),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('topics', RealmPropertyType.object,
          linkTarget: 'Topic', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Topic extends _Topic with RealmEntity, RealmObjectBase, EmbeddedObject {
  Topic(
    ObjectId id,
    String name,
    String remoteUrl, {
    String? voiceLocalPath,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'voiceLocalPath', voiceLocalPath);
    RealmObjectBase.set(this, 'remoteUrl', remoteUrl);
  }

  Topic._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get voiceLocalPath =>
      RealmObjectBase.get<String>(this, 'voiceLocalPath') as String?;
  @override
  set voiceLocalPath(String? value) =>
      RealmObjectBase.set(this, 'voiceLocalPath', value);

  @override
  String get remoteUrl =>
      RealmObjectBase.get<String>(this, 'remoteUrl') as String;
  @override
  set remoteUrl(String value) => RealmObjectBase.set(this, 'remoteUrl', value);

  @override
  Stream<RealmObjectChanges<Topic>> get changes =>
      RealmObjectBase.getChanges<Topic>(this);

  @override
  Stream<RealmObjectChanges<Topic>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Topic>(this, keyPaths);

  @override
  Topic freeze() => RealmObjectBase.freezeObject<Topic>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'name': name.toEJson(),
      'voiceLocalPath': voiceLocalPath.toEJson(),
      'remoteUrl': remoteUrl.toEJson(),
    };
  }

  static EJsonValue _toEJson(Topic value) => value.toEJson();
  static Topic _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'voiceLocalPath': EJsonValue voiceLocalPath,
        'remoteUrl': EJsonValue remoteUrl,
      } =>
        Topic(
          fromEJson(id),
          fromEJson(name),
          fromEJson(remoteUrl),
          voiceLocalPath: fromEJson(voiceLocalPath),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Topic._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.embeddedObject, Topic, 'Topic', [
      SchemaProperty('id', RealmPropertyType.objectid, mapTo: '_id'),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('voiceLocalPath', RealmPropertyType.string,
          optional: true),
      SchemaProperty('remoteUrl', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class SyncTable extends _SyncTable
    with RealmEntity, RealmObjectBase, RealmObject {
  SyncTable(
    ObjectId id,
    String topicName,
    DateTime uploadedAt,
    String syncedBy,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'topicName', topicName);
    RealmObjectBase.set(this, 'uploadedAt', uploadedAt);
    RealmObjectBase.set(this, 'syncedBy', syncedBy);
  }

  SyncTable._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get topicName =>
      RealmObjectBase.get<String>(this, 'topicName') as String;
  @override
  set topicName(String value) => RealmObjectBase.set(this, 'topicName', value);

  @override
  DateTime get uploadedAt =>
      RealmObjectBase.get<DateTime>(this, 'uploadedAt') as DateTime;
  @override
  set uploadedAt(DateTime value) =>
      RealmObjectBase.set(this, 'uploadedAt', value);

  @override
  String get syncedBy =>
      RealmObjectBase.get<String>(this, 'syncedBy') as String;
  @override
  set syncedBy(String value) => RealmObjectBase.set(this, 'syncedBy', value);

  @override
  Stream<RealmObjectChanges<SyncTable>> get changes =>
      RealmObjectBase.getChanges<SyncTable>(this);

  @override
  Stream<RealmObjectChanges<SyncTable>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<SyncTable>(this, keyPaths);

  @override
  SyncTable freeze() => RealmObjectBase.freezeObject<SyncTable>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'topicName': topicName.toEJson(),
      'uploadedAt': uploadedAt.toEJson(),
      'syncedBy': syncedBy.toEJson(),
    };
  }

  static EJsonValue _toEJson(SyncTable value) => value.toEJson();
  static SyncTable _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'topicName': EJsonValue topicName,
        'uploadedAt': EJsonValue uploadedAt,
        'syncedBy': EJsonValue syncedBy,
      } =>
        SyncTable(
          fromEJson(id),
          fromEJson(topicName),
          fromEJson(uploadedAt),
          fromEJson(syncedBy),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(SyncTable._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, SyncTable, 'SyncTable', [
      SchemaProperty('id', RealmPropertyType.objectid, mapTo: '_id'),
      SchemaProperty('topicName', RealmPropertyType.string),
      SchemaProperty('uploadedAt', RealmPropertyType.timestamp),
      SchemaProperty('syncedBy', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class LocalVoiceNote extends _LocalVoiceNote
    with RealmEntity, RealmObjectBase, RealmObject {
  LocalVoiceNote(
    ObjectId id,
    ObjectId topicId,
    String voiceLocalPath,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'topicId', topicId);
    RealmObjectBase.set(this, 'voiceLocalPath', voiceLocalPath);
  }

  LocalVoiceNote._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  ObjectId get topicId =>
      RealmObjectBase.get<ObjectId>(this, 'topicId') as ObjectId;
  @override
  set topicId(ObjectId value) => RealmObjectBase.set(this, 'topicId', value);

  @override
  String get voiceLocalPath =>
      RealmObjectBase.get<String>(this, 'voiceLocalPath') as String;
  @override
  set voiceLocalPath(String value) =>
      RealmObjectBase.set(this, 'voiceLocalPath', value);

  @override
  Stream<RealmObjectChanges<LocalVoiceNote>> get changes =>
      RealmObjectBase.getChanges<LocalVoiceNote>(this);

  @override
  Stream<RealmObjectChanges<LocalVoiceNote>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<LocalVoiceNote>(this, keyPaths);

  @override
  LocalVoiceNote freeze() => RealmObjectBase.freezeObject<LocalVoiceNote>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'topicId': topicId.toEJson(),
      'voiceLocalPath': voiceLocalPath.toEJson(),
    };
  }

  static EJsonValue _toEJson(LocalVoiceNote value) => value.toEJson();
  static LocalVoiceNote _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'topicId': EJsonValue topicId,
        'voiceLocalPath': EJsonValue voiceLocalPath,
      } =>
        LocalVoiceNote(
          fromEJson(id),
          fromEJson(topicId),
          fromEJson(voiceLocalPath),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(LocalVoiceNote._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, LocalVoiceNote, 'LocalVoiceNote', [
      SchemaProperty('id', RealmPropertyType.objectid),
      SchemaProperty('topicId', RealmPropertyType.objectid),
      SchemaProperty('voiceLocalPath', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
