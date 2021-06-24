// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:wayf_login_udc/view/screens/screens_library.dart';

class WayfLoginUDCApp extends StatelessWidget {
  const WayfLoginUDCApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(brightness: Brightness.dark),
      title: 'Wayf Login UdC',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(
        onWayfResolve: (wayfData) {
          print(wayfData.displayName);
        },
      ),
    );
  }
}
