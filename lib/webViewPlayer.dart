import 'package:flutter/material.dart';
  import 'package:get/get.dart';
 
import 'controller/webview_controller.dart';

class WebViewPlayer extends StatelessWidget {
  final String url;
  late WebViewController _webViewController;
  WebViewPlayer({required this.url}) {
    _webViewController = Get.put(WebViewController(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Center(
            child: SizedBox(
              height: double.maxFinite,
              child: Column(
                children: [
                  Expanded(
                    child:
                        _webViewController.inAppWebView?.value ?? Container(),
                  ),
                  if (_webViewController.progress.value < 100)
                    Text(
                      "Video Is Loading: ${_webViewController.progress.value}%",
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
