# wayf_login_udc

Apllicación que funciona como plantilla y package para la autenticación federada para la universidad de colima
Se proveen las screens necesarias para un login con el sistema SIMPLESAML de la universidad de colima

## Contenido

### WayfWebViewScreen

Provee el widget que se conecta a la dederación, recive un callback que es llamado al recivir los datos de la federación

### WayfLoginButtonScreen

Provee de una pantalla antes de **WayfWebViewScreen** con el logo de la universidad y un botón que abre la pagina de la federación

## Uso

### Plantilla

Puedes usar este repositorio desde github o accediendo a este [link][generate_repo]  
[generate_repo]: https://github.com/ulises214/wayf_login_udc/generate

Este repositorio es una aplicación completa que puedes correr ejecutando

Contiene los iconos para android y una aplicación de entrada en app.dart

```bash
flutter run
```

### Package

En tu pubspec.yaml agrega la siguiente dependencia

```yaml
wayf_login_udc:
    git:
        url: https://github.com/ulises214/wayf_login_udc.git
        ref: main
```

Importa el paquete en donde necesites usar los widget **WayfWebViewScreen**
**WayfLoginButtonScreen**

```dart
import 'package:wayf_login_udc/wayf_login_udc.dart';
```

## For developers

Occasionally run

```bash
dart format --fix -l 80 lib
flutter pub run import_sorter:main
```

Or if yu're using fvm

```bash
dart format --fix -l 80 lib
fvm flutter pub run import_sorter:main
```
