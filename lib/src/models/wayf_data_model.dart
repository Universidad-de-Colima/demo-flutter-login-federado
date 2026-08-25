part of 'models_library.dart';

/// Thrown when the federation returns an error payload (e.g.
/// `{"error": "Acceso no autorizado x org"}`) instead of login data.
class WayfLoginException implements Exception {
  /// Creates a [WayfLoginException] with the [message] returned by the
  /// federation
  WayfLoginException(this.message);

  /// The error message returned by the federation
  final String message;

  @override
  String toString() => 'WayfLoginException: $message';
}

/// The information returned by the federation is typed in this class
///
/// Each field is a list of String but are lists of a single element
/// The lists will always have one field that can be an empty string
/// when there is no data
class WayfLoginModel {
  /// Model for the data returned by the federated login
  WayfLoginModel({
    required this.uCorreo,
    required this.uNombre,
    required this.uDependencia,
    required this.uCuenta,
    required this.uTrabajador,
    required this.uTipo,
    required this.cn,
    required this.sn,
    required this.displayName,
    required this.immutableID,
    required this.givenName,
    required this.token,
    required this.authToken,
    required this.tipoCuenta,
    required this.uo,
    required this.sessionCreated,
  });

  /// Create a [WayfLoginModel] from a JSON object
  factory WayfLoginModel.fromJson(Map<String, dynamic> json) {
    final error = json['error'];
    if (error != null) throw WayfLoginException(error.toString());

    final jsonDate = _getProperty<String?>(json, 'sessionCreated');
    return WayfLoginModel(
      uCorreo: _getProperty(json, 'uCorreo'),
      uNombre: _getProperty(json, 'uNombre'),
      uDependencia: _getProperty(json, 'uDependencia'),
      uCuenta: _getProperty(json, 'uCuenta'),
      uTrabajador: _getProperty(json, 'uTrabajador'),
      uTipo: _getProperty(json, 'uTipo'),
      cn: _getProperty(json, 'cn'),
      sn: _getProperty(json, 'sn'),
      displayName: _getProperty(json, 'displayName'),
      immutableID: _getProperty(json, 'ImmutableID'),
      givenName: _getProperty(json, 'givenName'),
      token: _getProperty(json, 'token'),
      // Unlike the other fields, `auth` arrives from the IdP as a plain
      // string (the signed session JWT), not wrapped in a single-element
      // list, so it can't go through `_getProperty`.
      authToken: json['auth'] as String? ?? '',
      tipoCuenta: _getProperty(json, 'TipoCuenta'),
      uo: _getProperty(json, 'UO'),
      sessionCreated: jsonDate == null
          ? DateTime.now().toLocal()
          : DateTime.parse(jsonDate).toLocal(),
    );
  }

  static T _getProperty<T>(
    Map<String, dynamic> json,
    String property,
  ) {
    final prop = json[property];
    if (prop == null || (prop is List && prop.isEmpty)) {
      if (null is T) return null as T;
      // The federation does not always return every attribute (e.g. some
      // accounts have no `token`); default to an empty string rather than
      // crashing the whole login flow over a field nothing depends on.
      if ('' is T) return '' as T;

      throw Exception('Property not found');
    }
    if (prop is List) {
      final first = prop.first;
      return first as T;
    }
    throw Exception('Invalid json prop');
  }

  /// The email of the user
  String uCorreo;

  /// The name of the user
  String uNombre;

  /// The dependency of the user
  String uDependencia;

  /// The account number of the user
  String uCuenta;

  /// The employee number of the user
  String uTrabajador;

  /// The type of user
  String uTipo;

  /// The cn of the user
  String cn;

  /// The sn of the user
  String sn;

  /// The display name of the user
  String displayName;

  /// Check the type of the account (ej. Personal)
  String tipoCuenta;

  /// "UO",  no info about this. (ej. Alumnos activos)
  String? uo;

  /// The immutable id of the user
  String immutableID;

  /// The given name of the user
  String? givenName;

  /// The token of the user
  String token;

  /// Signed session JWT (HS256) returned by the federation as `auth`. Used
  /// to validate/expire a cached session locally without re-authenticating
  /// against the IdP.
  String authToken;

  /// When this session is created, useful for retake the session
  /// without login again
  DateTime sessionCreated;

  /// Convert the [WayfLoginModel] to a JSON object
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'uCorreo': [uCorreo],
      'uNombre': [uNombre],
      'uDependencia': [uDependencia],
      'uCuenta': [uCuenta],
      'uTrabajador': [uTrabajador],
      'uTipo': [uTipo],
      'cn': [cn],
      'sn': [sn],
      'ImmutableID': [immutableID],
      'givenName': [givenName],
      'token': [token],
      'auth': authToken,
      'displayName': [displayName],
      'UO': [uo],
      'TipoCuenta': [tipoCuenta],
      'sessionCreated': [sessionCreated.toIso8601String()],
    };
    return data;
  }
}
