import 'package:flutter/material.dart';
import 'package:supreme/webview.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WebViewMain());
  }
}
