part of 'models_library.dart';

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
    required this.tipoCuenta,
    required this.uo,
  });

  /// Create a [WayfLoginModel] from a JSON object
  factory WayfLoginModel.fromJson(Map<String, dynamic> json) {
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
      tipoCuenta: _getProperty(json, 'TipoCuenta'),
      uo: _getProperty(json, 'UO'),
    );
  }

  static T _getProperty<T>(
    Map<String, dynamic> json,
    String property,
  ) {
    final prop = json[property];
    if (prop == null) {
      if (null is T) return prop as T;

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

  /// Convert the [WayfLoginModel] to a JSON object
  Map<String, dynamic> toJson() {
    const data = <String, dynamic>{};
    data['uCorreo'] = [uCorreo];
    data['uNombre'] = [uNombre];
    data['uDependencia'] = [uDependencia];
    data['uCuenta'] = [uCuenta];
    data['uTrabajador'] = [uTrabajador];
    data['uTipo'] = [uTipo];
    data['cn'] = [cn];
    data['sn'] = [sn];
    data['ImmutableID'] = [immutableID];
    data['givenName'] = [givenName];
    data['token'] = [token];
    data['displayName'] = [displayName];
    data['UO'] = [uo];
    data['TipoCuenta'] = [tipoCuenta];
    return data;
  }
}
