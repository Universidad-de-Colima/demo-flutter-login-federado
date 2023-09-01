// 🐦 Flutter imports:
import 'package:flutter/material.dart';
// 🌎 Project imports:
import 'package:wayf_login_udc/src/widgets/templates/simple_scaffold_template.dart';
// 📦 Package imports:
import 'package:webview_flutter/webview_flutter.dart';

/// Wrapper for [WebViewWidget] that allows to set the initial url and the
/// channel message
class WebViewTemplate extends StatefulWidget {
  /// Creates a webview that allow to omit the [WebViewController] creation
  const WebViewTemplate({
    required this.initialUrl,
    required this.onMessageReceived,
    required this.channelMessage,
    required this.title,
    super.key,
  });

  /// Initial url to be loaded
  final String initialUrl;

  /// Channel message to be used
  final String channelMessage;

  /// Callback to be called when a message is received
  final void Function(JavaScriptMessage message) onMessageReceived;

  /// The title to display in a [AppBar]
  final String title;

  @override
  State<WebViewTemplate> createState() => _WebViewTemplateState();
}

class _WebViewTemplateState extends State<WebViewTemplate> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white70)
      ..loadRequest(Uri.parse(widget.initialUrl))
      ..addJavaScriptChannel(
        widget.channelMessage,
        onMessageReceived: widget.onMessageReceived,
      );
  }

  @override
  void dispose() {
    _controller.removeJavaScriptChannel(widget.channelMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleScaffoldTemplate(
      title: widget.title,
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
