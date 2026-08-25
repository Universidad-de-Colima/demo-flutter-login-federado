part of 'constants_library.dart';

/// Wayf callback function
typedef OnWayfResolve = void Function(WayfLoginModel);

/// Callback called when the federation returns an error instead of a
/// successful login payload (e.g. an unauthorized-organization response)
typedef OnWayfError = void Function(String message);
