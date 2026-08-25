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
    this.userAgent,
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

  /// User agent to be used by the webview; if null, the platform default is
  /// used
  final String? userAgent;

  @override
  State<WebViewTemplate> createState() => _WebViewTemplateState();
}

class _WebViewTemplateState extends State<WebViewTemplate> {
  late final WebViewController _controller;
  // bool _hasError = false;
  // String _errorMessage = '';

  // Future<void> _loadUrl() async {
  //   setState(() {
  //     _hasError = false;
  //   });
  //   try {
  //     await _controller.loadRequest(Uri.parse(widget.initialUrl));
  //   } catch (e) {
  //     setState(() {
  //       _hasError = true;
  //       _errorMessage = 'Failed to load URL: $e';
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white70);

    if (widget.userAgent != null) {
      _controller.setUserAgent(widget.userAgent);
    }

    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        // onPageFinished: (String url) {
        //   setState(() {
        //     _hasError = false;
        //     _errorMessage = '';
        //   });
        //   print('Page finished loading: $url');
        // },
        // onWebResourceError: (WebResourceError error) {
        //   setState(() {
        //     _hasError = true;
        //     _errorMessage =
        //         '${error.description}\nError code: ${error.errorCode}';
        //   });
        //   print('Error: ${error.description}');
        // },
      ),
    );

    _controller.addJavaScriptChannel(
      widget.channelMessage,
      onMessageReceived: widget.onMessageReceived,
    );

    _controller.loadRequest(Uri.parse(widget.initialUrl));

    // _loadUrl(); // Initial load
  }

  @override
  void dispose() {
    _controller.removeJavaScriptChannel(widget.channelMessage);
    super.dispose();
  }

  // Widget _buildErrorDisplay() {
  //   return Center(
  //     child: Container(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Icon(
  //             Icons.error_outline,
  //             color: Colors.red,
  //             size: 48,
  //           ),
  //           const SizedBox(height: 16),
  //           Text(
  //             'Ha ocurrido un error',
  //             style: Theme.of(context).textTheme.titleLarge?.copyWith(
  //                   color: Colors.red,
  //                 ),
  //           ),
  //           const SizedBox(height: 8),
  //           Text(
  //             _errorMessage,
  //             textAlign: TextAlign.center,
  //             style: Theme.of(context).textTheme.bodyMedium,
  //           ),
  //           const SizedBox(height: 16),
  //           ElevatedButton(
  //             onPressed: _loadUrl, // Use _loadUrl instead of reload()
  //             child: const Text('Intentar de nuevo'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SimpleScaffoldTemplate(
      title: widget.title,
      body:
          // _hasError
          // ? _buildErrorDisplay()
          // :
          WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
