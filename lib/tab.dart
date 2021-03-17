import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebTab extends StatefulWidget {
  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<WebTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InAppWebView(
      onReceivedHttpAuthRequest: (controller, request) {
        print(request.toJson());
      },
      onUpdateVisitedHistory: (c, u, b) {},
      initialUrlRequest:
          URLRequest(url: Uri.parse('https://www.supremenewyork.com/')),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(incognito: true),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
