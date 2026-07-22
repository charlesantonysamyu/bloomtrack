import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages the database encryption key using platform-secure storage.
///
/// On first launch a cryptographically-random 32-byte hex key is generated and
/// persisted in the device's secure enclave / keystore. Subsequent calls return
/// the same key so the database can be decrypted across app restarts.
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _dbKeyName = 'bloomtrack_db_key';

  /// Returns the existing database encryption key, or generates and stores a
  /// new one if none exists yet.
  Future<String> getOrCreateDatabaseKey() async {
    final existing = await _storage.read(key: _dbKeyName);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final key = _generateHexKey(32);
    await _storage.write(key: _dbKeyName, value: key);
    return key;
  }

  /// Deletes the stored encryption key.
  ///
  /// **Caution**: calling this will make any previously-encrypted database
  /// unreadable.
  Future<void> deleteDatabaseKey() async {
    await _storage.delete(key: _dbKeyName);
  }

  /// Generates a random hex string of [byteLength] bytes (i.e. the returned
  /// string is `byteLength * 2` characters long).
  String _generateHexKey(int byteLength) {
    final random = Random.secure();
    final bytes = List<int>.generate(byteLength, (_) => random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
