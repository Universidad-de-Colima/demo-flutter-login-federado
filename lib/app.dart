// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:wayf_login_udc/view/screens/screens_library.dart';

class WayfLoginUDCApp extends StatelessWidget {
  const WayfLoginUDCApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wayf Login UdC',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
