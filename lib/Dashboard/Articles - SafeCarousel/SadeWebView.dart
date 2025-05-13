import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:womensafteyhackfair/constants.dart';

class SafeWebView extends StatefulWidget {
  final String url;
  final String title;
  final int index;

  const SafeWebView({
    Key? key,
    required this.url,
    required this.title,
    required this.index,
  }) : super(key: key);

  @override
  State<SafeWebView> createState() => _SafeWebViewState();
}

class _SafeWebViewState extends State<SafeWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: CircleAvatar(
          backgroundColor: CupertinoColors.systemGrey5,
          backgroundImage: NetworkImage(imageSliders[widget.index]),
        ),
      ),
      child: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
