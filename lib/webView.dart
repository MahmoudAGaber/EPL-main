import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class webView extends StatefulWidget {
  String url;
  webView({this.url});
  @override
  _webViewState createState() => _webViewState();
}

TextStyle _textStyletitle = TextStyle(fontFamily: 'Vazirmatn', fontSize: 18);

class _webViewState extends State<webView> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            actionsIconTheme: IconThemeData(color: Colors.white),
          ),
          body: WebView(
            initialUrl: "${widget.url}?r=mobile",
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }
}
