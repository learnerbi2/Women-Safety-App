import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:workmanager/workmanager.dart';

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

/// Android & iOS onStart logic
void onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  service.on('setAsForeground').listen((event) {
    if (service is AndroidServiceInstance) {
      service.setAsForegroundService();
    }
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
  }

  Location? _location;

  await BackgroundLocation.setAndroidNotification(
    title: "Location tracking is running in the background!",
    message: "You can turn it off from settings menu inside the app",
    icon: '@mipmap/ic_logo',
  );

  await BackgroundLocation.startLocationService(distanceFilter: 20);

  BackgroundLocation.getLocationUpdates((location) {
    _location = location;
    prefs.setStringList("location",
        [location.latitude.toString(), location.longitude.toString()]);
  });

  // Keep screenShake at top-level of onStart
  String screenShake = "Be strong, We are with you!";

  // Move _sendSOS out of any function
  Future<void> _sendSOS() async {
    if (await Vibration.hasVibrator()) {
      if (await Vibration.hasCustomVibrationsSupport()) {
        Vibration.vibrate(duration: 1000);
      } else {
        Vibration.vibrate();
        await Future.delayed(Duration(milliseconds: 500));
        Vibration.vibrate();
      }
    }

    try {
      double lat = _location?.latitude ?? 0.0;
      double long = _location?.longitude ?? 0.0;
      String link = "http://maps.google.com/?q=$lat,$long";

      List<String> numbers = prefs.getStringList("numbers") ?? [];

      if (numbers.isEmpty) {
        screenShake =
            "No contacts found. Please call emergency services ASAP.";
        debugPrint('No Contacts Found!');
      } else {
        for (String number in numbers) {
          Telephony.backgroundInstance.sendSms(
            to: number,
            message: "Help Me! Track me here.\n$link",
          );
        }
        prefs.setBool("alerted", true);
        screenShake = "SOS alert Sent! Help is on the way.";
      }
    } on PlatformException catch (e) {
      debugPrint("Platform Exception: ${e.code}");
    } catch (e) {
      debugPrint("Exception: $e");
    }
  }

 void handleShakeEvent(ShakeEvent) {
  _sendSOS(); // You can still call your async function here
}


ShakeDetector.autoStart(
  shakeThresholdGravity: 7,
  onPhoneShake: handleShakeEvent,
);

  Timer.periodic(Duration(seconds: 1), (timer) async {
    final isRunning = await FlutterBackgroundService().isRunning();
if (!isRunning) timer.cancel();

    // Use this if you need to send UI updates
    service.invoke('update', {
      "current_date": DateTime.now().toIso8601String(),
      "status": screenShake,
    });
  });
}
/// Periodic task (15 min) using WorkManager
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    final contact = inputData?['contact'] ?? '';
    List<String> location = prefs.getStringList("location") ?? ['0.0', '0.0'];
    String link = "http://maps.google.com/?q=${location[0]},${location[1]}";

    Telephony.backgroundInstance.sendSms(
      to: contact,
      message: "I am on my way! Track me here.\n$link",
    );

    return Future.value(true);
  });
}
