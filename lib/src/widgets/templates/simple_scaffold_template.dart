// 📦 Package imports:
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';

// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

/// Expose a simple scaffold template with an adaptive app bar
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

  /// The title to display in the app bar
  final String title;

  /// The actions to display in the app bar
  final List<AdaptiveAppBarAction>? actions;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: title, actions: actions),
      body: body,
    );
  }
}
