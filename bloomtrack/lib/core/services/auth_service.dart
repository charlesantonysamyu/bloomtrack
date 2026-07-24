import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

      if (!canAuthenticate) {
        return false;
      }

      return await _auth.authenticate(
        localizedReason: 'Please authenticate to access BloomTrack',
      );
    } on PlatformException catch (e) {
      debugPrint('Auth PlatformException: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Auth Exception: $e');
      return false;
    }
  }
}
