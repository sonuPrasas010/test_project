import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewController extends GetxController {
  InAppWebViewController? webViewController;
  RxInt progress = 0.obs;
  final String url;

  WebViewController(this.url);

  Rx<InAppWebView>? inAppWebView;

  @override
  void onInit() {
    inAppWebView = InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(url)),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          incognito: true,
          supportZoom: false,
          minimumFontSize: 14,
          cacheEnabled: false,
          transparentBackground: true,
        ),
      ),
      shouldOverrideUrlLoading: (webViewController, url) async {
        // if (url.request.url!.host.contains("streamtape") ||
        //     url.request.url!.host.contains("doodstream"))
        //   return NavigationActionPolicy.ALLOW;
        // else {
        // InAppBrowser().openUrlRequest(
        //     urlRequest: URLRequest(url: (url.request.url)));
        // InAppBrowser b = InAppBrowser();
        // InAppBrowser.openWithSystemBrowser(url: url.request.url!);
        // _launchURL(context, url.request.url!.toString());

        return NavigationActionPolicy.CANCEL;
        // }
      },
      onProgressChanged: (_, int progress) {
        this.progress(progress);
      },
    ).obs;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);

    super.onInit();
  }

  @override
  void onClose() {
    inAppWebView = null;
    webViewController = null;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.onClose();
  }
}
