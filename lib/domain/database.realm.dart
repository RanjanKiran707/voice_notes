// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Subject extends _Subject with RealmEntity, RealmObjectBase, RealmObject {
  Subject(
    ObjectId id,
    String name, {
    Iterable<Chapter> chapters = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<Chapter>>(
        this, 'chapters', RealmList<Chapter>(chapters));
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
    };
  }

  static EJsonValue _toEJson(Subject value) => value.toEJson();
  static Subject _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'chapters': EJsonValue chapters,
      } =>
        Subject(
          fromEJson(id),
          fromEJson(name),
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
