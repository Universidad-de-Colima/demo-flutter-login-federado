// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:wayf_login_udc/src/constants/constants_library.dart';
import 'package:wayf_login_udc/src/models/models_library.dart';
import 'package:wayf_login_udc/src/view/screens/screens_library.dart';

/// Esta es una aplicación de prueba, puede usarse posteriormente como plantilla
class WayfLoginUDCApp extends StatelessWidget {
  /// Crea una aplicación de prueba
  const WayfLoginUDCApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: UdcColors.actionPrimaryActive,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      title: 'Wayf Login UdC',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => WayfLoginButtonScreen(
              onWayfResolve: (data) => _onWayfResolve(data, context),
              title: const Image(
                image: UdcAssets.logoAsistencias,
              ),
            ),
      },
    );
  }

  void _onWayfResolve(WayfLoginModel wayfData, BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (context) => LoginResultScreen(data: wayfData),
      ),
      (route) => false,
    );
  }
}
