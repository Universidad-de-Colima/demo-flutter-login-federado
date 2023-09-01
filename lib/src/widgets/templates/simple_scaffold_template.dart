// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// 🌎 Project imports:
import 'package:wayf_login_udc/wayf_login_udc.dart';

/// Expose a simple scaffold template with styles app bar
class SimpleScaffoldTemplate extends StatelessWidget {
  /// Create a simple scaffold template
  const SimpleScaffoldTemplate({
    required this.body,
    required this.title,
    super.key,
    this.actions,
  });

  /// The body of the scaffold
  final Widget body;

  /// The title to display in a [AppBar]
  final String title;

  /// The actions to display in a [AppBar]
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UdcColors.actionPrimaryActive,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.white,
        ),
        actions: actions,
        title: Row(
          children: [
            Text(title),
          ],
        ),
      ),
      body: body,
    );
  }
}
