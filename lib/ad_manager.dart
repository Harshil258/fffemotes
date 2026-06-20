import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'screens/interstitial_ad_screen.dart';

class AdManager {
  AdManager._();

  static int _clickCount = 0;
  static bool _firebaseInitialized = false;

  /// Initialize Firebase Core and Remote Config
  static Future<void> initialize() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      _firebaseInitialized = true;
      debugPrint("Firebase successfully initialized in AdManager.");

      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 0),
        minimumFetchInterval: const Duration(minutes: 0), // Short interval for responsive updates
      ));

      await remoteConfig.setDefaults(const {
        'ad_interval': 3,
        'ad_link': 'www.google.com',
      });

      // Fetch latest values from the cloud
      await remoteConfig.fetchAndActivate();
      debugPrint("Remote Config successfully fetched and activated: "
          "interval=${remoteConfig.getInt('ad_interval')}, link=${remoteConfig.getString('ad_link')}");
    } catch (e) {
      debugPrint("AdManager: Firebase or Remote Config failed to initialize: $e");
      debugPrint("AdManager: Falling back to local default values.");
    }
  }

  /// Get the click interval threshold (N)
  static int get adInterval {
    if (_firebaseInitialized) {
      try {
        final val = FirebaseRemoteConfig.instance.getInt('ad_interval');
        // Prevent zero or negative values causing infinite loops or divisions
        return val > 0 ? val : 3;
      } catch (e) {
        debugPrint("Error reading ad_interval from Remote Config: $e");
      }
    }
    return 3; // Fallback default
  }

  /// Get the target link/url for WebView
  static String get adLink {
    if (_firebaseInitialized) {
      try {
        final val = FirebaseRemoteConfig.instance.getString('ad_link');
        if (val.isNotEmpty) return val;
      } catch (e) {
        debugPrint("Error reading ad_link from Remote Config: $e");
      }
    }
    return "www.google.com"; // Fallback default
  }

  /// Increment click count and show ad screen if threshold reached.
  /// Executes [onProceed] immediately (if count < N) or after the user closes the ad.
  static void showAdWithCallback(BuildContext context, VoidCallback onProceed) {
    _clickCount++;
    final threshold = adInterval;
    debugPrint("AdManager: Click count is $_clickCount / $threshold");
    if (_clickCount >= threshold) {
      _clickCount = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InterstitialAdScreen(url: adLink),
        ),
      ).then((_) {
        onProceed();
      });
    } else {
      onProceed();
    }
  }
}
