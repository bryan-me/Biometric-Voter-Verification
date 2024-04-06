
// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  static Future<bool> authenticateUser() async {

    //for status of authentication
    bool isAuthenticated = false;

    //initialize the LocalAuthentication plugin
    final LocalAuthentication auth = LocalAuthentication();

bool isBioSupported=false;

    bool canCheckBiometrics = false;



    try {
    //check if device supports biometrics authentication.

      isBioSupported=await auth.isDeviceSupported();


      //to check if user activated biometrics
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biome trics $e");
    }

    // enumerate biometric technologies
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {
        print("\ttech: $ab");
      });
    } else {
      print("no biometrics are available");
    }

    // authenticate with biometrics
    
    bool authenticated = false;

if(isBioSupported&&canCheckBiometrics){
try {
      isAuthenticated = await auth.authenticate(
        localizedReason: 'Complete the biometrics to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: false,
          stickyAuth: true,
        ),
      );
      if (isAuthenticated) {
      String? userData = await _readUserDataFromSDCard();
      if (userData != null) {
        // Handle user data (e.g., show in a dedicated screen)
        print('User data: $userData');
        // ... (show user data in UI)
      } else {
        print('User data not found on SD card');
      }
    } else {
      print('Authentication failed');
    }
    } catch (e) {
      print("error using biometric auth: $e");
    }
}
    return isAuthenticated;
  }
}

 Future<String?> _readUserDataFromSDCard() async {
    try {
      // Get the external storage directory
      Directory? externalDir = await getExternalStorageDirectory();

      if (externalDir != null) {
        // Construct the path to the file on the SD card
        String filePath = '${externalDir.path}/userdata.txt';

        // Read data from the file
        File file = File(filePath);
        if (await file.exists()) {
          String contents = await file.readAsString();
          // Return the user data read from the file
          return contents;
        } else {
          print('File does not exist');
          return null;
        }
      } else {
        print('External storage directory not available');
        return null;
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
      return null;
    }
  }