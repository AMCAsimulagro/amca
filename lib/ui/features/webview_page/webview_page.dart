/// {@category UserInterface}
/// A widget representing a web view page.
library;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  /// Constructs a [WebViewPage] with the given [title] and [url].
  const WebViewPage({
    super.key,
    required this.title,
    required this.url,
  });

  /// The title of the web view page.
  final String title;

  /// The URL of the web page to load.
  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    // Initialize the web view controller with the provided URL.

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            // Handle page started event.
          },
          onPageFinished: (String url) {
            // Handle page finished loading event.
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource error.
          },
          onNavigationRequest: (NavigationRequest request) {
            // Handle navigation request.
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    // #enddocregion webview_controller
  }

  // #docregion webview_widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: WebViewWidget(controller: controller),
    );
  }
}
