import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'app/app.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
// ignore: unused_local_variable
LocationPermission permission = await Geolocator.requestPermission();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}
