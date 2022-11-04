import 'dart:developer';

import 'package:datacoup/export.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewWidget extends StatelessWidget {
  final String? url;
  final bool? showAppbar;
  const WebViewWidget({super.key, this.showAppbar = false, this.url});

  @override
  Widget build(BuildContext context) {
    // InAppWebViewController? webViewController;
    return Scaffold(
      appBar: showAppbar! ? AppBar() : null,
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.tryParse(url!)),
        initialOptions:
            InAppWebViewGroupOptions(crossPlatform: InAppWebViewOptions()),
        onWebViewCreated: (InAppWebViewController controller) {
          // webViewController = controller;
        },
        onLoadStart: (controller, url) {
          log('page loaded on => $url');
        },
      ),
    );
  }
}
