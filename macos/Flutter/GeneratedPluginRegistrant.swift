//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
import firebase_auth
import firebase_core
import firebase_storage
import just_audio
import path_provider_foundation
import realm
import record_darwin

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FLTFirebaseStoragePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseStoragePlugin"))
  JustAudioPlugin.register(with: registry.registrar(forPlugin: "JustAudioPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  RealmPlugin.register(with: registry.registrar(forPlugin: "RealmPlugin"))
  RecordPlugin.register(with: registry.registrar(forPlugin: "RecordPlugin"))
}
