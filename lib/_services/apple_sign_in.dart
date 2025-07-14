import 'dart:io' show Platform;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInService {

  static Future<AuthorizationCredentialAppleID> login() {
    return SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // Required for Android
      webAuthenticationOptions: Platform.isAndroid
          ? WebAuthenticationOptions(
              clientId:
                  'com.oneuser.oneuser', // Your Service ID from Apple Dev Portal
              redirectUri: Uri.parse(
                  'https://example.com/callbacks/sign_in_with_apple'), // Match your Apple Service ID setup
            )
          : null,
    );
  }
}
