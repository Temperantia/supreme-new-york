import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:supreme/tab.dart';
import 'package:http_proxy/http_proxy.dart';

class WebViewMain extends StatefulWidget {
  @override
  WebViewMainState createState() => WebViewMainState();
}

class WebViewMainState extends State<WebViewMain>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int index = 0;
  List<List<Cookie>> cookieList = [[], []];
  List<Uri> urls = [
    Uri.parse('https://www.supremenewyork.com/mobile'),
    Uri.parse('https://www.supremenewyork.com/mobile'),
  ];
  List<List<WebStorageItem>> localStorage = [[], []];
  List<InAppWebViewController?> controllers = [null, null];
  List<Map<String, String>> proxies = [
    {'host': '62.23.15.92', 'port': '3128'},
    {'host': '62.210.110.6', 'port': '3128'},
  ];
  late HttpProxy httpProxy;

  @override
  void initState() {
    super.initState();

    init();

    _controller = TabController(vsync: this, length: 2);
    _controller.addListener(() async {
      if (_controller.indexIsChanging) {
        print('current tab : ' + index.toString());

        /*  CookieManager.instance().deleteAllCookies();

        index = _controller.index;

        httpProxy.host = proxies[index]['host'];
        httpProxy.port = proxies[index]['port'];
        HttpOverrides.global = httpProxy;

        print(cookieList[index].length);
        for (final cookie in cookieList[index]) {
          CookieManager.instance().setCookie(
            url: urls[index],
            name: cookie.name,
            value: cookie.value,
            /* domain: cookie.domain,
            path: cookie.path,
            expiresDate: cookie.expiresDate,
            isSecure: cookie.isSecure,
            isHttpOnly: cookie.isHttpOnly,
            sameSite: cookie.sameSite, */
          );
        } */
        /* LocalStorage(controllers[index]).clear();

        for (final item in localStorage[index]) {
          LocalStorage(controllers[index])
              .setItem(key: item.key, value: item.value);
        } */
      }
    });
  }

  Future init() async {
    httpProxy = await HttpProxy.createHttpProxy();

    httpProxy.host = proxies[index]['host'];
    httpProxy.port = proxies[index]['port'];
    HttpOverrides.global = httpProxy;
  }

  void onUpdate(Uri url, List<Cookie> cookies,
      InAppWebViewController controller, List<WebStorageItem> items) {
    urls[index] = url;
    cookieList[index] = cookies;
    controllers[index] = controller;
    localStorage[index] = items;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
        appBar: TabBar(
          controller: _controller,
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
          ],
        ),
        body: TabBarView(controller: _controller, children: [
          WebTab(onUpdate),
          WebTab(onUpdate),
        ]),
      )),
    );
  }
}
