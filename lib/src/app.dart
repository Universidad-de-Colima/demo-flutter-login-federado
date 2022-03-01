// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:wayf_login_udc/src/models/models_library.dart';
import 'package:wayf_login_udc/src/view/screens/screens_library.dart';

/// Esta es una aplicación de prueba, puede usarse posteriormente como plantilla
class WayfLoginUDCApp extends StatelessWidget {
  const WayfLoginUDCApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(brightness: Brightness.dark),
      title: 'Wayf Login UdC',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => WayfLoginButtonScreen(
              onWayfResolve: (data) => _onWayfResolve(data, context),
            ),
      },
    );
  }

  void _onWayfResolve(WayfLoginModel wayfData, BuildContext context) {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => LoginResultScreen(data: wayfData),
      ),
    );
  }
}
