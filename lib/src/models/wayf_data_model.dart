part of models;

/// La información que es devuelta por la federación es tipada en esta clase
///
/// Cada campo es una lista de String pero son listas de un solo elemento
/// Las listas siempre tendrán un campo que puede ser una cadena vacía cuando no
/// hay datos
class WayfLoginModel {
  /// Crea los datos tipados cuando el login ha sido exitoso
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
  List<String> uCorreo;
  List<String> uNombre;
  List<String> uDependencia;
  List<String> uCuenta;
  List<String> uTrabajador;
  List<String> uTipo;
  List<String> cn;
  List<String> sn;
  List<String> displayName;
  List<String> immutableID;
  List<String> givenName;

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
