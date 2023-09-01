part of 'constants_library.dart';

/// HTTP constants
abstract class UdcHttp {
  static const _baseHttpURL = 'https://sistemas3.ucol.mx/controlacceso/app';

  /// Login URL
  static const loginWebViewUrl = '$_baseHttpURL/login';

  /// Logout URL
  static const logoutWebViewUrl = '$_baseHttpURL/logout';
}
