part of models;

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
  });

  /// Create a [WayfLoginModel] from a JSON object
  factory WayfLoginModel.fromJson(Map<String, dynamic> json) {
    return WayfLoginModel(
      // ignore: avoid_dynamic_calls
      uCorreo: json['uCorreo'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      uNombre: json['uNombre'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      uDependencia: json['uDependencia'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      uCuenta: json['uCuenta'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      uTrabajador: json['uTrabajador'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      uTipo: json['uTipo'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      cn: json['cn'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      sn: json['sn'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      displayName: json['displayName'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      immutableID: json['ImmutableID'].cast<String>() as List<String>,
      // ignore: avoid_dynamic_calls
      givenName: json['givenName'].cast<String>() as List<String>,
    );
  }

  /// The email of the user
  List<String> uCorreo;

  /// The name of the user
  List<String> uNombre;

  /// The dependency of the user
  List<String> uDependencia;

  /// The account number of the user
  List<String> uCuenta;

  /// The employee number of the user
  List<String> uTrabajador;

  /// The type of user
  List<String> uTipo;

  /// The cn of the user
  List<String> cn;

  /// The sn of the user
  List<String> sn;

  /// The display name of the user
  List<String> displayName;

  /// The immutable id of the user
  List<String> immutableID;

  /// The given name of the user
  List<String> givenName;

  /// Convert the [WayfLoginModel] to a JSON object
  Map<String, dynamic> toJson() {
    const data = <String, dynamic>{};
    data['uCorreo'] = uCorreo;
    data['uNombre'] = uNombre;
    data['uDependencia'] = uDependencia;
    data['uCuenta'] = uCuenta;
    data['uTrabajador'] = uTrabajador;
    data['uTipo'] = uTipo;
    data['cn'] = cn;
    data['sn'] = sn;
    data['displayName'] = displayName;
    data['ImmutableID'] = immutableID;
    data['givenName'] = givenName;
    return data;
  }
}
