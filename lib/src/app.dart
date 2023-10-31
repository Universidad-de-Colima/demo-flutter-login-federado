import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wayf_login_udc/src/constants/constants_library.dart';
import 'package:wayf_login_udc/src/models/models_library.dart';
import 'package:wayf_login_udc/src/view/screens/screens_library.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
final _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

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
              loadExistingLogin: () async {
                final data = await _storage.read(key: 'loginData');
                if (data == null) return null;
                return WayfLoginModel.fromJson(
                  json.decode(data) as Map<String, dynamic>,
                );
              },
              validateExistingLogin: (data) {
                final now = DateTime.now();
                final sessionCreated = data.sessionCreated;
                final expires = sessionCreated.copyWith(
                  day: sessionCreated.day + 1,
                );
                return now.isBefore(expires);
              },
              title: Image.asset(
                UdcAssets.logoAsistencias,
              ),
            ),
      },
    );
  }

  void _onWayfResolve(WayfLoginModel wayfData, BuildContext context) {
    _storage.write(
      key: 'loginData',
      value: json.encode(wayfData.toJson()),
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (context) => LoginResultScreen(
          onLogout: () async {
            await _storage.delete(key: 'loginData');
          },
          data: wayfData,
        ),
      ),
      (route) => false,
    );
  }
}
